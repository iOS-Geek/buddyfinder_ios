//
//  PageContentViewController.h
//  scrollViewPagingPractice
//
//  Created by Manish Anand on 31/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
- (IBAction)skipAction:(id)sender;
- (IBAction)nextAction:(id)sender;

@end
