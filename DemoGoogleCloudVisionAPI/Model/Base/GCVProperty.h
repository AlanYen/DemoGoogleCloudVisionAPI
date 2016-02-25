//
//  GCVProperty.h
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVRootObject.h"

@interface GCVProperty : GCVRootObject

@property (strong, nonatomic) NSString *propertyName;
@property (strong, nonatomic) NSString *propertyValue;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
