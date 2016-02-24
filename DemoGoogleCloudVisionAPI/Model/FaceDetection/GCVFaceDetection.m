//
//  GCVFaceDetection.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVFaceDetection.h"
#import "GCVFaceAnnotation.h"

NSString *const kGCVFaceDetectionFaceAnnotations = @"faceAnnotations";

@interface GCVFaceDetection ()

@end

@implementation GCVFaceDetection

- (void)initWithDictionary:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        NSObject *receivedFaceAnnotations = [dict objectForKey:kGCVFaceDetectionFaceAnnotations];
        NSMutableArray *parsedFaceAnnotations = [NSMutableArray array];
        if ([receivedFaceAnnotations isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedFaceAnnotations) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedFaceAnnotations addObject:[GCVFaceAnnotation modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedFaceAnnotations isKindOfClass:[NSDictionary class]]) {
            [parsedFaceAnnotations addObject:[GCVFaceAnnotation modelObjectWithDictionary:(NSDictionary *)receivedFaceAnnotations]];
        }
        self.faceAnnotations = [NSArray arrayWithArray:parsedFaceAnnotations];
    }
}

- (void)getFaceDetection:(NSString *)imageString
               maxResult:(NSInteger)maxResult
              completion:(void (^)(NSDictionary *errorDict))completion {
    if (completion) {
        [[self class] sendPostRequestWithBaseURL:[GCVRootModel baseURL]
                                          action:@"FACE_DETECTION"
                                       imageData:imageString
                                       maxResult:maxResult
                                      completion:^(NSDictionary *responseDict, NSDictionary *errorDict)
         {
             if (responseDict && !errorDict) {
                 [self initWithDictionary:responseDict];
                 if (completion) {
                     dispatch_sync(dispatch_get_main_queue(), ^{
                         completion(nil);
                     });
                 }
             }
             else {
                 if (completion) {
                     dispatch_sync(dispatch_get_main_queue(), ^{
                         completion(errorDict);
                     });
                 }
             }
         }];
    }
}

@end