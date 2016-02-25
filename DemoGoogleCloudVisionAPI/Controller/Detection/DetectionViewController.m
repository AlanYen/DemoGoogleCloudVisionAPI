//
//  LandmarkDetectionViewController.m
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "DetectionViewController.h"
#import "SVProgressHUD.h"

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
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSString *)base64EncodeImage:(UIImage *)image {
    
    NSData *imagedata = UIImagePNGRepresentation(image);
    // Resize the image if it exceeds the 2MB API limit
    if ([imagedata length] > 2097152) {
        CGSize oldSize = [image size];
        CGSize newSize = CGSizeMake(800, oldSize.height / oldSize.width * 800);
        image = [self resizeImage: image toSize: newSize];
        imagedata = UIImagePNGRepresentation(image);
    }
    NSString *base64String = [imagedata base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    return base64String;
}

- (void)processImage {
    
    CGFloat containerWidth = CGRectGetWidth(self.containerView.frame);
    CGFloat containerHeight = CGRectGetHeight(self.containerView.frame);
    if (self.image.size.width >= containerWidth) {
        CGFloat newHeight = (self.image.size.height * (containerWidth / self.image.size.width));
        self.image = [self resizeImage:self.image toSize:CGSizeMake(containerWidth, newHeight)];
    }
    if (self.image.size.height >= containerHeight) {
        CGFloat newWidth = (self.image.size.width * (containerHeight / self.image.size.height));
        self.image = [self resizeImage:self.image toSize:CGSizeMake(newWidth, containerHeight)];
    }
    
    self.imageView.image = self.image;
    self.imageViewWidthConstraint.constant = self.image.size.width;
    self.imageViewHeightConstraint.constant = self.image.size.height;
    self.textView.text = @"";
}

- (void)processDetection {
}

@end
