//
//  MasterViewController.m
//  DemoGoogleCloudVisionAPI
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@property NSArray *objects;
@property NSArray *segueIdentifiers;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    // Refernce:
    // https://github.com/GoogleCloudPlatform/cloud-vision/blob/master/ios/Objective-C/README.md
    //

    self.title = @"Google Cloud Vision API";
    
    self.objects = @[@"Face Detection",
                     @"Label Detection",
                     @"Text Detection (OCR)",
                         
                     @"Logo Detection (商標)",
                     @"Landmark Detection (地標)",
                     @"Safe Search Detection"];
    self.segueIdentifiers = @[@"ToFaceDetectionViewController",
                              @"ToLabelDetectionViewController",
                              @"ToTextDetectionViewController",
                              @"ToLogoDetectionViewController",
                              @"ToLandmarkDetectionViewController",
                              @"ToSafeSearchDetectionViewController"];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = YES;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:self.segueIdentifiers[indexPath.row] sender:self];
}

@end
