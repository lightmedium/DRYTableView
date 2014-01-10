//
//  DTVConfigDrivenTableViewController.m
//  DTVTableView
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "DTVConfigDrivenTableViewController.h"
#import "DTVConfigDrivenTableViewCell.h"
#import "DTVFormDataProvider.h"
#import "NSMutableString+Utilities.h"
#import "DTVFormSection.h"
#import "DTVFormField.h"

@interface DTVConfigDrivenTableViewController ()
@property (nonatomic, strong) UIView *spinnerContainer;
@end

@implementation DTVConfigDrivenTableViewController

- (id)initWithNibName:(NSString *)nibName model:(id<DTVPersistentModelProtocol>)model;
{
    if ((self = [super initWithNibName:nibName bundle:nil])) {
        _model = model;
        _formDefinition = [self loadFormDefinition];
        if (_formDefinition != nil)
        {
            // construct the data provider with the form definition loaded from the plist
            _dataProvider = [DTVFormDataProvider initWithFormDefinition:_formDefinition];
        }
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouched)];
        [[self navigationItem] setLeftBarButtonItem:cancel];
        
        // if the model is mutable, show the save button
        if ([[self model] isMutable])
        {
            UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStyleDone target:self action:@selector(saveTouched)];
            [[self navigationItem] setRightBarButtonItem:save];
            [save setEnabled:YES];
        }
    }
    return self;
}

#pragma mark - Nav Bar Button Item Touch Handlers

- (void)saveTouched
{
    NSLog(@"save touched");
    // validate each cell
    
    if ([[self dataProvider] validateRequiredCells])
    {
        // add the spinner container view
        [self setSpinnerContainer:[[UIView alloc] initWithFrame:[[self tableView] frame]]];
        [[self view] addSubview:[self spinnerContainer]];
        
        // TODO: protocol method to tell view controller to show spinner?
        
        // if valid, save the record
        __weak DTVConfigDrivenTableViewController *weakSelf = self;
        [[self model] save:^(BOOL success, id response, NSError *error) {
            // alert the user if there was an issue
            if ([error localizedDescription] || !success)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"There was an error saving your lead. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
            }
            
            // UI stuff goes to the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                // TODO: protocol method to tell view controller to hide spinner?
                [[weakSelf spinnerContainer] removeFromSuperview];
                
                // when save is done, go back
                [[self navigationController] popViewControllerAnimated:YES];
            });
        }];
    }
    
    // else do nothing.
}

- (void)cancelTouched
{
    NSLog(@"cancel touched");
    [[self model] setSkipValidation:YES];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // return the number of sections in the data provider.
    return [[[self dataProvider] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of fields in the section of the data provider
    DTVFormSection *s = [[[self dataProvider] sections] objectAtIndex:section];
    return [[s fields] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // grab the field model
    DTVFormField *field = [[self dataProvider] fieldModelForIndexPath:indexPath];
    
    // set a reference to the domain model (the DTVDomainModel instance) on the field model
    [field setModel:[self model]];
    
    // everything we need to know about instantiating the cell is encapsulated in the field model.
    // the field model caches its own cell instance.
    DTVConfigDrivenTableViewCell *cell = [field tableViewCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // height is a property loaded from the field definition in the plist
    DTVFormField *field = [[self dataProvider] fieldModelForIndexPath:indexPath];
    return [[field rowHeight] floatValue];
}

#pragma mark - Form Config Loading

- (NSMutableDictionary *)loadFormDefinition;
{
    // infer the name of the plist from the client view controller class name
    // this way, implementations of concrete view controllers don't need to
    // worry about loading their controller-specific plist. As long as the plist
    // is named "class name" + "Def" the view controller will be configured with it.
    NSMutableString *plistName = [NSStringFromClass([self class]) mutableCopy];
    [plistName appendString:@"Def"];
    
    // load the plist with the name we just assembled
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSMutableDictionary *config = [NSDictionary dictionaryWithContentsOfFile:path];
    return [config mutableCopy];
}

@end
