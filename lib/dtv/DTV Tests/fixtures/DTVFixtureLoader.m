//
//  DTVFixtureLoader.m
//  DTVTableView
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "DTVFixtureLoader.h"

@implementation DTVFixtureLoader

+ (NSDictionary *)loadFixtureNamed:(NSString *)fixtureName;
{
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:fixtureName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    
    NSDictionary *fixture = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    return fixture;
}

@end
