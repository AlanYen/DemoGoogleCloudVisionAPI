//
//  BaseClass.h
//
//  Created by   on 2016/2/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImagePropertiesAnnotation;

@interface BaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ImagePropertiesAnnotation *imagePropertiesAnnotation;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
