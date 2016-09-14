//
//  RouteViewController.h
//  buddyApp
//
//  Created by Manish Anand on 10/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic)  float lat,longi;
@property (nonatomic) NSURL *url;
@end
