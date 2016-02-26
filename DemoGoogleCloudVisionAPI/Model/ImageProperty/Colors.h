//
//  Colors.h
//
//  Created by   on 2016/2/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Color;

@interface Colors : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) Color *color;
@property (nonatomic, assign) double score;
@property (nonatomic, assign) double pixelFraction;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
