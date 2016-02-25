//
//  GCVSafeSearchAnnotation.h
//
//  Created by Alan.Yen on 2016/2/25
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVRootObject.h"

@interface GCVSafeSearchAnnotation : GCVRootObject

@property (strong, nonatomic) NSString *spoof;
@property (strong, nonatomic) NSString *medical;
@property (strong, nonatomic) NSString *adult;
@property (strong, nonatomic) NSString *violence;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
