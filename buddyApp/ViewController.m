//
//  ViewController.m
//  scrollViewPagingPractice
//
//  Created by Manish Anand on 31/03/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIPageControl *pg;
    BuddyViewController *bd;
    contactUsScreen *cs;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _pageImages = @[@"working.png", @"working2.png", @"working3.png"];
    bd=[[BuddyViewController alloc]init];
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate=self;
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height );
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.view bringSubviewToFront:_grayView];
    [self.pageViewController didMoveToParentViewController:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index >= [self.pageImages count]) {
        
        //self.pageViewController dismissViewControllerAnimated:true completion:nil];
        //return [self.storyboard instantiateViewControllerWithIdentifier:@"hello"];;
        //self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"hello"];
        
        //[self.navigationController popViewControllerAnimated:YES]; // this doesn't do anything
        
        
        
//        [self.pageViewController.view removeFromSuperview];
//            [self.pageViewController removeFromParentViewController];
//        [self.view removeFromSuperview];
//    
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0)
{
//    [self.storyboard instantiateViewControllerWithIdentifier:@"hello"];
//    [self.pageViewController dismissViewControllerAnimated:true completion:nil];
//    [self.parentViewController dismissViewControllerAnimated:false completion:nil];
//    [self.navigationController dismissViewControllerAnimated:true completion:nil];
//    [self dismissViewControllerAnimated:true completion:nil];
//    [self.view didMoveToSuperview];
//    
//    [self.pageViewController.view removeFromSuperview];
//    [self.pageViewController removeFromParentViewController];
//    [self.storyboard instantiateViewControllerWithIdentifier:@"hello"];
    
    
    //[self.pageViewController.view removeFromSuperview];
    //[self.pageViewController removeFromParentViewController];
    [self.view removeFromSuperview];
    //[self.storyboard instantiateViewControllerWithIdentifier:@"hello"];
//    BuddyViewController *bdd= [[BuddyViewController alloc]init];
//    [self.navigationController pushViewController:bdd animated:false];

    
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    cs = [[contactUsScreen alloc]init];
    [self.navigationController pushViewController:cs animated:true];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageImages count] == 0) || (index >= [self.pageImages count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"aa"];
    pageContentViewController.imageFile = self.pageImages[index];
    
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}


- (IBAction)startWalkthrough:(id)sender {
}
- (IBAction)skipAction:(id)sender {
}

- (IBAction)nextAction:(id)sender {
}
@end
