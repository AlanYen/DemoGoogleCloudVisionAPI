//
//  DominantColors.m
//
//  Created by   on 2016/2/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DominantColors.h"
#import "Colors.h"


NSString *const kDominantColorsColors = @"colors";


@interface DominantColors ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DominantColors

@synthesize colors = _colors;


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
    NSObject *receivedColors = [dict objectForKey:kDominantColorsColors];
    NSMutableArray *parsedColors = [NSMutableArray array];
    if ([receivedColors isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedColors) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedColors addObject:[Colors modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedColors isKindOfClass:[NSDictionary class]]) {
       [parsedColors addObject:[Colors modelObjectWithDictionary:(NSDictionary *)receivedColors]];
    }

    self.colors = [NSArray arrayWithArray:parsedColors];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForColors = [NSMutableArray array];
    for (NSObject *subArrayObject in self.colors) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForColors addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForColors addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForColors] forKey:kDominantColorsColors];

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

    self.colors = [aDecoder decodeObjectForKey:kDominantColorsColors];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_colors forKey:kDominantColorsColors];
}

- (id)copyWithZone:(NSZone *)zone
{
    DominantColors *copy = [[DominantColors alloc] init];
    
    if (copy) {

        copy.colors = [self.colors copyWithZone:zone];
    }
    
    return copy;
}


@end
