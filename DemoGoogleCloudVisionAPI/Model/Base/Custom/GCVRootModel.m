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
             NSError *e = nil;
             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&e];
             NSArray *responses = [json objectForKey:@"responses"];
             NSDictionary *responseDict = [responses objectAtIndex:0];
             NSDictionary *errorDict = [json objectForKey:@"error"];
             if (completion) {
                 NSLog(@"%@", [responseDict description]);
                 completion(responseDict, errorDict);
             }
         }];
        
        [task resume];
    });
}

+ (NSURL *)baseURL {
    static NSURL *baseURL;
    if (!baseURL) {
        NSString *urlString = @"https://vision.googleapis.com/v1/images:annotate?key=";
        NSString *API_KEY = @"AIzaSyCwYUfEuhdoNq0cgSXEGA9UsFD1HGtEB4Y";
        baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", urlString, API_KEY]];
    }
    return baseURL;
}

@end