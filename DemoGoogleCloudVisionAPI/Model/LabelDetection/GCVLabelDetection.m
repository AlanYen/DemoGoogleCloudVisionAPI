//
//  GCVLabelDetection.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVLabelDetection.h"

@interface GCVLabelDetection ()

@end

@implementation GCVLabelDetection

+ (NSString *)annotationName {
    return @"labelAnnotations";
}

+ (NSString *)actionTypeName {
    return @"LABEL_DETECTION";
}

- (void)getLabelDetection:(NSString *)imageString
                maxResult:(NSInteger)maxResult
               completion:(void (^)(NSDictionary *errorDict))completion {
    [self getEntityDetection:imageString
                   maxResult:maxResult
                  completion:completion];
}

@end