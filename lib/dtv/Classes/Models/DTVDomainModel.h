//
//  DTVDomainModel.h
//  DTVTableView
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DTVDomainModel;

@protocol DTVPersistentModelProtocol <NSObject>

@optional
// class method for serializeing a list of dictionary representations of the model
+ (NSArray *)initWithArray:(NSArray *)modelDicts;

// class method for serializing a single dictionary representation of the model
+ (DTVDomainModel *)initWithDictionary:(NSDictionary *)modelDict;

// list the available resources
+ (void)list:(void(^)(BOOL success, id response, NSError *error))callback;

// persist the instance to the service
- (void)save:(void(^)(BOOL success, id response, NSError *error))callback;

// public interface that allows the service layer to get
// the model formatted for persistence
- (NSDictionary *)serializedForSave;

// encapsulate the logic for determining whether or not the
// record is new or existing.
- (BOOL)isNew;

// encapsulate the logic for determining whether or not the
// record can be edited.
- (BOOL)isMutable;

// We need to be able to tell the model to skip validation in certain
// UX scenarios, like canceling from a form
- (void)setSkipValidation:(BOOL)val;

// Since KVC is an informal protocol, let's make it formal for our models.
- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;
- (BOOL)validateValue:(id *)ioValue forKey:(NSString *)key error:(NSError **)outError;

@end

@interface DTVDomainModel : NSObject <DTVPersistentModelProtocol>

// class method for serializeing a list of dictionary representations of the model
+ (NSArray *)initWithArray:(NSArray *)modelDicts;

// class method for serializing a single dictionary representation of the model
+ (DTVDomainModel *)initWithDictionary:(NSDictionary *)modelDict;

// list the available resources
+ (void)list:(void(^)(BOOL success, id response, NSError *error))callback;

// persist the instance to the service
- (void)save:(void(^)(BOOL success, id response, NSError *error))callback;

// public interface that allows the service layer to get
// the model formatted for persistence
- (NSDictionary *)serializedForSave;

// encapsulate the logic for determining whether or not the
// record is new or existing.
- (BOOL)isNew;

// encapsulate the logic for determining whether or not the
// record can be edited.
- (BOOL)isMutable;

// We need to be able to tell the model to skip validation in certain
// UX scenarios, like canceling from a form
- (void)setSkipValidation:(BOOL)val;

@end
