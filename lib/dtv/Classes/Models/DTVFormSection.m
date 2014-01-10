//
//  WDCFormSection.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "DTVFormSection.h"
#import "DTVFormField.h"

@implementation DTVFormSection

// traverse fields in the section, initializing WDCFormField models
+ (DTVFormSection *)initWithSectionDefinition:(NSDictionary *)sectionDef;
{
    DTVFormSection *section = [[DTVFormSection alloc] init];
    
    NSArray *rawFields = [sectionDef valueForKey:@"fields"];
    
    NSMutableArray *fields = [NSMutableArray array];
    
    [rawFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DTVFormField *f = [DTVFormField initWithFieldDefinition:(NSDictionary*)obj];
        [fields addObject:f];
    }];
    [section setFields:fields];
    return section;
}

@end
