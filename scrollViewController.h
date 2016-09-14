//
//  scrollViewController.h
//  buddyApp
//
//  Created by Manish Anand on 31/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuddyViewController.h"
#import "AppDelegate.h"
@interface scrollViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
     AppDelegate *appdelegate;
}
@property (weak, nonatomic) IBOutlet UIScrollView *svc;
@property (weak, nonatomic) IBOutlet UIPageControl *pgc;
@property (weak, nonatomic) IBOutlet UIView *viewGray;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *leftPg;
@property (weak, nonatomic) IBOutlet UIButton *centerPgc;
@property (weak, nonatomic) IBOutlet UIButton *rightPgc;
- (IBAction)changePage:(id)sender;
- (IBAction)nextPageAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
- (IBAction)skipAction:(id)sender;

@end
