//
//  GCVFaceAnnotations.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVFaceAnnotation.h"
#import "GCVLandmarks.h"
#import "GCVBoundingPoly.h"
#import "GCVFdBoundingPoly.h"

NSString *const kGCVFaceAnnotationsHeadwearLikelihood = @"headwearLikelihood";
NSString *const kGCVFaceAnnotationsSurpriseLikelihood = @"surpriseLikelihood";
NSString *const kGCVFaceAnnotationsRollAngle = @"rollAngle";
NSString *const kGCVFaceAnnotationsAngerLikelihood = @"angerLikelihood";
NSString *const kGCVFaceAnnotationsLandmarkingConfidence = @"landmarkingConfidence";
NSString *const kGCVFaceAnnotationsLandmarks = @"landmarks";
NSString *const kGCVFaceAnnotationsJoyLikelihood = @"joyLikelihood";
NSString *const kGCVFaceAnnotationsSorrowLikelihood = @"sorrowLikelihood";
NSString *const kGCVFaceAnnotationsDetectionConfidence = @"detectionConfidence";
NSString *const kGCVFaceAnnotationsBoundingPoly = @"boundingPoly";
NSString *const kGCVFaceAnnotationsPanAngle = @"panAngle";
NSString *const kGCVFaceAnnotationsFdBoundingPoly = @"fdBoundingPoly";
NSString *const kGCVFaceAnnotationsTiltAngle = @"tiltAngle";
NSString *const kGCVFaceAnnotationsUnderExposedLikelihood = @"underExposedLikelihood";
NSString *const kGCVFaceAnnotationsBlurredLikelihood = @"blurredLikelihood";

@interface GCVFaceAnnotation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GCVFaceAnnotation

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.headwearLikelihood = [self objectOrNilForKey:kGCVFaceAnnotationsHeadwearLikelihood fromDictionary:dict];
        self.surpriseLikelihood = [self objectOrNilForKey:kGCVFaceAnnotationsSurpriseLikelihood fromDictionary:dict];
        self.rollAngle = [[self objectOrNilForKey:kGCVFaceAnnotationsRollAngle fromDictionary:dict] doubleValue];
        self.angerLikelihood = [self objectOrNilForKey:kGCVFaceAnnotationsAngerLikelihood fromDictionary:dict];
        self.landmarkingConfidence = [[self objectOrNilForKey:kGCVFaceAnnotationsLandmarkingConfidence fromDictionary:dict] doubleValue];
        NSObject *receivedLandmarks = [dict objectForKey:kGCVFaceAnnotationsLandmarks];
        NSMutableArray *parsedLandmarks = [NSMutableArray array];
        if ([receivedLandmarks isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedLandmarks) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedLandmarks addObject:[GCVLandmarks modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedLandmarks isKindOfClass:[NSDictionary class]]) {
            [parsedLandmarks addObject:[GCVLandmarks modelObjectWithDictionary:(NSDictionary *)receivedLandmarks]];
        }
        
        self.landmarks = [NSArray arrayWithArray:parsedLandmarks];
        self.joyLikelihood = [self objectOrNilForKey:kGCVFaceAnnotationsJoyLikelihood fromDictionary:dict];
        self.sorrowLikelihood = [self objectOrNilForKey:kGCVFaceAnnotationsSorrowLikelihood fromDictionary:dict];
        self.detectionConfidence = [[self objectOrNilForKey:kGCVFaceAnnotationsDetectionConfidence fromDictionary:dict] doubleValue];
        self.boundingPoly = [GCVBoundingPoly modelObjectWithDictionary:[dict objectForKey:kGCVFaceAnnotationsBoundingPoly]];
        self.panAngle = [[self objectOrNilForKey:kGCVFaceAnnotationsPanAngle fromDictionary:dict] doubleValue];
        self.fdBoundingPoly = [GCVFdBoundingPoly modelObjectWithDictionary:[dict objectForKey:kGCVFaceAnnotationsFdBoundingPoly]];
        self.tiltAngle = [[self objectOrNilForKey:kGCVFaceAnnotationsTiltAngle fromDictionary:dict] doubleValue];
        self.underExposedLikelihood = [self objectOrNilForKey:kGCVFaceAnnotationsUnderExposedLikelihood fromDictionary:dict];
        self.blurredLikelihood = [self objectOrNilForKey:kGCVFaceAnnotationsBlurredLikelihood fromDictionary:dict];
    }
    return self;
}

#pragma mark - Helper Method

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
