//
//  ViewController.h
//  scrollViewPagingPractice
//
//  Created by Manish Anand on 31/03/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import "BuddyViewController.h"
#import "contactUsScreen.h"
@interface ViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pgControl;
- (IBAction)skipAction:(id)sender;
- (IBAction)nextAction:(id)sender;

@end

