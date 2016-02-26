//
//  GCVLink.h
//
//  Created by Alan.Yen on 2016/2/26
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVRootObject.h"

@interface GCVLink : GCVRootObject

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *linkDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
