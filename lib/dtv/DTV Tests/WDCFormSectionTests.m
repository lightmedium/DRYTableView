//
//  DTVFormSectionTests.m
//  DTVTableView
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DTVFixtureLoader.h"
#import "DTVFormSection.h"

@interface DTVFormSectionTests : XCTestCase @end

@implementation DTVFormSectionTests

// + (id)initWithSectionDefinition:(NSDictionary *)sectionDef;
- (void)testInitWithSectionDefinition_createsTheExpectedNumberOfFields
{
    // setup
    NSDictionary *sectionDefinition = [DTVFixtureLoader loadFixtureNamed:@"sectionDefinition"];
    int expectedFieldCount = 2;
    
    // execution
    DTVFormSection *section = [DTVFormSection initWithSectionDefinition:sectionDefinition];
    int actualFieldCount = [[section fields] count];
    
    // assertion
    XCTAssertEqual(expectedFieldCount, actualFieldCount, @"We didn't get all of the fields that we expected from the fixture.");
}


@end
