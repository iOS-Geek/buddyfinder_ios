//
//  contactUsViewController.m
//  buddyApp
//
//  Created by Manish Anand on 16/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "contactUsViewController.h"

@interface contactUsViewController ()
{
    UIWebView *mapWebView;
    UIActivityIndicatorView *mapLoadingIndicator;
    CLLocationManager *locationManagerLink;
    CLLocation *currentLocation;
    float a,b;
    int s,count;
    NSTimer *timer;
    NSURLRequest *requestObj ;
    float screenWidth,screenHeight;
    UILabel *mapStatus;
    UIButton *mapZoom;
}
@end

@implementation contactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    s=0;
    count=0;
    
    // Do any additional setup after loading the view.
   // [self.navigationController.navigationBar setTitleTextAttributes:
     //@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController setNavigationBarHidden:false];
    self.title=@"Conatct Us";
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];

    //self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];

//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.1875 green:0.1875 blue:0.1875 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor=[UIColor colorWithRed:0.1875 green:0.1875 blue:0.1875 alpha:1 ];
    //UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
//    [img setImage:[UIImage imageNamed:@"box-blur2.png"]];
//    [self.view addSubview:img];
//   self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"box-blur2.png"]];
    
    screenWidth=self.view.frame.size.width;
    screenHeight=self.view.frame.size.height;
    
    
//    UILabel *conactUsHeading = [[UILabel alloc ]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width ,self.view.frame.size.height*0.1)];
//    
//    [conactUsHeading setText:@"Conatct Us"];
//    conactUsHeading.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:conactUsHeading];
//    [conactUsHeading setTextColor:[UIColor whiteColor]];
//    conactUsHeading.adjustsFontSizeToFitWidth=YES;
//    conactUsHeading.minimumScaleFactor=2;
//    [conactUsHeading setFont:[UIFont boldSystemFontOfSize:20]];

    
    UIView *whiteStrip = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeight*0.040,screenWidth,screenHeight*0.1)];
    [self.view addSubview:whiteStrip];
    whiteStrip.backgroundColor = [UIColor whiteColor];
    
    UIImageView *erginusLogo = [[UIImageView alloc]initWithFrame:CGRectMake(0.32*screenWidth, screenHeight*0.063,screenWidth*0.36,screenHeight*0.055 )];
    [erginusLogo setImage:[UIImage imageNamed:@"logo.png"]];

    erginusLogo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:erginusLogo];
    
    
    mapWebView = [[UIWebView alloc]initWithFrame:CGRectMake(10, 0.15*screenHeight+20, screenWidth-20, 0.80*screenHeight-20)];

    
    UIView *addressView = [[UIView alloc]initWithFrame:CGRectMake(0, -5, screenWidth-20, screenHeight*0.25)];
        //[self.view addSubview:addressView];
    addressView.backgroundColor = [UIColor colorWithRed:0.21875 green:0.21875 blue:0.21875 alpha:1.0];
    
    
    
    [addressView.layer setShadowColor:[UIColor blackColor].CGColor];
    [addressView.layer setShadowOpacity:0.8];
    [addressView.layer setShadowRadius:5.0];
    [addressView.layer setShadowOffset:CGSizeMake(3.0, 3.0)];
    [addressView.layer setCornerRadius:4];
    float a,b;
    a=addressView.frame.size.width;
    b=addressView.frame.size.height;
    
    UIImageView *placeImage = [[UIImageView alloc]initWithFrame:CGRectMake(a*0.035, b*0.05, a*0.1, b*0.15)];
    [addressView addSubview:placeImage];
    [placeImage setImage:[UIImage imageNamed:@"12.png"]];
    
    UILabel *erginusLabel = [[UILabel alloc]initWithFrame:CGRectMake(a*0.17, b*0.05, a*0.3, b*0.16)];
    [erginusLabel setText:@"Erginus"];
    [erginusLabel setTextColor:[UIColor whiteColor]];
     erginusLabel.adjustsFontSizeToFitWidth=YES;
    [erginusLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [addressView addSubview:erginusLabel];
    
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(a*0.17, b*0.20, a*0.8, b*0.25)];
    [addressLabel setText:@"E-253 Industrial Area, Phase 8-B, Mohali Punjab India, 160059"];

    [addressLabel setTextColor:[UIColor whiteColor]];
    addressLabel.adjustsFontSizeToFitWidth=YES;
    [addressLabel setFont:[UIFont boldSystemFontOfSize:12]];
    addressLabel.minimumScaleFactor=0.2;
    addressLabel.numberOfLines=2;
    [addressView addSubview:addressLabel];

    UIImageView *messageImage = [[UIImageView alloc]initWithFrame:CGRectMake(a*0.035, b*0.5,a*0.1, b*0.15)];
    [messageImage setImage:[UIImage imageNamed:@"mail.png"]];
    
    [addressView addSubview:messageImage];
    
    UILabel *mailLabel = [[UILabel alloc]initWithFrame:CGRectMake(a*0.17, b*0.48, a*0.6, b*0.2)];
    [mailLabel setText:@"info@erginus.com"];
    
    [mailLabel setTextColor:[UIColor whiteColor]];
    mailLabel.adjustsFontSizeToFitWidth=YES;
    [mailLabel setFont:[UIFont boldSystemFontOfSize:12]];
    addressLabel.minimumScaleFactor=0.2;
//    addressLabel.numberOfLines=2;

    [addressView addSubview:mailLabel];
    
    
    UIImageView *phoneImage = [[UIImageView alloc]initWithFrame:CGRectMake(a*0.035,b*0.75,a*0.1,b*0.17)];
    [phoneImage setImage:[UIImage imageNamed:@"phone.png"]];
    [addressView addSubview:phoneImage];
    
    UILabel *phoneNumbersLabel = [[UILabel alloc]initWithFrame:CGRectMake(a*0.17,b*0.68,a*0.75,b*0.28)];
    [phoneNumbersLabel setText:@"+91-977-913-5856, + 91-172-4020155"];
    
    
    [phoneNumbersLabel setTextColor:[UIColor whiteColor]];
    phoneNumbersLabel.adjustsFontSizeToFitWidth=YES;
    [phoneNumbersLabel setFont:[UIFont boldSystemFontOfSize:14]];
    phoneNumbersLabel.minimumScaleFactor=0.2;
    addressLabel.numberOfLines=2;

    
    [addressView addSubview:phoneNumbersLabel];
    
    
    mapStatus = [[UILabel alloc]initWithFrame:CGRectMake(0.15 *screenWidth, 0.13*screenHeight+20, 0.7*screenWidth, 0.08*screenHeight-20)];
    mapStatus.backgroundColor = [UIColor whiteColor];
    
//    mapStatus.text = @"Swipe down";
//    [self.view addSubview:mapStatus];
    
    UITapGestureRecognizer *swipeDownMap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown:)];
    swipeDownMap.delegate=self;
    //swipeDownMap.direction = UISwipeGestureRecognizerDirectionDown;
   // [self.view addGestureRecognizer:swipeDownMap];
    
    
    
    
    //creating a webview for location/map
   
    //setting border width  ON WEBVIEW
    //  mapWebView.layer.borderWidth=2;
    //SETTING BORDER COLOR ON WEBVIEW
    // mapWebView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //ADDING WEBVIEW TO SCREEN
    [self.view addSubview:mapWebView];
    //SET DELEGATE FOR WEBVIEW
    mapWebView.delegate=self;
    
    [mapWebView addSubview:addressView];
    
    [mapWebView.layer setCornerRadius:4];
    mapWebView.layer.cornerRadius=4.0;
    mapWebView.userInteractionEnabled=true;
    [self.view setUserInteractionEnabled:true];
    
    
    mapZoom = [[ UIButton alloc]initWithFrame:CGRectMake(0.91*screenWidth, 0.040*screenHeight, 0.04*screenWidth, 0.25*screenHeight)];
//    [mapWebView addSubview:mapZoom];
//    mapZoom.backgroundColor = [UIColor greenColor];
//    [mapWebView bringSubviewToFront:mapZoom];
    
    //indicator for map loading
    mapLoadingIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //Change the color of the indicator
    mapLoadingIndicator.color=[UIColor blackColor];
    //start indicator till map loads
    [mapLoadingIndicator startAnimating];
    //Put the indicator on the center of the webview
    [mapLoadingIndicator setCenter:self.view.center];
    //Assign it to the property
    //self.activityIndicator=mapLoadingIndicator;
    //Add the indicator to the webView to make it visible
    [mapWebView addSubview:mapLoadingIndicator];
    
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard3:)];
    swipe.delegate=self;
    swipe.direction=UISwipeGestureRecognizerDirectionUp;
   // [mapWebView addGestureRecognizer:swipe];

//    NSMutableDictionary *diction = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"Person2"],@"from_location_code",@"ERGINUS",@"to_location_code",nil];
    
       NSMutableDictionary *diction = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"KLGYNS",@"from_location_code",@"ERGINUS",@"to_location_code",nil];
    
    [mapWebView reload];
//    [backButton setHidden:false];
//    
//    [mapWebView bringSubviewToFront:backButton];
//    
    //mapWebView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//    j=true;
    
    [RequestManager getFromServer:@"route" parameters:diction completionHandler:^(NSDictionary *responseDict) {
        
        if (responseDict==nil) {
            NSLog(@"nil dictionary");
        }
        NSLog(@"%@",responseDict);
        //  NSLog(@"%@",[loc returnvalues]);
        NSDictionary * dictionary = [responseDict objectForKey:@"data"];
        NSString *str = [dictionary objectForKey:@"route_url"];
        
        NSURL *url = [NSURL URLWithString:str];
        requestObj = [NSURLRequest requestWithURL:url];
        
        //   NSLog(@"%@");
        [mapWebView loadRequest:requestObj];
        //NSLog(@"loans: %@", latestLoans
        //[backButton setHidden:false];
        //[mapWebView loadRequest:requestObj];
        
        //  [mapWebView loadRequest:requestObj];
        
        
    }];

    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger selectedTag = tabBar.selectedItem.tag;
    NSLog(@"tabbar");
    NSLog(@"%ld",(long)selectedTag);
    if (selectedTag == 0) {
        //Do what ever you want here
    } else if(selectedTag == 1) {
        //Do what ever you want
    } else { //if(selectedTag == 2)
        //Do what ever you want here
    }
}


-(void)swipeDown:(UITapGestureRecognizer *)sender
{
     mapWebView.frame=CGRectMake(0, 0.520*screenHeight+20, screenWidth, 0.325*screenHeight-20);
}


-(void)dismissKeyboard3:(UISwipeGestureRecognizer *) sender {
//    [inputField resignFirstResponder];
//    [codeField resignFirstResponder];
//    
//    [inputField endEditing:true];
    if (sender.direction==UISwipeGestureRecognizerDirectionUp) {
         mapWebView.frame=CGRectMake(0, 0.220*screenHeight+20, screenWidth, 0.825*screenHeight-20);
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionDown)
    {
        mapWebView.frame=CGRectMake(0, 0.520*screenHeight+20, screenWidth, 0.325*screenHeight-20);
    }
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


- (void)locationManager:locationManagerLink didUpdateLocations:(NSArray *)locations
{
    //getting current location
    currentLocation = [locations lastObject];
    //getting latitude
    a=currentLocation.coordinate.latitude;
    //GETTING LONGITUDE
    b=currentLocation.coordinate.longitude;
    currentLocation=nil;
    
    count++;
    NSLog(@"%f %f",a,b);
    int s;
    s=0;
    NSString * p = [NSString stringWithFormat:@"%f",a];
    NSString * q = [NSString stringWithFormat:@"%f",b];
    NSString *r = [[NSUserDefaults standardUserDefaults] stringForKey:@"Person2"];
    //  [NSThread sleepForTimeInterval:5.0];
    
    [locationManagerLink startUpdatingLocation];
    NSMutableDictionary *diction;
    if (r ==NULL)
    {
        diction = [NSMutableDictionary dictionaryWithObjectsAndKeys:p,@"location_latitude",q,@"location_longitude",@"rr",@"location_code",nil];
    }
    else
    {
        diction = [NSMutableDictionary  dictionaryWithObjectsAndKeys:p,@"location_latitude",q,@"location_longitude",r,@"location_code",nil];
    }
    
    //calling api through REQUEST MANAGER CLASS
    [RequestManager getFromServer:@"location" parameters:diction completionHandler:^(NSDictionary *responseDict) {
        
        NSLog(@"%@",responseDict);
        NSDictionary * dictionary = [responseDict objectForKey:@"data"];
        NSString *location_url = [dictionary objectForKey:@"location_url"];
        NSString *location_code = [dictionary objectForKey:@"location_code"];
        NSURL *url = [NSURL URLWithString:location_url];
        requestObj = [NSURLRequest requestWithURL:url];
        //loadinf map
        //codeField.text = location_code;
        
        
        //        if (count>1) {
        //            [mapWebView loadRequest:requestObj];
        //
        //        }
        [mapWebView loadRequest:requestObj];
        if ([[NSUserDefaults standardUserDefaults] stringForKey:@"Person2"]==nil)
        {
            [[NSUserDefaults standardUserDefaults] setValue:location_code forKey:@"Person2"];
        }
        
        timer = [NSTimer scheduledTimerWithTimeInterval:25 target:self selector:@selector(runMethod1211) userInfo:nil repeats:NO];
        
    }];
    
    
    [locationManagerLink stopUpdatingLocation];
    
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
