//
//  FaceDetectionViewController.m
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "TextDetectionViewController.h"
#import "GCVTextDetection.h"
#import "SVProgressHUD.h"

@interface TextDetectionViewController ()

@property (strong, nonatomic) GCVTextDetection *textDetection;

@end

@implementation TextDetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Text Detection";
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
    
    __weak TextDetectionViewController *weakSelf = self;
    self.textDetection = [[GCVTextDetection alloc] init];
    [self.textDetection getTextDetection:[self base64EncodeImage:self.image]
                               maxResult:20
                              completion:^(NSDictionary *errorDict)
     {
         [weakSelf removeBoundaryView];
         
         weakSelf.imageView.image = weakSelf.image;
         weakSelf.imageViewWidthConstraint.constant = self.image.size.width;
         weakSelf.imageViewHeightConstraint.constant = self.image.size.height;
         
         NSMutableString *textString = [NSMutableString new];
         for (GCVEntityAnnotation *annotation in weakSelf.textDetection.annotations) {
             [textString appendString:annotation.annotationsDescription];
             [textString appendString:@" ("];
             [textString appendString:annotation.locale];
             [textString appendString:@")"];
             [textString appendString:@"\n"];
         }
         weakSelf.textView.text = textString;
         
         [weakSelf addBoundaryView];
         
         [SVProgressHUD dismiss];
     }];
}

- (void)removeBoundaryView {
    
    for (UIView *view in  self.imageView.subviews) {
        if (view.tag >= 100000 && view.tag < 1000000) {
            [view removeFromSuperview];
        }
    }
}

- (void)addBoundaryView {
    
    NSInteger tag = 100000;
    for (GCVEntityAnnotation *annotation in self.textDetection.annotations) {
        GCVBoundingPoly *boundingPoly = annotation.boundingPoly;
        if (boundingPoly.vertices.count == 4) {
            GCVVertice *vertice0 = [boundingPoly.vertices objectAtIndex:0];
            GCVVertice *vertice1 = [boundingPoly.vertices objectAtIndex:1];
            GCVVertice *vertice2 = [boundingPoly.vertices objectAtIndex:2];
            CGFloat width = (vertice1.x - vertice0.x);
            CGFloat height = (vertice2.y - vertice0.y);
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(vertice0.x, vertice0.y, width, height)];
            view.tag = tag++;
            view.backgroundColor = [UIColor clearColor];
            view.layer.borderColor = [UIColor redColor].CGColor;
            view.layer.borderWidth = (1.0 / [UIScreen mainScreen].scale);
            [self.imageView addSubview:view];
        }
    }
}

@end
