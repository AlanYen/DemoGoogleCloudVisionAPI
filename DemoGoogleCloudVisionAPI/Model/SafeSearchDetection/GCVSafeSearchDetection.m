//
//  GCVSafeSearchDetection.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVSafeSearchDetection.h"

@interface GCVSafeSearchDetection ()

@end

@implementation GCVSafeSearchDetection

+ (NSString *)annotationName {
    return @"safeSearchAnnotation";
}

+ (Class)annotationClass {
    return [GCVSafeSearchAnnotation class];
}

+ (NSString *)actionTypeName {
    return @"SAFE_SEARCH_DETECTION";
}

- (void)getSafeSearchDetection:(NSString *)imageString
                     maxResult:(NSInteger)maxResult
                    completion:(void (^)(GCVError *error))completion {
    [self getEntityDetection:imageString
                   maxResult:maxResult
                  completion:completion];
}

@end