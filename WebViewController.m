//
//  WebViewController.m
//  buddyApp
//
//  Created by Manish Anand on 10/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    UIWebView * web;
    UIActivityIndicatorView *actInd;
}
@end

@implementation WebViewController

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
    [web loadRequest:requestObj];
    [self.view addSubview:web];
    NSLog(@"%f",_lat);
    
    
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
    
    
    UITextField *field  = [[UITextField alloc]initWithFrame:CGRectMake(20, 490, 70, 50)];
    field.placeholder = @"paste link here";
    [self.view addSubview:field];
    
    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(250, 490, 60, 70)];
    [self.view addSubview:shareButton];
    [shareButton setBackgroundColor:[UIColor redColor]];
    [shareButton addTarget:self action:@selector(shareText) forControlEvents:UIControlEventTouchUpInside];
  
    
}
- (void)shareText    {
    NSLog(@"hell");
    NSMutableArray *sharingItems = [NSMutableArray new];
    //        if (text) {
    //            [sharingItems addObject:text];
    //        }
    //        if (image) {
    //            [sharingItems addObject:image];
    //        }
    //        if (url) {
    //            [sharingItems addObject:url];
    //        }
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:web{
    
    [actInd startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [actInd stopAnimating];
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
