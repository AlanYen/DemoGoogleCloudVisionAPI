//
//  GCVEntityDetection.h
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVRootModel.h"
#import "GCVEntityAnnotation.h"

@interface GCVEntityDetection : GCVRootModel

@property (strong, nonatomic) NSArray *annotations;

+ (NSString *)annotationName;
+ (Class)annotationClass;
+ (NSString *)actionTypeName;
- (void)initWithDictionary:(NSDictionary *)dict;
- (void)getEntityDetection:(NSString *)imageString
                 maxResult:(NSInteger)maxResult
                completion:(void (^)(GCVError *error))completion;

@end
