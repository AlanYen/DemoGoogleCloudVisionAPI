//
//  GCVError.h
//
//  Created by Alan.Yen on 2016/2/26
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVRootObject.h"
#import "GCVDetail.h"

@interface GCVError : GCVRootObject

@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *message;
@property (assign, nonatomic) NSInteger code;
@property (strong, nonatomic) NSArray *details;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end