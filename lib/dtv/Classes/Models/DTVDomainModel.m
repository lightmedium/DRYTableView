//
//  WDCLead.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "DTVDomainModel.h"
#import "NSMutableString+Utilities.h"

@interface DTVDomainModel()
{
    BOOL _skipValidation;
}
@end

@implementation DTVDomainModel

static DTVDomainModel *sharedInstance;
static NSDictionary *prototypeObject;

NSString *const kValidationErrorDomain = @"ValidationErrorDomain";


// hydrate a dictionary to send to the service, containing the instances property values.
- (NSDictionary *)serializedForSave;
{
    NSMutableDictionary *fieldsForSave = [NSMutableDictionary dictionary];
    
    [prototypeObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSMutableString *mutableKey = [key mutableCopy];
        NSString *selectorString = [mutableKey unCapitalize];
        SEL getter = NSSelectorFromString(selectorString);
        if ([self respondsToSelector:getter])
        {
            // TODO: make sure that ARC doesn't leak memory here before going into production.
            NSObject *value = (NSObject *)[self performSelector:getter];
            if (value)
            {
                [fieldsForSave setObject:value forKey:key];
            }
        }
    }];
    return fieldsForSave;
}

// encapsulate the logic for determining whether or not the
// record is new.
- (BOOL)isNew;
{
    
}

// encapsulate the logic for determining whether or not the
// record can be edited.
- (BOOL)isMutable;
{
    
}

@end
