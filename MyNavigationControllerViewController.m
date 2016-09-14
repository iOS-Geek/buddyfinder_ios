//
//  MyNavigationControllerViewController.m
//  buddyApp
//
//  Created by Manish Anand on 02/06/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "MyNavigationControllerViewController.h"
#import "scrollViewController.h"
#import "BuddyViewController.h"
@interface MyNavigationControllerViewController ()

@end

@implementation MyNavigationControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"seenTutorial"]  isEqual: @"true"]) {
//        //[self.navigationController dismissViewControllerAnimated:false completion:nil];
//        BuddyViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"hello"];
//        //        ivc.label = self.label.text;
//        [self.navigationController pushViewController:ivc animated:YES];
//        
//    }
//    else{
//        scrollViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"abc"];
//        //        ivc.label = self.label.text;
//        [self.navigationController pushViewController:ivc animated:YES];
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
