//
//  GCVLogoAnnotation.m
//
//  Created by Alan.Yen on 2016/2/25
//  Copyright (c) 2016 17life All rights reserved.
//

#import "GCVEntityAnnotation.h"

NSString *const kGCVEntityAnnotationMid = @"mid";
NSString *const kGCVEntityAnnotationLocale = @"locale";
NSString *const kGCVEntityAnnotationDescription = @"description";
NSString *const kGCVEntityAnnotationScore = @"score";
NSString *const kGCVEntityAnnotationCondidence = @"condidence";
NSString *const kGCVEntityAnnotationTopicality = @"topicality";
NSString *const kGCVEntityAnnotationBoundingPoly = @"boundingPoly";
NSString *const kGCVEntityAnnotationLocations = @"locations";
NSString *const kGCVEntityAnnotationProperties = @"properties";

@implementation GCVEntityAnnotation

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {

    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
    
        self.mid = [self objectOrNilForKey:kGCVEntityAnnotationMid fromDictionary:dict];
        self.locale = [self objectOrNilForKey:kGCVEntityAnnotationLocale fromDictionary:dict];
        self.annotationsDescription = [self objectOrNilForKey:kGCVEntityAnnotationDescription fromDictionary:dict];
        self.score = [[self objectOrNilForKey:kGCVEntityAnnotationScore fromDictionary:dict] doubleValue];
        self.confidence = [[self objectOrNilForKey:kGCVEntityAnnotationCondidence fromDictionary:dict] doubleValue];
        self.topicality = [[self objectOrNilForKey:kGCVEntityAnnotationTopicality fromDictionary:dict] doubleValue];
        self.boundingPoly = [GCVBoundingPoly modelObjectWithDictionary:[dict objectForKey:kGCVEntityAnnotationBoundingPoly]];
        
        NSObject *receivedLocations = [dict objectForKey:kGCVEntityAnnotationLocations];
        NSMutableArray *parsedLocations = [NSMutableArray array];
        if ([receivedLocations isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedLocations) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedLocations addObject:[GCVLocationInfo modelObjectWithDictionary:item]];
                }
            }
        }
        self.locations = [NSArray arrayWithArray:parsedLocations];

        NSObject *receivedProperties = [dict objectForKey:kGCVEntityAnnotationProperties];
        NSMutableArray *parsedProperties = [NSMutableArray array];
        if ([receivedProperties isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedProperties) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedProperties addObject:[GCVProperty modelObjectWithDictionary:item]];
                }
            }
        }
        self.properties = [NSArray arrayWithArray:parsedProperties];
    }
    return self;
}

@end