//
//  GCVFaceDetection.h
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVRootModel.h"
#import "GCVFaceAnnotation.h"
#import "GCVLandmarks.h"
#import "GCVPosition.h"
#import "GCVBoundingPoly.h"
#import "GCVVertices.h"

@interface GCVFaceDetection : GCVRootModel

@property (strong, nonatomic) NSArray *faceAnnotations;

- (void)getFaceDetection:(NSString *)imageString
               maxResult:(NSInteger)maxResult
              completion:(void (^)(NSDictionary *errorDict))completion;

@end
