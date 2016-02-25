//
//  GCVLabelAnnotation.h
//
//  Created by Alan.Yen on 2016/2/25
//  Copyright (c) 2016 17life All rights reserved.
//

#import "GCVRootObject.h"
#import "GCVBoundingPoly.h"
#import "GCVLocationInfo.h"
#import "GCVProperty.h"

@interface GCVEntityAnnotation : GCVRootObject

@property (strong, nonatomic) NSString *mid;
@property (strong, nonatomic) NSString *locale;
@property (strong, nonatomic) NSString *annotationsDescription;
@property (assign, nonatomic) double score;
@property (assign, nonatomic) double confidence;
@property (assign, nonatomic) double topicality;
@property (strong, nonatomic) GCVBoundingPoly *boundingPoly;
@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) NSArray *properties;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end