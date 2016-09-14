//
//  firstTabViewController.h
//  buddyApp
//
//  Created by Manish Anand on 06/06/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<CoreLocation/CoreLocation.h>
#import "RequestManager.h"
#import "AppDelegate.h"
@interface firstTabViewController :UIViewController<CLLocationManagerDelegate, UIWebViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UIPopoverControllerDelegate,UIPopoverPresentationControllerDelegate>
{
    AppDelegate *appdelegate;
    
    
}
@property (weak, nonatomic) IBOutlet UIWebView *mapWebView;

@property (weak, nonatomic) IBOutlet UIButton *shareIconButton;
@property (weak, nonatomic) IBOutlet UILabel *shareLocationLabel;
@property (weak, nonatomic) IBOutlet UIButton *findFriendIconButton;
@property (weak, nonatomic) IBOutlet UILabel *findFriendLabel;
@property (weak, nonatomic) IBOutlet UIButton *contactUsIconButton;
@property (weak, nonatomic) IBOutlet UILabel *contactUsLabel;
@property (weak, nonatomic) IBOutlet UITextField *shareCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *shareCodeButton;
//@property (weak, nonatomic) IBOutlet UIWebView *mapWebView;

//second screen hnadlers
@property (weak, nonatomic) IBOutlet UITextField *inputCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *findFriendButton;


//invisible buttons
@property (weak, nonatomic) IBOutlet UIButton *invisibleShareLocationButton;
@property (weak, nonatomic) IBOutlet UIButton *invisibleFindFriendButton;
@property (weak, nonatomic) IBOutlet UIButton *invisibleContactUsButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)contactUsButtonActionTapped:(id)sender;
- (IBAction)invisibleShareLocationButtonTapped:(id)sender;
- (IBAction)invisibleFindFriendButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *contactUsView;

- (IBAction)shareCodeButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *findCodeButtonTapped;
- (IBAction)findRouteButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *textfieldAndButtonView;

@property (weak, nonatomic) IBOutlet UIWebView *fullScreenWebView;
@property (weak, nonatomic) IBOutlet UIButton *minimizeBigMapButton;
- (IBAction)minimizeBigMapButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *alertViewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackTop;
-(void)stopTimers;
@property (weak, nonatomic) IBOutlet UIView *contactUsViewHidden;
-(void)method;
@property (weak, nonatomic) IBOutlet UIView *shareappButtonView;
@property (weak, nonatomic) IBOutlet UIView *directionToerginusButtonView;
@property (weak, nonatomic) IBOutlet UIButton *invisibleShareAppButton;
@property (weak, nonatomic) IBOutlet UIButton *InvisibleRouteToErginusButton;
@property (weak, nonatomic) IBOutlet UIButton *appTuttorialButton;
- (IBAction)showRouteToErginusMethod:(id)sender;
- (IBAction)appTutorialScreenAction:(id)sender;


@end








