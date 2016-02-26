//
//  GCVFaceDetection.h
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVEntityDetection.h"
#import "GCVFaceAnnotation.h"

@interface GCVFaceDetection : GCVEntityDetection

- (void)getFaceDetection:(NSString *)imageString
               maxResult:(NSInteger)maxResult
              completion:(void (^)(GCVError *error))completion;

@end
