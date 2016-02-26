//
//  FaceDetectionViewController.m
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "FaceDetectionViewController.h"
#import "GCVFaceDetection.h"
#import "SVProgressHUD.h"

@interface FaceDetectionViewController ()

@property (strong, nonatomic) GCVFaceDetection *faceDetection;

@end

@implementation FaceDetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Face Detection";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - [Call Google Cloud Vision API]

- (void)processDetection {
    
    // Remove Boundary / Landmark View
    [self removeBoundaryView];
    [self removeLandmarkView];
    
    [SVProgressHUD show];
    [self processImage];
    
    __weak FaceDetectionViewController *weakSelf = self;
    self.faceDetection = [[GCVFaceDetection alloc] init];
    [self.faceDetection getFaceDetection:[self base64EncodeImage:self.image]
                               maxResult:10
                              completion:^(GCVError *error)
     {
         [SVProgressHUD dismiss];
         
         if (error) {
             weakSelf.textView.text = error.message;
         }
         else {
             // Get number of faces detected
             NSInteger numPeopleDetected = [self.faceDetection.annotations count];
             NSString *peopleStr = [NSString stringWithFormat:@"%lu", (unsigned long)numPeopleDetected];
             NSString *faceStr1 = @"People detected: ";
             NSString *faceStr2 = @"\n\nEmotions detected:\n";
             weakSelf.textView.text = [NSString stringWithFormat:@"%@%@%@", faceStr1, peopleStr, faceStr2];
             
             NSMutableDictionary *emotionTotals =
             [NSMutableDictionary dictionaryWithObjects:@[@0.0, @0.0, @0.0, @0.0]
                                                forKeys:@[@"sorrow", @"joy", @"surprise", @"anger"]];
             NSDictionary *emotionLikelihoods = @{@"VERY_LIKELY": @0.9,
                                                  @"LIKELY": @0.75,
                                                  @"POSSIBLE": @0.5,
                                                  @"UNLIKELY": @0.25,
                                                  @"VERY_UNLIKELY": @0.0};
             
             // Sum all detected emotions
             for (GCVFaceAnnotation *faceAnnotation in weakSelf.faceDetection.annotations) {
                 
                 NSString *emotion = @"joy";
                 NSString *likelihood = faceAnnotation.joyLikelihood;
                 double newValue = [emotionLikelihoods[likelihood] doubleValue] + [emotionTotals[emotion] doubleValue];
                 NSNumber *tempNumber = [[NSNumber alloc] initWithDouble:newValue];
                 [emotionTotals setValue:tempNumber forKey:emotion];
                 
                 emotion = @"sorrow";
                 likelihood = faceAnnotation.sorrowLikelihood;
                 newValue = [emotionLikelihoods[likelihood] doubleValue] + [emotionTotals[emotion] doubleValue];
                 tempNumber = [[NSNumber alloc] initWithDouble:newValue];
                 [emotionTotals setValue:tempNumber forKey:emotion];
                 
                 emotion = @"surprise";
                 likelihood = faceAnnotation.surpriseLikelihood;
                 newValue = [emotionLikelihoods[likelihood] doubleValue] + [emotionTotals[emotion] doubleValue];
                 tempNumber = [[NSNumber alloc] initWithDouble:newValue];
                 [emotionTotals setValue:tempNumber forKey:emotion];
                 
                 emotion = @"anger";
                 likelihood = faceAnnotation.angerLikelihood;
                 newValue = [emotionLikelihoods[likelihood] doubleValue] + [emotionTotals[emotion] doubleValue];
                 tempNumber = [[NSNumber alloc] initWithDouble:newValue];
                 [emotionTotals setValue:tempNumber forKey:emotion];
             }
             
             // Get emotion likelihood as a % and display it in the UI
             for (NSString *emotion in emotionTotals) {
                 double emotionSum = [emotionTotals[emotion] doubleValue];
                 double totalPeople = [weakSelf.faceDetection.annotations count];
                 double likelihoodPercent = emotionSum / totalPeople;
                 NSString *percentString = [[NSString alloc] initWithFormat:@"%2.0f%%", (likelihoodPercent * 100)];
                 NSString *emotionPercentString = [NSString stringWithFormat:@"%@%@%@%@", emotion, @": ", percentString, @"\r\n"];
                 weakSelf.textView.text = [weakSelf.textView.text stringByAppendingString:emotionPercentString];
             }
             
             [weakSelf addBoundaryView];
             [weakSelf addLandmarkView];
         }
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
    for (GCVFaceAnnotation *faceAnnotation in self.faceDetection.annotations) {
        GCVFdBoundingPoly *boundingPoly = faceAnnotation.fdBoundingPoly;
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

- (void)removeLandmarkView {
    
    for (UIView *view in  self.imageView.subviews) {
        if (view.tag >= 10000 && view.tag < 100000) {
            [view removeFromSuperview];
        }
    }
}

- (void)addLandmarkView {
    
    NSInteger tag = 10000;
    for (GCVFaceAnnotation *faceAnnotation in self.faceDetection.annotations) {
        for (GCVLandmark *landmark in faceAnnotation.landmarks) {
            CGFloat x = (CGFloat)landmark.gcvPosition.x;
            CGFloat y = (CGFloat)landmark.gcvPosition.y;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, 5.0, 5.0)];
            view.tag = tag++;
            view.backgroundColor = [self colorByLandmarkType:landmark.type];
            [self.imageView addSubview:view];
        }
    }
}

- (UIColor *)colorByLandmarkType:(NSString *)type {
    
    if ([type rangeOfString:@"EYEBROW"].location != NSNotFound) {
        // 眉毛
        return [UIColor yellowColor];
    }
    else if ([type rangeOfString:@"EYE"].location != NSNotFound) {
        // 眼睛
        return [UIColor redColor];
    }
    else if ([type rangeOfString:@"NOSE"].location != NSNotFound) {
        // 鼻子
        return [UIColor greenColor];
    }
    else if ([type rangeOfString:@"LIP"].location != NSNotFound) {
        // 嘴唇
        return [UIColor blueColor];
    }
    else if ([type rangeOfString:@"EAR"].location != NSNotFound) {
        // 耳朵
        return [UIColor purpleColor];
    }
    else if ([type rangeOfString:@"MOUTH"].location != NSNotFound) {
        // 嘴巴
        return [UIColor orangeColor];
    }
    else if ([type rangeOfString:@"FOREHEAD"].location != NSNotFound) {
        // 前額
        return [UIColor brownColor];
    }
    else {
        NSLog(@"%@", type);
        return [UIColor cyanColor];
    }
}

@end
