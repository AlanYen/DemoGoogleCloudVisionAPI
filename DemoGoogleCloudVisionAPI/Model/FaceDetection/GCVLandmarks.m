//
//  GCVLandmarks.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVLandmarks.h"
#import "GCVPosition.h"

NSString *const kGCVLandmarksType = @"type";
NSString *const kGCVLandmarksPosition = @"position";

@interface GCVLandmarks ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GCVLandmarks

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.type = [self objectOrNilForKey:kGCVLandmarksType fromDictionary:dict];
        self.gcvPosition = [GCVPosition modelObjectWithDictionary:[dict objectForKey:kGCVLandmarksPosition]];
    }
    return self;
}

#pragma mark - Helper Method

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end