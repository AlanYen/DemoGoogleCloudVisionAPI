//
//  GCVProperty.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVProperty.h"

NSString *const kGCVPropertyName = @"name";
NSString *const kGCVPropertyValue = @"value";

@implementation GCVProperty

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.propertyName = [self objectOrNilForKey:kGCVPropertyName fromDictionary:dict];
        self.propertyValue = [self objectOrNilForKey:kGCVPropertyValue fromDictionary:dict];
    }
    return self;
}

@end