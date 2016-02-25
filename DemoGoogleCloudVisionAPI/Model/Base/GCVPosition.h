//
//  GCVPosition.h
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVRootObject.h"

@interface GCVPosition : GCVRootObject

@property (assign, nonatomic) double x;
@property (assign, nonatomic) double y;
@property (assign, nonatomic) double z;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
