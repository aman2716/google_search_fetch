//
//  WebViewController.h
//  searchApp
//
//  Created by Aman on 2/9/16.
//  Copyright © 2016 Aman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *url;
@end
