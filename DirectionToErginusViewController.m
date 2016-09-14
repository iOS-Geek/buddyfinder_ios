//
//  DirectionToErginusViewController.m
//  buddyApp
//
//  Created by Manish Anand on 28/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "DirectionToErginusViewController.h"

@interface DirectionToErginusViewController ()
{
    
    CLLocationManager *locationManagerLink;
    
    float a,b;
    NSURLRequest *requestObj ;
    //    session *obj;
    UITextField *codeField,*inputField;
    NSTimer *locationUpdateTimer ;
    int count;
    CLLocation *currentLocation;
    CLLocation *newLocation;
    bool check;
    float time;
    int i;
    bool j;
    int ip;
    int counter;
    UIButton *aboutUsButton;
    UIView *theView;
    bool change;
    UIButton *backButton;
    UIView *fullview;
    UIAlertController * locationAlert;
    UIButton * okButton;
    UIButton *findRouteButton;
    UIButton *shareButton;
    bool find;
    NSURL *urlStr;
    NSAttributedString *normalPlaceholderForInputField;
    NSString *codeUnique;
    int codeCount;
    bool toggle;
    UITapGestureRecognizer *tapGesture;
    NSString *stringForSharingAppCode;
    UIActivityViewController *controllerForSharingInformation;
    NSAttributedString *emptyFieldPlaceholder;
    UIAlertController *serverAlert;
    NSTimer *timer;
    bool update;
    NSMutableArray *shareLocationCodeMessage;
    
    NSMutableDictionary *routeInputDictionary;
    
    NSDictionary * routeDataDictionary;
    NSString *routeURLString;
    NSURL *routeURL;
    NSString *routeServerStatus;
    NSString *routeServerMessage;
    
    UIAlertController * internetErrorAlert;
    UIAlertAction* okActionInternetError;
    UIPopoverPresentationController *popPresenter;
    UIAlertController * locationErrorAlert;
    UIAlertAction* okActionLocationError;
    UIAlertAction* cancelActionLocationError;
    NSMutableDictionary *locationCodeDictionary;
    
    NSDictionary * dataRecievedDictionary;
    NSString *serverStatus;
    NSString *recievedLocationURLAsString;
    NSString *recievedLocationCode;
    NSString *recievedServerMessage;
    
    UIAlertController * internalServerErrorAlert;
    UIAlertAction* okActionServerError;
    
    NSString * locationLatitudeString;
    NSString * locationLongitudeString;
    NSString *defaultSavedLocationCode;
    
    NSTimeInterval timeIntervalForLocationRefresh;
    NSTimeInterval timeIntervalForWebviewRefresh;
    CLLocationDistance distance;
    double minimumDistance;
    
    NSTimer *webviewTimer;
    NSString *locationError;
    NSString *locationErrorMessage;
    
    
    NSString * newLocationLatitudeString;
    NSString * newLocationLongitudeString;
    
    
}
@end

@implementation DirectionToErginusViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:true animated:false];
    
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //creating and allocating location manager
    locationManagerLink =[[CLLocationManager alloc]init];
    locationManagerLink.delegate=self;
    locationManagerLink.desiredAccuracy = kCLLocationAccuracyBest;
    //locationManagerLink.distanceFilter=16;
    [locationManagerLink requestWhenInUseAuthorization];
    
    //set delegate of WEBVIEW
    _fullScreenWebView.delegate=self;
    _activityIndicator.hidden=true;
    
    //accessing info.plist for alert
    if ([locationManagerLink respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManagerLink requestWhenInUseAuthorization];
    }
    
    timeIntervalForLocationRefresh=[appdelegate.location_refresh_time doubleValue];
    minimumDistance = [appdelegate.location_refresh_distance doubleValue];
    timeIntervalForWebviewRefresh = [appdelegate.webview_refresh_time doubleValue];
    

    locationError = appdelegate.location_error;
    locationErrorMessage = appdelegate.location_error_message;
    
    
    
    update=true;
    toggle=true;
    check=true;
    
        ////START AND SHOW PROGRESS TIMER
            [_activityIndicator startAnimating];
            _activityIndicator.hidden=false;
    
        update=true;
        //RUN A 1 TIME METHOD
            [self showRouteToErginusMethod];
   
    [self performSelector:@selector(methodUpdate) withObject:nil afterDelay:12];

    
}
-(void)runMethod1233:(NSTimer *)timer
{
    check=false;
    [locationManagerLink startUpdatingLocation];
    
}

-(void)webviewRefreshMethodUpdateRoute:(NSTimer *)webviewTimer
{
    check=true;
    [locationManagerLink startUpdatingLocation];
    
}

-(void)methodUpdate
{
    //[locationManagerLink startUpdatingLocation];
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalForLocationRefresh target:self selector:@selector(runMethod1233:) userInfo:nil repeats:YES];
    }
    if (!webviewTimer) {
        webviewTimer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalForWebviewRefresh target:self selector:@selector(webviewRefreshMethodUpdateRoute:) userInfo:nil repeats:YES];
    }
    
}
- (IBAction)dismissWebViewRouteButtonTapped:(id)sender {
    
    update=false;
    [locationManagerLink stopUpdatingLocation];
    
    check=nil;
    [timer invalidate];
    timer=nil;
    timer =NULL;
    [webviewTimer invalidate];
    
    webviewTimer=nil;
    webviewTimer =NULL;
    
    
    //STOP UPDATING LOCATION
    [locationManagerLink stopUpdatingLocation];
    //HIDE WEBVIEW SCREEEN
    _fullScreenWebView.hidden=true;
    _dismissWebViewRoute.hidden=true;
    
    //END TIMER
    
    check=nil;
    [timer invalidate];
    timer=nil;
    timer =NULL;
    [webviewTimer invalidate];
    webviewTimer=nil;
    webviewTimer =NULL;
    [self.navigationController popViewControllerAnimated:false];
}
- (void)locationManager:locationManagerLink
       didFailWithError:(NSError *)error
{
    //GETTING ERROR IF LOCATION UPDATES ARE RESTRICTED
    //NSLog(@"Location Fetching errror - %@",error);
    //[self locationServicesStatusCheckAlertMethod];
}

//UPDATING LOCATION DELEGATE METHOD
- (void)locationManager:locationManagerLink didUpdateLocations:(NSArray *)locations
{
    
    [locationManagerLink stopUpdatingLocation];
    
        
        
        if (currentLocation!=nil)
        {
            newLocation=[locations lastObject];
            distance = [newLocation distanceFromLocation:currentLocation];
            NSLog(@"distance  = %f",distance);
        }
        
        
        //getting current location
        currentLocation = [locations lastObject];
        //getting latitude
        a=currentLocation.coordinate.latitude;
        //GETTING LONGITUDE
        b=currentLocation.coordinate.longitude;
        //set current location to NIL
        //currentLocation=nil;
        
        //NSLog(@"%f %f",a,b);
        
        if (locationLatitudeString!=nil)
        {
            newLocationLatitudeString = [NSString stringWithFormat:@"%f",a];
            newLocationLongitudeString = [NSString stringWithFormat:@"%f",b];
            
        }
        
        
        locationLatitudeString = [NSString stringWithFormat:@"%f",a];
        locationLongitudeString = [NSString stringWithFormat:@"%f",b];
        defaultSavedLocationCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"Person3"];
        //  [NSThread sleepForTimeInterval:5.0];
        
        //[locationManagerLink startUpdatingLocation];
        
        if (defaultSavedLocationCode ==NULL)
        {
            locationCodeDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:locationLatitudeString,@"location_latitude",locationLongitudeString,@"location_longitude",@"rr",@"location_code",nil];
        }
        else
        {
            locationCodeDictionary = [NSMutableDictionary  dictionaryWithObjectsAndKeys:locationLatitudeString,@"location_latitude",locationLongitudeString,@"location_longitude",defaultSavedLocationCode,@"location_code",nil];
        }
        
        [locationManagerLink stopUpdatingLocation];
        
        //calling api through REQUEST MANAGER CLASS
        if ((distance>minimumDistance)||check==true) {
            [RequestManager getFromServer:@"location" parameters:locationCodeDictionary completionHandler:^(NSDictionary *responseDict) {
                
                NSLog(@"%@",responseDict);
                dataRecievedDictionary = [responseDict objectForKey:@"data"];
                serverStatus = [responseDict objectForKey:@"code"];
                
                recievedLocationURLAsString = [dataRecievedDictionary objectForKey:@"location_url"];
                recievedLocationCode = [dataRecievedDictionary objectForKey:@"location_code"];
                recievedServerMessage = [responseDict objectForKey:@"message"];
                
                if (![codeUnique isEqualToString: recievedLocationCode])
                {
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Person3"];
                    
                    [[NSUserDefaults standardUserDefaults] setValue:recievedLocationCode forKey:@"Person3"];
                    if (check==true) {
                        
                        check=false;
                    }
                    
                }
                else
                {
                    if (check==true) {
                        
                        check=false;
                    }
                }
                
                NSURL *url = [NSURL URLWithString:recievedLocationURLAsString];
                requestObj = [NSURLRequest requestWithURL:url];
                //loadinf map
                codeField.text = recievedLocationCode;
                //        NSString *error  = responseDict.error;
                
                //        if (count>1) {
                //            [mapWebView loadRequest:requestObj];
                //
                //        }
                if ([serverStatus isEqualToString:@"1"])
                {
                    
                    if (toggle==false)
                    {
                        [_fullScreenWebView bringSubviewToFront:_activityIndicator];
                        // [_fullScreenWebView loadRequest:requestObj];
                    }
                    else
                    {
                        
                        [locationUpdateTimer invalidate];
                        
                        NSMutableDictionary *diction = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"Person3"],@"from_location_code", @"ERGINUS",@"to_location_code",nil];
                        
                        
                        j=true;
                        
                        [RequestManager getFromServer:@"route" parameters:diction completionHandler:^(NSDictionary *responseDict) {
                            // mapWebView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                            
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
                            
                            NSString *status = [responseDict objectForKey:@"code"];
                            NSString *message = [responseDict objectForKey:@"message"];
                            
                            if ([status isEqualToString:@"1"]) {
                                
                                //
                                if (!_fullScreenWebView.isLoading) {
                                    [_fullScreenWebView loadRequest:requestObj];
                                }
                                
                                
                            }
                            
                            
                            else if (status==nil)
                            {
                                
                                _dismissWebViewRoute.hidden=false;
                                
                                if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                                {
                                    
                                }
                                else{
                                    [self internetConnectionCheckAlertMethod];
                                }
                                
                                [webviewTimer invalidate];
                                webviewTimer=nil;
                                webviewTimer =NULL;
                                
                            }
                            
                            else if ([status isEqualToString:@"0"])
                            {
                                _dismissWebViewRoute.hidden=false;
                                
                                if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                                {
                                    
                                }
                                else{
                                    [self internalServerErrorAlert:message withStatus:status];
                                }
                                
                                [webviewTimer invalidate];
                                webviewTimer=nil;
                                webviewTimer =NULL;
                            }
                            
                            
                            
                        }];
                        
                    }
                    
                    
                    
                }
                else if (serverStatus==nil)
                {
                    
                    _dismissWebViewRoute.hidden=false;
                    
                    if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                    {
                        
                    }
                    else{
                        [self internetConnectionCheckAlertMethod];
                    }
                    
                    
                }
                
                else if ([serverStatus isEqualToString:@"0"])
                {
                    _dismissWebViewRoute.hidden=false;
                    
                    if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                    {
                        
                    }
                    else{
                        [self internalServerErrorAlert:recievedServerMessage withStatus:serverStatus];
                    }
                    
                    
                }
                
                
                
                
                
                
                //timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(runMethod1211) userInfo:nil repeats:NO];
                
            }];
            
        }
        
        //[locationManagerLink stopUpdatingLocation];
    
}



-(void)internalServerErrorAlert:(NSString *)message withStatus:(NSString *)Status
{
    
    internalServerErrorAlert=   [UIAlertController
                                 alertControllerWithTitle:@"Error"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    okActionServerError = [UIAlertAction
                           actionWithTitle:@"OK"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               [internalServerErrorAlert dismissViewControllerAnimated:YES completion:nil];
                               
                           }];
    [internalServerErrorAlert addAction:okActionServerError];
    
    
    // [self presentViewController:locationAlert animated:YES completion:nil];
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [internalServerErrorAlert setModalPresentationStyle:UIModalPresentationPopover];
        
        
        
        popPresenter = [internalServerErrorAlert
                        popoverPresentationController];
        popPresenter.sourceView = _fullScreenWebView;
        popPresenter.sourceRect = _fullScreenWebView.bounds;
        
        if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
        {
            
        }
        else{
            [self presentViewController:internalServerErrorAlert animated:YES completion:nil];
        }
        
        
        
    }
    
    else
    {
        
        if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
        {
            
        }
        else{
            [self presentViewController:internalServerErrorAlert animated:YES completion:nil];
        }
        
        
    }
    
    
    [_activityIndicator stopAnimating];
    
    
    toggle=false;
    
    
}
-(void)showRouteToErginusMethod
{
    routeInputDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"Person3"],@"from_location_code", @"ERGINUS",@"to_location_code",nil];
    
    
    j=true;
    
    [RequestManager getFromServer:@"route" parameters:routeInputDictionary completionHandler:^(NSDictionary *responseDict) {
        // mapWebView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        if (responseDict==nil) {
            NSLog(@"nil dictionary");
        }
        
        
        
        NSLog(@"%@",responseDict);
        //  NSLog(@"%@",[loc returnvalues]);
        routeDataDictionary = [responseDict objectForKey:@"data"];
        routeURLString = [routeDataDictionary objectForKey:@"route_url"];
        
        
        routeURL = [NSURL URLWithString:routeURLString];
        requestObj = [NSURLRequest requestWithURL:routeURL];
        
        //   NSLog(@"%@");
        
        routeServerStatus = [responseDict objectForKey:@"code"];
        routeServerMessage = [responseDict objectForKey:@"message"];
        
        if ([routeServerStatus isEqualToString:@"1"]) {
            
            _fullScreenWebView.hidden=false;
            
            _dismissWebViewRoute.hidden=false;
            // [_fullScreenWebView addSubview:_minimizeBigMapButton];
            [_fullScreenWebView addSubview:_activityIndicator];
            
            
            
            [_fullScreenWebView loadRequest:requestObj];
            
            //[self.view bringSubviewToFront:_fullScreenWebView];
            [_fullScreenWebView bringSubviewToFront:_dismissWebViewRoute];
            //                        [_fullScreenWebView addSubview:_minimizeBigMapButton];
            
            self.navigationController.navigationBar.hidden=true;
            //[_fullScreenWebView bringSubviewToFront:_activityIndicator];
            
            //    //START THE TIMER
        }
        
        else if (routeServerStatus==nil)
        {
            
            _dismissWebViewRoute.hidden=false;
            
            if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
            {
                
            }
            else{
                [self internetConnectionCheckAlertMethod];
            }
            
            
        }
        
        else if ([routeServerStatus isEqualToString:@"0"])
        {
            _dismissWebViewRoute.hidden=false;
            
            if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
            {
                
            }
            else{
                [self internalServerErrorAlert:routeServerMessage withStatus:routeServerStatus];
            }
            
            
        }
        
        
        
        
    }];
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

//CALLED WHEN WEBVIEW START LOADING
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //START TIMER WHILE WEBVIEW IS LOADING
    [_activityIndicator startAnimating];
    self.navigationController.navigationBar.hidden=true;
    
}

//CALLED WHENWEBVIEW FINISH LOADING
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //STOP LOADING WEBVIEW FOR CURRENT LOCATION
    [_fullScreenWebView stopLoading];
    //STOP ACTIVITY INDICATOR
    [_activityIndicator stopAnimating];
    self.navigationController.navigationBar.hidden=false;
    
}

//CALLED WHEN ERROR OCCURS WHILE LOADING WEBVIEW
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    //PRINTING ERROR IF OCCURED
    NSLog(@"error coming %@",error);
}

-(void)internetConnectionCheckAlertMethod
{
    internetErrorAlert=   [UIAlertController
                           alertControllerWithTitle:@"Internet Not Available!!!"
                           message:@"Please enable cellular data or connect to WiFi to start using Buddy Finder app."
                           preferredStyle:UIAlertControllerStyleAlert];
    
    okActionInternetError = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [internetErrorAlert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [internetErrorAlert addAction:okActionInternetError];
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [internetErrorAlert setModalPresentationStyle:UIModalPresentationPopover];
        
        
        
        popPresenter = [internetErrorAlert
                        popoverPresentationController];
        popPresenter.sourceView = _fullScreenWebView;
        popPresenter.sourceRect = _fullScreenWebView.bounds;
        
        if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
        {
            
        }
        else{
            [self presentViewController:internetErrorAlert animated:YES completion:nil];
        }
        
        
    }
    
    else
    {
        
        if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
        {
            
        }
        else{
            [self presentViewController:internetErrorAlert animated:YES completion:nil];
        }
    }
    
    //    [self presentViewController:updateApplicationAlert animated:YES completion:nil];
}


-(void)locationServicesStatusCheckAlertMethod
{
    locationErrorAlert=   [UIAlertController
                           alertControllerWithTitle:locationError
                           message:locationErrorMessage
                           preferredStyle:UIAlertControllerStyleAlert];
    
    okActionLocationError = [UIAlertAction
                             actionWithTitle:@"Settings"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                 [[UIApplication sharedApplication] openURL:url];
                             }];
    cancelActionLocationError = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [locationErrorAlert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
    
    [locationErrorAlert addAction:okActionLocationError];
    [locationErrorAlert addAction:cancelActionLocationError];
    
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [locationErrorAlert setModalPresentationStyle:UIModalPresentationPopover];
        
        
        
        popPresenter = [locationErrorAlert
                        popoverPresentationController];
        popPresenter.sourceView = _fullScreenWebView;
        popPresenter.sourceRect = _fullScreenWebView.bounds;
        
        if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
        {
            
        }
        else{
            [self presentViewController:locationErrorAlert animated:YES completion:nil];
        }
        
        
    }
    
    else
    {
        
        if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
        {
            
        }
        else{
            [self presentViewController:locationErrorAlert animated:YES completion:nil];
        }
    }
    
    
    //    [_activityIndicator stopAnimating];
    //
    //    toggle=false;
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:false];
    [locationManagerLink stopUpdatingLocation];
    [locationUpdateTimer invalidate];
    locationUpdateTimer=nil;
    [timer invalidate];
    timer=nil;
    check=nil;
    [timer invalidate];
    timer=nil;
    timer =NULL;
    [webviewTimer invalidate];
    webviewTimer=nil;
    webviewTimer =NULL;
//    [self.navigationController popViewControllerAnimated:false];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:false];
    
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
