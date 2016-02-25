//
//  GCVLandmark.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVLandmark.h"

NSString *const kGCVLandmarkType = @"type";
NSString *const kGCVLandmarkPosition = @"position";

@implementation GCVLandmark

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.type = [self objectOrNilForKey:kGCVLandmarkType fromDictionary:dict];
        self.gcvPosition = [GCVPosition modelObjectWithDictionary:[dict objectForKey:kGCVLandmarkPosition]];
    }
    return self;
}

@end