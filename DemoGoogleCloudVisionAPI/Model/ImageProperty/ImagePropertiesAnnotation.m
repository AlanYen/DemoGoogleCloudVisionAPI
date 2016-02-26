//
//  ImagePropertiesAnnotation.m
//
//  Created by   on 2016/2/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ImagePropertiesAnnotation.h"
#import "DominantColors.h"


NSString *const kImagePropertiesAnnotationDominantColors = @"dominantColors";


@interface ImagePropertiesAnnotation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ImagePropertiesAnnotation

@synthesize dominantColors = _dominantColors;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.dominantColors = [DominantColors modelObjectWithDictionary:[dict objectForKey:kImagePropertiesAnnotationDominantColors]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.dominantColors dictionaryRepresentation] forKey:kImagePropertiesAnnotationDominantColors];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.dominantColors = [aDecoder decodeObjectForKey:kImagePropertiesAnnotationDominantColors];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_dominantColors forKey:kImagePropertiesAnnotationDominantColors];
}

- (id)copyWithZone:(NSZone *)zone
{
    ImagePropertiesAnnotation *copy = [[ImagePropertiesAnnotation alloc] init];
    
    if (copy) {

        copy.dominantColors = [self.dominantColors copyWithZone:zone];
    }
    
    return copy;
}


@end
