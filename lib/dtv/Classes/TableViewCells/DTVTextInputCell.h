//
//  WDCTextInputCell.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//
//  WDCTextInputCell is a concrete implementation of WDCConfgiDrivenTableViewCell,
//  used for displaying a text input in a form.

#import <UIKit/UIKit.h>
#import "DTVConfigDrivenTableViewCell.h"

@interface DTVTextInputCell : DTVConfigDrivenTableViewCell <UITextFieldDelegate>

// the editable field
@property (nonatomic, strong) UITextField *inputField;

@end
