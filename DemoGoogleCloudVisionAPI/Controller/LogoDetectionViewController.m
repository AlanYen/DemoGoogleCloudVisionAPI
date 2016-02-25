//
//  LogoDetectionViewController.m
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "LogoDetectionViewController.h"
#import "GCVLogoDetection.h"
#import "SVProgressHUD.h"

@interface LogoDetectionViewController ()

@property (strong, nonatomic) GCVLogoDetection *logoDetection;

@end

@implementation LogoDetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Logo Detection";
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
    
    __weak LogoDetectionViewController *weakSelf = self;
    self.logoDetection = [[GCVLogoDetection alloc] init];
    [self.logoDetection getLogoDetection:[self base64EncodeImage:self.image]
                               maxResult:10
                              completion:^(NSDictionary *errorDict)
     {
         NSMutableString *textString = [NSMutableString new];
         for (GCVEntityAnnotation *annotation in weakSelf.logoDetection.annotations) {
             [textString appendString:annotation.annotationsDescription];
             [textString appendString:@" ("];
             [textString appendString:[@(annotation.score) stringValue]];
             [textString appendString:@")"];
             [textString appendString:@"\n"];
         }
         weakSelf.textView.text = textString;
         
         [SVProgressHUD dismiss];
     }];
}

@end
