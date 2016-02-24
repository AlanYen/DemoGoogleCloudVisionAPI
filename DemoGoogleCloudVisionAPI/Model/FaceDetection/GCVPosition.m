//
//  GCVPosition.m
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVPosition.h"

NSString *const kGCVPositionX = @"x";
NSString *const kGCVPositionY = @"y";
NSString *const kGCVPositionZ = @"z";

@interface GCVPosition ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GCVPosition

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.x = [[self objectOrNilForKey:kGCVPositionX fromDictionary:dict] doubleValue];
        self.y = [[self objectOrNilForKey:kGCVPositionY fromDictionary:dict] doubleValue];
        self.z = [[self objectOrNilForKey:kGCVPositionZ fromDictionary:dict] doubleValue];
    }
    return self;
}

#pragma mark - Helper Method

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end