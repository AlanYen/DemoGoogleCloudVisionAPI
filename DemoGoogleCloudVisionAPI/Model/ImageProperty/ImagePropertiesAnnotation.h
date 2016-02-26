//
//  ImagePropertiesAnnotation.h
//
//  Created by   on 2016/2/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DominantColors;

@interface ImagePropertiesAnnotation : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) DominantColors *dominantColors;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
