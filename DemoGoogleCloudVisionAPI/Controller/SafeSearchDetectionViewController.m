//
//  SafeSearchDetectionViewController.m
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "SafeSearchDetectionViewController.h"
#import "GCVSafeSearchDetection.h"
#import "SVProgressHUD.h"

@interface SafeSearchDetectionViewController ()

@property (strong, nonatomic) GCVSafeSearchDetection *safeSearchDetection;

@end

@implementation SafeSearchDetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Safe Search Detection";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - [Call Google Cloud Vision API]

- (void)processDetection {
    
    [SVProgressHUD show];
    [self processImage];
    
    __weak SafeSearchDetectionViewController *weakSelf = self;
    self.safeSearchDetection = [[GCVSafeSearchDetection alloc] init];
    [self.safeSearchDetection getSafeSearchDetection:[self base64EncodeImage:self.image]
                                       maxResult:10
                                      completion:^(GCVError *error)
     {
         [SVProgressHUD dismiss];
         if (error) {
             weakSelf.textView.text = error.message;
         }
         else {
             NSMutableString *textString = [NSMutableString new];
             for (GCVSafeSearchAnnotation *annotation in weakSelf.safeSearchDetection.annotations) {
                 
                 [textString appendString:@"spoof: ("];
                 [textString appendString:annotation.spoof];
                 [textString appendString:@")\n"];
                 
                 [textString appendString:@"medical: ("];
                 [textString appendString:annotation.medical];
                 [textString appendString:@")\n"];
                 
                 [textString appendString:@"adult: ("];
                 [textString appendString:annotation.adult];
                 [textString appendString:@")\n"];
                 
                 [textString appendString:@"violence: ("];
                 [textString appendString:annotation.violence];
                 [textString appendString:@")\n"];
             }
             weakSelf.textView.text = textString;
         }
     }];
}

@end
