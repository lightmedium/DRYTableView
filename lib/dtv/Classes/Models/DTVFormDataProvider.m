//
//  WDCFormDataProvider.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "DTVFormDataProvider.h"
#import "DTVFormSection.h"
#import "DTVFormField.h"

@implementation DTVFormDataProvider

// crawl over the form definition dictionary and serialize data into
// a WDCFormDataProvider and its models
+ (DTVFormDataProvider *)initWithFormDefinition:(NSDictionary *)formDef;
{
    DTVFormDataProvider *dp = [[DTVFormDataProvider alloc] init];
    
    NSArray *rawSections = [formDef valueForKey:@"sections"];
    
    NSMutableArray *sections = [NSMutableArray array];
    
    [rawSections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DTVFormSection *s = [DTVFormSection initWithSectionDefinition:(NSDictionary*)obj];
        [sections addObject:s];
    }];
    [dp setSections:sections];
    return dp;
}

#pragma mark - Form Data Access Helpers
- (DTVFormSection *)sectionModelForIndexPath:(NSIndexPath *)indexPath
{
    return [[self sections] objectAtIndex:indexPath.section];
}

- (DTVFormField *)fieldModelForIndexPath:(NSIndexPath *)indexPath
{
    DTVFormSection *section = [self sectionModelForIndexPath:indexPath];
    return [[section fields] objectAtIndex:indexPath.row];
}

- (BOOL)validateRequiredCells;
{
    BOOL __block isValid = YES;
    
    // traverse the sections and fields. as soon as we find one that is invalid, stop and return NO.
    [[self sections] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DTVFormSection *section = (DTVFormSection *)obj;
        
        [[section fields] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            DTVFormField *field = (DTVFormField *)obj;
            
            // we tell the fields to validate.
            // fields tell their cells to validate.
            // the cell is the junction of configuration, domain model, and current state.
            // ordinarily this would be a violation of MVC, but I don't see it that
            // way since there is no view-specific logic present that wouldn't still
            // be present should the validation logic be orchestrated by a controller.
            if (![field validate])
            {
                isValid = NO;
                *stop = YES;
            }
        }];
        if (!isValid) *stop = YES;
    }];
    return isValid;
}

@end
