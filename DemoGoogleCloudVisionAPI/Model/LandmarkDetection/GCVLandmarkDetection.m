//
//  GCVLandmarkDetection.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVLandmarkDetection.h"

@interface GCVLandmarkDetection ()

@end

@implementation GCVLandmarkDetection

+ (NSString *)annotationName {
    return @"landmarkAnnotations";
}

+ (NSString *)actionTypeName {
    return @"LANDMARK_DETECTION";
}

- (void)getLandmarkDetection:(NSString *)imageString
                   maxResult:(NSInteger)maxResult
                  completion:(void (^)(NSDictionary *errorDict))completion {
    [self getEntityDetection:imageString
                   maxResult:maxResult
                  completion:completion];
}

@end