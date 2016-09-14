//
//  PageContentViewController.m
//  scrollViewPagingPractice
//
//  Created by Manish Anand on 31/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _pageControl.backgroundColor = [UIColor whiteColor];
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)skipAction:(id)sender {
}

- (IBAction)nextAction:(id)sender {
}
@end
