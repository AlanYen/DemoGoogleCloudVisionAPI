//
//  GCVRootObject.h
//
//  Created by AlanYen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCVRootObject : NSObject

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end
