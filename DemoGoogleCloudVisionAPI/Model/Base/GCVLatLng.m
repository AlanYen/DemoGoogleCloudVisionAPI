//
//  GCVLatLng.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVLatLng.h"

NSString *const kGCVLatitude = @"latitude";
NSString *const kGCVLongitude = @"longitude";

@implementation GCVLatLng

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.latitude = [[self objectOrNilForKey:kGCVLatitude fromDictionary:dict] doubleValue];
        self.longitude = [[self objectOrNilForKey:kGCVLongitude fromDictionary:dict] doubleValue];
    }
    return self;
}

@end