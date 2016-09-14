//
//  GuideViewController.h
//  buddyApp
//
//  Created by Manish Anand on 30/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *guideScreenScrollview;
@property (weak, nonatomic) IBOutlet UIView *grayTransparentView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet UIImageView *guideImage;

@end
