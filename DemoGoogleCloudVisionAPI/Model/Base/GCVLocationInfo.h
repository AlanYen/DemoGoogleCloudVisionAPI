//
//  GCVLocationInfo.h
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVRootObject.h"
#import "GCVLatLng.h"

@interface GCVLocationInfo : GCVRootObject

@property (strong, nonatomic) GCVLatLng *latLng;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
