//
//  DTVTextInputCell.m
//  DTVTableView
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTVTextInputCell.h"
#import "DTVFormField.h"
#import "DTVDomainModel.h"

@implementation DTVTextInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(id<DTVPersistentModelProtocol>)model fieldDefinition:(DTVFormField *)fieldDef;
{
    // cells are responsible for encapsulating their layout, style, and mapping of data
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier model:model fieldDefinition:fieldDef]))
    {
        NSObject<DTVPersistentModelProtocol>*domainModel = (NSObject<DTVPersistentModelProtocol> *)[self model];
        _inputField = [[UITextField alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:_inputField];
        
        [_inputField setDelegate:self];
        [_inputField setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
        [_inputField setPlaceholder:[[self fieldDefinition] label]];
        [_inputField setText:[domainModel valueForKey:[[self fieldDefinition] boundProperty]]];
        
        // we don't want to be able to select the form cells themselves.
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // ask the model if the model is editable
        if (![[self model] isMutable])
        {
            [_inputField setEnabled:NO];
        }
    }
    return self;
}

// required by subclasses of DTVConfigDrivenTableViewCell, concrete implementations
// know best how data should be extracted from the UI.
- (id)valueForBoundProperty;
{
    return [[self inputField] text];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // position the input field.
    int frameWidth = [self frame].size.width;
    int frameHeight = [self frame].size.height;
    int inputHeight = [[[self inputField] font] lineHeight];
    int inputWidth = frameWidth - 30;
    int inputX = 15;
    int inputY = (frameHeight - inputHeight + 2) / 2;
    [[self inputField] setFrame:CGRectMake(inputX, inputY, inputWidth, inputHeight)];
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // we validate cells
    [self validateInput];
}

@end
