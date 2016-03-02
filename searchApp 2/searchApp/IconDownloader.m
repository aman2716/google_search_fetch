//
//  IconDownloader.m
//  searchApp
//
//  Created by Aman on 2/22/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import "IconDownloader.h"
#import "IconRecord.h"
@interface IconDownloader ()

@property (nonatomic, strong) NSURLSessionDataTask *sessionTask;

@end



@implementation IconDownloader
- (void)startDownload
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.appRecord.imgUrl]];
    
    // create an session data task to obtain and download the app icon
    _sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       
                                                       // in case we want to know the response status code
                                                       //NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
                                                       
                                                       //                                                       if (error != nil)
                                                       //                                                       {
                                                       //                                                           if ([error code] == NSURLErrorAppTransportSecurityRequiresSecureConnection)
                                                       //                                                           {
                                                       //                                                               // if you get error NSURLErrorAppTransportSecurityRequiresSecureConnection (-1022),
                                                       //                                                               // then your Info.plist has not been properly configured to match the target server.
                                                       //                                                               //
                                                       //                                                               abort();
                                                       //                                                           }
                                                       //                                                       }
                                                       
                                                       [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                                                           
                                                           UIImage *image = [[UIImage alloc] initWithData:data];
                                                           
                                                           self.appRecord.appIcon = image;
                                                           
                                                           
                                                           // call our completion handler to tell our client that our icon is ready for display
                                                           if (self.completionHandler != nil)
                                                           {
                                                               self.completionHandler();
                                                           }
                                                       }];
                                                   }];
    
    [self.sessionTask resume];
    
}
// -------------------------------------------------------------------------------
//	cancelDownload
// -------------------------------------------------------------------------------
- (void)cancelDownload
{
    [self.sessionTask cancel];
    _sessionTask = nil;
}

@end
