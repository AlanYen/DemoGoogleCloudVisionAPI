//
//  DetailViewController.h
//  DemoGoogleCloudVisionAPI
//
//  Created by AlanYen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

