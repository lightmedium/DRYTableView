//
//  DTVFixtureLoader.h
//  DTVTableView
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTVFixtureLoader : NSObject

+ (NSDictionary *)loadFixtureNamed:(NSString *)fixtureName;

@end
