//
//  GCVBoundingPoly.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVBoundingPoly.h"
#import "GCVVertices.h"

NSString *const kBoundingPolyVertices = @"vertices";

@interface GCVBoundingPoly ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GCVBoundingPoly

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        NSObject *receivedVertices = [dict objectForKey:kBoundingPolyVertices];
        NSMutableArray *parsedVertices = [NSMutableArray array];
        if ([receivedVertices isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedVertices) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedVertices addObject:[GCVVertices modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedVertices isKindOfClass:[NSDictionary class]]) {
            [parsedVertices addObject:[GCVVertices modelObjectWithDictionary:(NSDictionary *)receivedVertices]];
        }
        self.vertices = [NSArray arrayWithArray:parsedVertices];
    }
    return self;
}

#pragma mark - Helper Method

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end