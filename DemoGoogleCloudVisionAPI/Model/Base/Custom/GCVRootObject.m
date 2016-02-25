//
//  GCVRootObject.m
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "GCVRootObject.h"

@implementation GCVRootObject

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end