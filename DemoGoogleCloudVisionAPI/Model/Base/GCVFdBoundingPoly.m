//
//  GCVFdBoundingPoly.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVFdBoundingPoly.h"
#import "GCVVertice.h"

NSString *const kGCVFdBoundingPolyVertices = @"vertices";

@implementation GCVFdBoundingPoly

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        NSObject *receivedVertices = [dict objectForKey:kGCVFdBoundingPolyVertices];
        NSMutableArray *parsedVertices = [NSMutableArray array];
        if ([receivedVertices isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedVertices) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedVertices addObject:[GCVVertice modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedVertices isKindOfClass:[NSDictionary class]]) {
            [parsedVertices addObject:[GCVVertice modelObjectWithDictionary:(NSDictionary *)receivedVertices]];
        }
        self.vertices = [NSArray arrayWithArray:parsedVertices];
    }
    return self;
}

@end
