//
//  DirectionToErginusViewController.h
//  buddyApp
//
//  Created by Manish Anand on 28/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RequestManager.h"
@interface DirectionToErginusViewController : UIViewController<CLLocationManagerDelegate,UIWebViewDelegate,UIPopoverPresentationControllerDelegate>
{
    AppDelegate *appdelegate;
}
@property (weak, nonatomic) IBOutlet UIWebView *fullScreenWebView;
@property (weak, nonatomic) IBOutlet UIButton *dismissWebViewRoute;
- (IBAction)dismissWebViewRouteButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
