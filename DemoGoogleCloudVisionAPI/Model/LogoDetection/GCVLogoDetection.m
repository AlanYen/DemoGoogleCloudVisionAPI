//
//  GCVLogoDetection.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVLogoDetection.h"

@interface GCVLogoDetection ()

@end

@implementation GCVLogoDetection

+ (NSString *)annotationName {
    return @"logoAnnotations";
}

+ (NSString *)actionTypeName {
    return @"LOGO_DETECTION";
}

- (void)getLogoDetection:(NSString *)imageString
               maxResult:(NSInteger)maxResult
              completion:(void (^)(NSDictionary *errorDict))completion {
    [self getEntityDetection:imageString
                   maxResult:maxResult
                  completion:completion];
}

@end