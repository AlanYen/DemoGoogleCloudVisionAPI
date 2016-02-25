//
//  GCVPosition.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVPosition.h"

NSString *const kGCVPositionX = @"x";
NSString *const kGCVPositionY = @"y";
NSString *const kGCVPositionZ = @"z";

@implementation GCVPosition

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.x = [[self objectOrNilForKey:kGCVPositionX fromDictionary:dict] doubleValue];
        self.y = [[self objectOrNilForKey:kGCVPositionY fromDictionary:dict] doubleValue];
        self.z = [[self objectOrNilForKey:kGCVPositionZ fromDictionary:dict] doubleValue];
    }
    return self;
}

@end