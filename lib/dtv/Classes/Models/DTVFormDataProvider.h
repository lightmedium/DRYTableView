//
//  DTVFormDataProvider.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DTVFormSection;
@class DTVFormField;

@interface DTVFormDataProvider : NSObject

// array of sections in the form
@property (nonatomic, strong) NSMutableArray *sections;

+ (DTVFormDataProvider *)initWithFormDefinition:(NSDictionary *)formDef;

// convenience methods for accessing section and field models by index path
- (DTVFormSection *)sectionModelForIndexPath:(NSIndexPath *)indexPath;
- (DTVFormField *)fieldModelForIndexPath:(NSIndexPath *)indexPath;

// kick off form validation
- (BOOL)validateRequiredCells;

@end
