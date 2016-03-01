//
//  LandmarkDetectionViewController.m
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "LandmarkDetectionViewController.h"
#import "GCVLandmarkDetection.h"
#import "SVProgressHUD.h"

@interface LandmarkDetectionViewController ()

@property (strong, nonatomic) GCVLandmarkDetection *landmarkDetection;

@end

@implementation LandmarkDetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Landmark Detection";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - [Call Google Cloud Vision API]

- (void)processDetection {
    
    [SVProgressHUD show];
    
    [self beforeDtection];
    
    [self preProcessImage:^(NSString *imageString) {
        
        __weak LandmarkDetectionViewController *weakSelf = self;
        self.landmarkDetection = [[GCVLandmarkDetection alloc] init];
        [self.landmarkDetection getLandmarkDetection:imageString
                                           maxResult:10
                                          completion:^(GCVError *error)
         {
             [SVProgressHUD dismiss];
             
             [weakSelf afterDtection];
             
             if (error) {
                 weakSelf.textView.text = error.message;
             }
             else {
                 NSMutableString *textString = [NSMutableString new];
                 for (GCVEntityAnnotation *annotation in weakSelf.landmarkDetection.annotations) {
                     if (annotation.annotationsDescription.length <= 0) {
                         continue;
                     }
                     
                     [textString appendString:annotation.annotationsDescription];
                     [textString appendString:@" ("];
                     [textString appendString:[@(annotation.score) stringValue]];
                     [textString appendString:@")"];
                     [textString appendString:@"\n"];
                     
                     GCVLocationInfo *locationInfo = (GCVLocationInfo *)[annotation.locations firstObject];
                     [textString appendString:@"Location:"];
                     [textString appendString:[@(locationInfo.latLng.latitude) stringValue]];
                     [textString appendString:@","];
                     [textString appendString:[@(locationInfo.latLng.longitude) stringValue]];
                     [textString appendString:@"\n"];
                     [textString appendString:@"\n"];
                 }
                 weakSelf.textView.text = textString;
             }
         }];
    }];
}

@end
