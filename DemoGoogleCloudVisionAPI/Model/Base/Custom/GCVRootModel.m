//
//  GCVRootModel.m
//
//  Created by Alan.Yen on 2016/2/24.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "GCVRootModel.h"

@implementation GCVRootModel

+ (void)sendPostRequestWithBaseURL:(NSURL *)baseURL
                            action:(NSString *)action
                         imageData:(NSString *)imageString
                         maxResult:(NSInteger)maxResult
                        completion:(GCVCompletionBlock)completion {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:baseURL];
    [request setHTTPMethod: @"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *paramsDictionary =
    @{@"requests":@[@{@"image": @{@"content":imageString},
                      @"features":@[@{@"type":action, @"maxResults":@(maxResult)}]}]};
    
    NSError *error;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:paramsDictionary options:0 error:&error];
    [request setHTTPBody: requestData];
    
    // Run the request on a background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLSessionDataTask *task =
        [[NSURLSession sharedSession] dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
         {
             if (completion) {
                 if (error) {
                     GCVError *networkError = [[GCVError alloc] init];
                     networkError.message = @"Network Error";
                     completion(nil, networkError);
                 }
                 else {
                     NSError *e = nil;
                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&e];
                     if (!json || e) {
                         GCVError *parseError = [[GCVError alloc] init];
                         parseError.message = @"Data Format Error";
                         completion(nil, parseError);
                     }
                     else {
                         NSLog(@"%@", [json description]);
                         
                         NSArray *responses = [json objectForKey:@"responses"];
                         NSDictionary *responseDict = (responses.count > 0) ? [responses firstObject] : nil;
                         NSDictionary *errorDict = [json objectForKey:@"error"];
                         if (responseDict && !errorDict) {
                             if (responseDict.allKeys.count == 0) {
                                 GCVError *noResultError = [[GCVError alloc] init];
                                 noResultError.message = @"No Result";
                                 completion(nil, noResultError);
                             }
                             else {
                                 completion(responseDict, nil);
                             }
                         }
                         else {
                             completion(nil, [GCVError modelObjectWithDictionary:errorDict]);
                         }
                     }
                 }
             }
         }];
        
        [task resume];
    });
}

+ (NSURL *)baseURL {
    static NSURL *baseURL;
    if (!baseURL) {
        NSString *urlString = @"https://vision.googleapis.com/v1/images:annotate?key=";
        NSString *API_KEY = @"xxx";
        baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", urlString, API_KEY]];
    }
    return baseURL;
}

@end