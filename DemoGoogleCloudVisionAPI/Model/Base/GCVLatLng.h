//
//  GCVLatLng.h
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVRootObject.h"

@interface GCVLatLng : GCVRootObject

@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
