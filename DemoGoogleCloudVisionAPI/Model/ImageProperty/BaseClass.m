//
//  BaseClass.m
//
//  Created by   on 2016/2/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "BaseClass.h"
#import "ImagePropertiesAnnotation.h"


NSString *const kBaseClassImagePropertiesAnnotation = @"imagePropertiesAnnotation";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize imagePropertiesAnnotation = _imagePropertiesAnnotation;


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
            self.imagePropertiesAnnotation = [ImagePropertiesAnnotation modelObjectWithDictionary:[dict objectForKey:kBaseClassImagePropertiesAnnotation]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.imagePropertiesAnnotation dictionaryRepresentation] forKey:kBaseClassImagePropertiesAnnotation];

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

    self.imagePropertiesAnnotation = [aDecoder decodeObjectForKey:kBaseClassImagePropertiesAnnotation];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imagePropertiesAnnotation forKey:kBaseClassImagePropertiesAnnotation];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseClass *copy = [[BaseClass alloc] init];
    
    if (copy) {

        copy.imagePropertiesAnnotation = [self.imagePropertiesAnnotation copyWithZone:zone];
    }
    
    return copy;
}


@end
