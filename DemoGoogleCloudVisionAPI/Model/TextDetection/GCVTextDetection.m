//
//  GCVTextDetection.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVTextDetection.h"

@interface GCVTextDetection ()

@end

@implementation GCVTextDetection

+ (NSString *)annotationName {
    return @"textAnnotations";
}

+ (NSString *)actionTypeName {
    return @"TEXT_DETECTION";
}

- (void)getTextDetection:(NSString *)imageString
               maxResult:(NSInteger)maxResult
              completion:(void (^)(NSDictionary *errorDict))completion {
    [self getEntityDetection:imageString
                   maxResult:maxResult
                  completion:completion];
}

@end