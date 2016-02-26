//
//  GCVDetail.m
//
//  Created by Alan.Yen on 2016/2/26
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVDetail.h"

NSString *const kGCVDetailType = @"@type";
NSString *const kGCVDetailLinks = @"links";

@implementation GCVDetail

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.type = [self objectOrNilForKey:kGCVDetailType fromDictionary:dict];
        NSObject *receivedLinks = [dict objectForKey:kGCVDetailLinks];
        NSMutableArray *parsedLinks = [NSMutableArray array];
        if ([receivedLinks isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedLinks) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedLinks addObject:[GCVLink modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedLinks isKindOfClass:[NSDictionary class]]) {
            [parsedLinks addObject:[GCVLink modelObjectWithDictionary:(NSDictionary *)receivedLinks]];
        }
        self.links = [NSArray arrayWithArray:parsedLinks];
    }
    return self;
}

@end
