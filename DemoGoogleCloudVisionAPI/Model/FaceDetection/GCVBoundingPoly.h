//
//  GCVBoundingPoly.h
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCVBoundingPoly : NSObject

@property (nonatomic, strong) NSArray *vertices;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
