//
//  GCVEntityDetection.m
//
//  Created by Alan.Yen on 2016/2/24
//  Copyright (c) 2016 17Life All rights reserved.
//

#import "GCVEntityDetection.h"

@interface GCVEntityDetection ()
@end

@implementation GCVEntityDetection

+ (NSString *)annotationName {
    @throw [NSException exceptionWithName:@"Abstract Method"
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

+ (Class)annotationClass {
    return [GCVEntityAnnotation class];
}

+ (NSString *)actionTypeName {
    @throw [NSException exceptionWithName:@"Abstract Method"
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)initWithDictionary:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        NSObject *receivedAnnotations = [dict objectForKey:[[self class] annotationName]];
        NSMutableArray *parsedAnnotations = [NSMutableArray array];
        if ([receivedAnnotations isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedAnnotations) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedAnnotations addObject:[[[self class] annotationClass] modelObjectWithDictionary:item]];
                }
            }
        }
        else if ([receivedAnnotations isKindOfClass:[NSDictionary class]]) {
            NSDictionary *item = (NSDictionary *)receivedAnnotations;
            [parsedAnnotations addObject:[[[self class] annotationClass] modelObjectWithDictionary:item]];
        }
        self.annotations = [NSArray arrayWithArray:parsedAnnotations];
    }
}

- (void)getEntityDetection:(NSString *)imageString
                 maxResult:(NSInteger)maxResult
                completion:(void (^)(GCVError *error))completion {
    
    [[self class] sendPostRequestWithBaseURL:[GCVRootModel baseURL]
                                      action:[[self class] actionTypeName]
                                   imageData:imageString
                                   maxResult:maxResult
                                  completion:^(NSDictionary *responseDict, GCVError *error)
     {
         if (responseDict && !error) {
             [self initWithDictionary:responseDict];
             if (completion) {
                 dispatch_sync(dispatch_get_main_queue(), ^{
                     completion(nil);
                 });
             }
         }
         else {
             if (completion) {
                 dispatch_sync(dispatch_get_main_queue(), ^{
                     completion(error);
                 });
             }
         }
     }];
}

@end