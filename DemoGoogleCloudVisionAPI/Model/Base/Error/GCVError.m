//
//  GCVError.m
//
//  Created by Alan.Yen on 2016/2/26
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVError.h"

NSString *const kGCVErrorStatus = @"status";
NSString *const kGCVErrorMessage = @"message";
NSString *const kGCVErrorCode = @"code";
NSString *const kGCVErrorDetails = @"details";

@implementation GCVError

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.status = [self objectOrNilForKey:kGCVErrorStatus fromDictionary:dict];
        self.message = [self objectOrNilForKey:kGCVErrorMessage fromDictionary:dict];
        self.code = [[self objectOrNilForKey:kGCVErrorCode fromDictionary:dict] doubleValue];
        NSObject *receivedDetails = [dict objectForKey:kGCVErrorDetails];
        NSMutableArray *parsedDetails = [NSMutableArray array];
        if ([receivedDetails isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedDetails) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedDetails addObject:[GCVDetail modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedDetails isKindOfClass:[NSDictionary class]]) {
            [parsedDetails addObject:[GCVDetail modelObjectWithDictionary:(NSDictionary *)receivedDetails]];
        }
        self.details = [NSArray arrayWithArray:parsedDetails];
    }
    return self;
}

@end