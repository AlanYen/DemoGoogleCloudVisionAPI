//
//  DetailViewController.m
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "DetailViewController.h"
#import "GCVFaceDetection.h"

@interface DetailViewController () <UIImagePickerControllerDelegate,
                                    UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) GCVFaceDetection *faceDetection;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.detailTitle;
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.imageView.layer.borderWidth = (1.0 / [UIScreen mainScreen].scale);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按鍵

- (IBAction)onSelectPhotoButtonPressed:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)imagePicker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    self.image = info[UIImagePickerControllerOriginalImage];
    NSLog(@"原始圖檔大小: %@", NSStringFromCGSize(self.image.size));
    
    CGFloat containerWidth = CGRectGetWidth(self.containerView.frame);
    CGFloat containerHeight = CGRectGetHeight(self.containerView.frame);
    if (self.image.size.width >= containerWidth) {
        CGFloat newHeight = (self.image.size.height * (containerWidth / self.image.size.width));
        self.image = [self resizeImage:self.image toSize:CGSizeMake(containerWidth, newHeight)];
        NSLog(@"=> 圖檔大小: %@", NSStringFromCGSize(self.image.size));
    }
    
    if (self.image.size.height >= containerHeight) {
        CGFloat newWidth = (self.image.size.width * (containerHeight / self.image.size.height));
        self.image = [self resizeImage:self.image toSize:CGSizeMake(newWidth, containerHeight)];
        NSLog(@"=> 圖檔大小: %@", NSStringFromCGSize(self.image.size));
    }
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        self.imageView.image = self.image;
        self.imageViewWidthConstraint.constant = self.image.size.width;
        self.imageViewHeightConstraint.constant = self.image.size.height;
        [self processFaceDetection];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)imagePicker {

    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Image processing

- (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSString *)base64EncodeImage:(UIImage *)image {
    
    NSLog(@"轉換成 base64 圖檔大小 %@", NSStringFromCGSize(image.size));
    NSData *imagedata = UIImagePNGRepresentation(image);
    // Resize the image if it exceeds the 2MB API limit
    if ([imagedata length] > 2097152) {
        CGSize oldSize = [image size];
        CGSize newSize = CGSizeMake(800, oldSize.height / oldSize.width * 800);
        image = [self resizeImage: image toSize: newSize];
        NSLog(@"=> 轉換成 base64 圖檔大小 %@", NSStringFromCGSize(image.size));
        imagedata = UIImagePNGRepresentation(image);
    }
    NSString *base64String = [imagedata base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    return base64String;
}

- (void)processFaceDetection {
    
    __weak DetailViewController *weakSelf = self;
    self.faceDetection = [[GCVFaceDetection alloc] init];
    [self.faceDetection getFaceDetection:[self base64EncodeImage:self.image]
                               maxResult:10
                              completion:^(NSDictionary *errorDict)
     {
         // Get number of faces detected
         NSInteger numPeopleDetected = [self.faceDetection.faceAnnotations count];
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
         for (GCVFaceAnnotation *faceAnnotation in weakSelf.faceDetection.faceAnnotations) {
             
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
             double totalPeople = [weakSelf.faceDetection.faceAnnotations count];
             double likelihoodPercent = emotionSum / totalPeople;
             NSString *percentString = [[NSString alloc] initWithFormat:@"%2.0f%%", (likelihoodPercent * 100)];
             NSString *emotionPercentString = [NSString stringWithFormat:@"%@%@%@%@", emotion, @": ", percentString, @"\r\n"];
             weakSelf.textView.text = [weakSelf.textView.text stringByAppendingString:emotionPercentString];
         }
         
         [weakSelf processBoundary];
         [weakSelf processLandmark];
     }];
}

- (void)processLandmark {
    
    for (UIView *view in  self.imageView.subviews) {
        if (view.tag >= 10000 && view.tag < 100000) {
            [view removeFromSuperview];
        }
    }
    
    NSInteger tag = 10000;
    for (GCVFaceAnnotation *faceAnnotation in self.faceDetection.faceAnnotations) {
        for (GCVLandmarks *landmark in faceAnnotation.landmarks) {
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
