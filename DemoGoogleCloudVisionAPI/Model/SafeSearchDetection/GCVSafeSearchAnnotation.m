//
//  GCVSafeSearchAnnotation.m
//
//  Created by Alan.Yen on 2016/2/25
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVSafeSearchAnnotation.h"

NSString *const kGCVSafeSearchAnnotationSpoof = @"spoof";
NSString *const kGCVSafeSearchAnnotationMedical = @"medical";
NSString *const kGCVSafeSearchAnnotationAdult = @"adult";
NSString *const kGCVSafeSearchAnnotationViolence = @"violence";

@implementation GCVSafeSearchAnnotation

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.spoof = [self objectOrNilForKey:kGCVSafeSearchAnnotationSpoof fromDictionary:dict];
        self.medical = [self objectOrNilForKey:kGCVSafeSearchAnnotationMedical fromDictionary:dict];
        self.adult = [self objectOrNilForKey:kGCVSafeSearchAnnotationAdult fromDictionary:dict];
        self.violence = [self objectOrNilForKey:kGCVSafeSearchAnnotationViolence fromDictionary:dict];
    }
    return self;
}

@end