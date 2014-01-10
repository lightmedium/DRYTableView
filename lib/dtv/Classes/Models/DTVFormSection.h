//
//  DTVFormSection.h
//  DTVTableView
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTVFormSection : NSObject

// an array of fields in the section
@property (nonatomic, strong) NSMutableArray *fields;

+ (DTVFormSection *)initWithSectionDefinition:(NSDictionary *)sectionDef;

@end
