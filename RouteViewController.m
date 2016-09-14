//
//  RouteViewController.m
//  buddyApp
//
//  Created by Manish Anand on 10/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "RouteViewController.h"

@interface RouteViewController ()
{
    UIWebView * web;
    UIActivityIndicatorView *actInd;
}

@end

@implementation RouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *fullURL = @"https://maps.google.com/maps?f=d&saddr=30.0,76.0,%20USA&daddr=32.0,76.0";
    web = [[UIWebView alloc]init];
    web.frame = CGRectMake(0, 70, 320, 478);
    web.backgroundColor = [UIColor whiteColor];
    NSString * str = [NSString stringWithFormat:@"http://maps.google.com/maps?z=16&t=m&q=loc:%f+-%f",_lat,_longi];
    NSString *str2 = [NSString stringWithFormat: @"http://maps.google.com/?q=%f,%f",_lat,_longi ];
    
    
    NSURL *url = [NSURL URLWithString:str2];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    web.delegate=self;
  //  [web loadRequest:requestObj];
    [self.view addSubview:web];
    NSLog(@"%f",_lat);
    
    
    UITextField *field  = [[UITextField alloc]initWithFrame:CGRectMake(20, 490, 100, 50)];
    field.placeholder = @"paste link here";
    
    actInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    //Change the color of the indicator, this override the color set by UIActivityIndicatorViewStyleWhiteLarge
    actInd.color=[UIColor blackColor];
    [actInd startAnimating];
    //Put the indicator on the center of the webview
    [actInd setCenter:self.view.center];
    
    //Assign it to the property
    self.activityIndicator=actInd;
    
    //Add the indicator to the webView to make it visible
    [self.view addSubview:actInd];
    
    

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

@end
