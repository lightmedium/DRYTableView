//
//  DTVConfigDrivenTableViewCell.m
//  DTVTableView
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "DTVConfigDrivenTableViewCell.h"
#import "DTVFormField.h"

@implementation DTVConfigDrivenTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(id<DTVPersistentModelProtocol>)model fieldDefinition:(DTVFormField *)fieldDef;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _model = model;
        _fieldDefinition = fieldDef;
    }
    return self;
}

// abstract method for validating bound property of cell
- (BOOL)validateInput;
{
    NSError *error = nil;
    
    // valueForBoundProperty implemented in concrete subclasses
    id newValue = [self valueForBoundProperty];
    
    // validate the value
    BOOL fieldIsValid = [[self model] validateValue:&newValue forKey:[[self fieldDefinition] boundProperty] error:&error];
    
    if (fieldIsValid && (error == nil))
    {
        // TODO check that the setter exists.
        [[self model] setValue:newValue forKey:[[self fieldDefinition] boundProperty]];
        [self setBackgroundColor:[UIColor whiteColor]];
        return YES;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please correct your entry." message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [self setBackgroundColor:[UIColor colorWithRed:1.0f green:0.95f blue:0.95f alpha:1.0f]];
    return NO;
}

- (id)valueForBoundProperty;
{
    NSAssert(NO, @"\n\n\nYOU MUST IMPLEMENT (id)valueForBoundProperty in the cell\n\n\n");
    return nil;
}

@end
