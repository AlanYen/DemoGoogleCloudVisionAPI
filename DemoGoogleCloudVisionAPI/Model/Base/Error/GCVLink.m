//
//  GCVLink.m
//
//  Created by Alan.Yen on 2016/2/26
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVLink.h"

NSString *const kGCVLinkUrl = @"url";
NSString *const kGCVLinkDescription = @"description";

@implementation GCVLink

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.url = [self objectOrNilForKey:kGCVLinkUrl fromDictionary:dict];
        self.linkDescription = [self objectOrNilForKey:kGCVLinkDescription fromDictionary:dict];
    }
    return self;
}

@end