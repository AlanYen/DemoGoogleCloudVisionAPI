//
//  GCVLocationInfo.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVLocationInfo.h"

NSString *const GCVLocationInfoLatLng = @"latLng";

@implementation GCVLocationInfo

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.latLng = [GCVLatLng modelObjectWithDictionary:[self objectOrNilForKey:GCVLocationInfoLatLng fromDictionary:dict]];
    }
    return self;
}

@end