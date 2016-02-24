//
//  GCVVertices.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVVertices.h"

NSString *const kGCVVerticesX = @"x";
NSString *const kGCVVerticesY = @"y";

@interface GCVVertices ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GCVVertices

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.x = [[self objectOrNilForKey:kGCVVerticesX fromDictionary:dict] doubleValue];
        self.y = [[self objectOrNilForKey:kGCVVerticesY fromDictionary:dict] doubleValue];
    }
    return self;
}

#pragma mark - Helper Method

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end