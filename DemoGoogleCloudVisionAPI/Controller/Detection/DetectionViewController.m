//
//  LandmarkDetectionViewController.m
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "DetectionViewController.h"
#import "SVProgressHUD.h"
#import "GCVError.h"

@interface DetectionViewController () <UIImagePickerControllerDelegate,
                                       UINavigationControllerDelegate>

@end

@implementation DetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Detection";
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.imageView.layer.borderWidth = (1.0 / [UIScreen mainScreen].scale);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - [按鍵事件]

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
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        [self processDetection];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)imagePicker {

    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - [Image processing]

- (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, image.scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSString *)preProcessImage {
    
    NSData *imagedata = UIImagePNGRepresentation(self.image);
    NSUInteger dataLength = [imagedata length];
    // simple way to process image
    if (dataLength > 4194304) {
        CGFloat scale = ((CGFloat)4194304 / dataLength);
        CGSize oldSize = [self.image size];
        CGSize newSize = CGSizeMake((oldSize.width * scale),
                                    (oldSize.height / oldSize.width * (oldSize.width * scale)));
        self.image = [self resizeImage:self.image toSize:newSize];
        imagedata = UIImagePNGRepresentation(self.image);
    }
    NSLog(@"Image size: (%zd bytes)", [imagedata length]);
    
    NSString *base64String = [imagedata base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    return base64String;
}

- (void)beforeDtection {
    
    self.imageView.image = nil;
    self.textView.text = @"";
}

- (void)afterDtection {
    
    CGFloat containerWidth = CGRectGetWidth(self.containerView.frame);
    CGFloat containerHeight = CGRectGetHeight(self.containerView.frame);
 
    UIImage *image = self.image;
    if (image.size.width >= containerWidth) {
        CGFloat newHeight = (image.size.height * (containerWidth / image.size.width));
        image = [self resizeImage:image toSize:CGSizeMake(containerWidth, newHeight)];
    }
    if (image.size.height >= containerHeight) {
        CGFloat newWidth = (image.size.width * (containerHeight / image.size.height));
        image = [self resizeImage:image toSize:CGSizeMake(newWidth, containerHeight)];
    }
    
    self.scaleRatioForDisplay = (image.size.width / self.image.size.width);
    
    self.imageView.image = image;
    self.imageViewWidthConstraint.constant = image.size.width;
    self.imageViewHeightConstraint.constant = image.size.height;
    self.textView.text = @"";
}

- (CGRect)translateRect:(CGRect)rect {
    
    CGRect newRect = CGRectMake(rect.origin.x * self.scaleRatioForDisplay,
                                rect.origin.y * self.scaleRatioForDisplay,
                                rect.size.width * self.scaleRatioForDisplay,
                                rect.size.height * self.scaleRatioForDisplay);
    return newRect;
}

- (void)processDetection {
}

@end
