//
//  contactUsScreen.h
//  buddyApp
//
//  Created by Manish Anand on 20/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuddyViewController.h"
#import "AppDelegate.h"
#import "DirectionToErginusViewController.h"
@interface contactUsScreen : UIViewController<CLLocationManagerDelegate,UIWebViewDelegate,UIPopoverPresentationControllerDelegate>
{
    AppDelegate *appdelegate;
    DirectionToErginusViewController *routeToErginus;
}
@property (weak, nonatomic) IBOutlet UIButton *shareAppButton;
- (IBAction)shareAppButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *fullScreenWebView;
@property (weak, nonatomic) IBOutlet UIButton *dismissWebViewRoute;

@property (weak, nonatomic) IBOutlet UIButton *directionToErginusButton;

- (IBAction)ddirectionToErginusButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
