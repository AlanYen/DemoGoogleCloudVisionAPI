//
//  GCVLandmarks.h
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCVPosition;

@interface GCVLandmarks : NSObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) GCVPosition *gcvPosition;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
