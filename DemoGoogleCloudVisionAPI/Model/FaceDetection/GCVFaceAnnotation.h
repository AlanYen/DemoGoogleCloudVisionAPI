//
//  GCVFaceAnnotation.h
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVRootObject.h"
#import "GCVBoundingPoly.h"
#import "GCVFdBoundingPoly.h"
#import "GCVLandmark.h"

@interface GCVFaceAnnotation : GCVRootObject

@property (strong, nonatomic) NSString *headwearLikelihood;
@property (strong, nonatomic) NSString *surpriseLikelihood;
@property (assign, nonatomic) double rollAngle;
@property (strong, nonatomic) NSString *angerLikelihood;
@property (assign, nonatomic) double landmarkingConfidence;
@property (strong, nonatomic) NSArray *landmarks;
@property (strong, nonatomic) NSString *joyLikelihood;
@property (strong, nonatomic) NSString *sorrowLikelihood;
@property (assign, nonatomic) double detectionConfidence;
@property (strong, nonatomic) GCVBoundingPoly *boundingPoly;
@property (assign, nonatomic) double panAngle;
@property (strong, nonatomic) GCVFdBoundingPoly *fdBoundingPoly;
@property (assign, nonatomic) double tiltAngle;
@property (strong, nonatomic) NSString *underExposedLikelihood;
@property (strong, nonatomic) NSString *blurredLikelihood;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
