//
//  DetectionViewController.h
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetectionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (assign, nonatomic) CGFloat scaleRatioForDisplay;
@property (strong, nonatomic) UIImage *image;

- (NSString *)preProcessImage;
- (void)beforeDtection;
- (void)afterDtection;
- (CGRect)translateRect:(CGRect)rect;

@end

