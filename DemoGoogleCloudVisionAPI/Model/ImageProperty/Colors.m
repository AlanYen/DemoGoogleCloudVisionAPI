//
//  Colors.m
//
//  Created by   on 2016/2/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Colors.h"
#import "Color.h"


NSString *const kColorsColor = @"color";
NSString *const kColorsScore = @"score";
NSString *const kColorsPixelFraction = @"pixelFraction";


@interface Colors ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Colors

@synthesize color = _color;
@synthesize score = _score;
@synthesize pixelFraction = _pixelFraction;


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
            self.color = [Color modelObjectWithDictionary:[dict objectForKey:kColorsColor]];
            self.score = [[self objectOrNilForKey:kColorsScore fromDictionary:dict] doubleValue];
            self.pixelFraction = [[self objectOrNilForKey:kColorsPixelFraction fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.color dictionaryRepresentation] forKey:kColorsColor];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kColorsScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pixelFraction] forKey:kColorsPixelFraction];

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

    self.color = [aDecoder decodeObjectForKey:kColorsColor];
    self.score = [aDecoder decodeDoubleForKey:kColorsScore];
    self.pixelFraction = [aDecoder decodeDoubleForKey:kColorsPixelFraction];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_color forKey:kColorsColor];
    [aCoder encodeDouble:_score forKey:kColorsScore];
    [aCoder encodeDouble:_pixelFraction forKey:kColorsPixelFraction];
}

- (id)copyWithZone:(NSZone *)zone
{
    Colors *copy = [[Colors alloc] init];
    
    if (copy) {

        copy.color = [self.color copyWithZone:zone];
        copy.score = self.score;
        copy.pixelFraction = self.pixelFraction;
    }
    
    return copy;
}


@end
