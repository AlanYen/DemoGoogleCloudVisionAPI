//
//  Color.m
//
//  Created by   on 2016/2/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Color.h"


NSString *const kColorRed = @"red";
NSString *const kColorGreen = @"green";
NSString *const kColorBlue = @"blue";


@interface Color ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Color

@synthesize red = _red;
@synthesize green = _green;
@synthesize blue = _blue;


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
            self.red = [[self objectOrNilForKey:kColorRed fromDictionary:dict] doubleValue];
            self.green = [[self objectOrNilForKey:kColorGreen fromDictionary:dict] doubleValue];
            self.blue = [[self objectOrNilForKey:kColorBlue fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.red] forKey:kColorRed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.green] forKey:kColorGreen];
    [mutableDict setValue:[NSNumber numberWithDouble:self.blue] forKey:kColorBlue];

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

    self.red = [aDecoder decodeDoubleForKey:kColorRed];
    self.green = [aDecoder decodeDoubleForKey:kColorGreen];
    self.blue = [aDecoder decodeDoubleForKey:kColorBlue];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_red forKey:kColorRed];
    [aCoder encodeDouble:_green forKey:kColorGreen];
    [aCoder encodeDouble:_blue forKey:kColorBlue];
}

- (id)copyWithZone:(NSZone *)zone
{
    Color *copy = [[Color alloc] init];
    
    if (copy) {

        copy.red = self.red;
        copy.green = self.green;
        copy.blue = self.blue;
    }
    
    return copy;
}


@end
