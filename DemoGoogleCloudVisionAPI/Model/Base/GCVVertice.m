//
//  GCVVertice.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVVertice.h"

NSString *const kGCVVerticeX = @"x";
NSString *const kGCVVerticeY = @"y";

@implementation GCVVertice

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.x = [[self objectOrNilForKey:kGCVVerticeX fromDictionary:dict] doubleValue];
        self.y = [[self objectOrNilForKey:kGCVVerticeY fromDictionary:dict] doubleValue];
    }
    return self;
}

@end