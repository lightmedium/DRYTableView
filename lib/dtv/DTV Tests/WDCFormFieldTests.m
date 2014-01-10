//
//  DTVFormFieldTests.m
//  DTVTableView
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DTVFixtureLoader.h"
#import "DTVFormField.h"
#import "DTVDomainModel.h"
#import "DTVConfigDrivenTableViewCell.h"

@interface DTVFormFieldTests : XCTestCase @end

@implementation DTVFormFieldTests

// + (id)initWithFieldDefinition:(NSDictionary*)dict;
- (void)testInitWithFieldDefinition_initsFromFixture
{
    // setup
    NSDictionary *fieldDefinition = [DTVFixtureLoader loadFixtureNamed:@"fieldDefinition"];
    NSString *expectedLabel = @"First Name:";
    NSString *expectedType = @"textInput";
    NSString *expectedBoundProperty = @"firstName";
    NSNumber *expectedRowHeight = @44;
    
    // execution
    DTVFormField *field = [DTVFormField initWithFieldDefinition:fieldDefinition];
    
    // assertion
    XCTAssertNotNil(fieldDefinition, @"We should have gotten a field definition from our fixture.");
    XCTAssertNotNil(field, @"We should have gotten a DTVFormField instance.");
    
    NSString *actualLabel = [field label];
    NSString *actualType = [field type];
    NSString *actualBoundProperty = [field boundProperty];
    NSNumber *actualRowHeight = [field rowHeight];
    XCTAssertTrue([actualLabel isEqualToString:expectedLabel], @"The label did not match between our fixture and our DTVFormField instance.");
    XCTAssertTrue([actualType isEqualToString:expectedType], @"The type did not match between our fixture and our DTVFormField instance.");
    XCTAssertTrue([actualBoundProperty isEqualToString:expectedBoundProperty], @"The boundProperty did not match between our fixture and our DTVFormField instance.");
    XCTAssertEqualObjects(expectedRowHeight, actualRowHeight, @"The rowHeight did not match between our fixture and our DTVFormField instance.");
}

// - (UITableViewCell *)tableViewCell;
- (void)testTableViewCell_returnsExpectedNewAndCachedTableViewCells
{
    // setup
    NSDictionary *fieldDefinition = [DTVFixtureLoader loadFixtureNamed:@"fieldDefinition"];
    NSDictionary *leadDefinition = [DTVFixtureLoader loadFixtureNamed:@"lead01"];
    DTVFormField *field = [DTVFormField initWithFieldDefinition:fieldDefinition];
    DTVDomainModel *lead = [DTVDomainModel initWithDictionary:leadDefinition];
    [field setModel:lead];
    Class expectedClass = NSClassFromString(@"DTVTextInputCell");
    
    // execution
    DTVConfigDrivenTableViewCell *cell1 = [field tableViewCell];
    DTVConfigDrivenTableViewCell *cell2 = [field tableViewCell];
    
    // assertion
    XCTAssertNotNil(cell1, @"The DTVFormField failed to instantiate a UITableViewCell");
    XCTAssertNotNil(cell1, @"The DTVFormField failed to return a cached UITableViewCell");
    XCTAssertEqual(cell1, cell2, @"The DTVFormField failed to return the cached cell. We got a new instance");
    // this test will break if the project no longer includes the DTVInputFieldCell class.
    XCTAssertTrue([cell1 isKindOfClass:expectedClass], @"The DTVFormField didn't return the correct type of tableview cell.");
}

@end
