//
//  firstTabViewController.m
//  buddyApp
//
//  Created by Manish Anand on 06/06/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "firstTabViewController.h"

@interface firstTabViewController ()
{
    UIPanGestureRecognizer *tapGesture;
     UITouch *touch;
    
    
    
    
   // scrollViewController * scvObject;
    CLLocationManager *locationManagerLink;
   // contactUsScreen *newView;
    bool check;
    bool check2;
    bool fullCheck;
    NSString *shareCodeText;
    bool runOnce;
    double a,b;
    NSURLRequest *requestObj ;
    UITextField *codeField,*inputField;
    NSTimer  *locationUpdateTimer ;
    int count;
    CLLocation *currentLocation;
    CLLocation *newLocation;
    CLLocationDistance distance;
    bool j;
    NSAttributedString *normalPlaceholderForInputField;
    NSString *codeUnique;
    //int codeCount;
    bool toggle;
    //UITapGestureRecognizer *tapGesture;
    NSString *stringForSharingAppCode;
    UIActivityViewController *controllerForSharingInformation;
    NSAttributedString *emptyFieldPlaceholder;
    UIAlertController *serverAlert;
    
    NSMutableDictionary *locationCodeDictionary;
    NSUInteger newLength;
    
    NSString * locationLatitudeString;
    NSString * locationLongitudeString;
    NSString *defaultSavedLocationCode;
    
    NSString * newLocationLatitudeString;
    NSString * newLocationLongitudeString;
    
    NSMutableDictionary *routeInputDictionary;
    NSDictionary * dataRecievedDictionary;
    NSString *serverStatus;
    NSString *recievedLocationURLAsString;
    NSString *recievedLocationCode;
    NSString *recievedServerMessage;
    NSURL *currentLocationUrl ;
    NSString *userSavedCode;
    NSMutableDictionary *routeDictionary;
    NSDictionary * recievedRouteDictionary;
    NSString *routeURLAsString;
    NSURL *routeUrlFromString;
    NSString *routeServerStatus;
    NSString *routeServerMessage;
    NSMutableArray *shareLocationCodeMessage;
    UIAlertController * serverErrorAlert;
    UIAlertAction* okActionServerError;
    UIPopoverPresentationController *popPresenter;
    UIAlertController * locationCheckAlert;
    UIAlertAction* okActionLocationError;
    UIAlertAction* cancelActionLocationError;
    bool condition;
    UIAlertController * internetCheckErrorAlert;
    UIAlertAction* okActionInternetError;
    
    UIWebView * webView;
    NSURLRequest *request;
    UIWebViewNavigationType navigationType;
    UIView *dummyView;
    
    NSTimeInterval timeIntervalForLocationRefresh;
    NSTimeInterval timeIntervalForWebviewRefresh;
    
    bool stopUpdating;
    double minimumDistance;
    
    NSTimer *webviewTimer;
    NSString *locationError;
    NSString *locationErrorMessage;
    NSMutableDictionary * routeDataDictionary2;
    NSString * routeURLString2;
    NSURL * routeURL2;

    
    
    
}
@end

@implementation firstTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tabBarItem hide
    self.hidesBottomBarWhenPushed=YES;
    [self.tabBarController hidesBottomBarWhenPushed];
    self.tabBarItem.title=@"money";
    
    tapGesture = [[UIPanGestureRecognizer alloc]
                  initWithTarget:self
                  action:@selector(dismissKeyboard2:)];
    tapGesture.delegate = self;
    tapGesture.minimumNumberOfTouches=1;
//    tapGesture.direction=UISwipeGestureRecognizerDirectionLeft;
//    tapGesture.direction=UISwipeGestureRecognizerDirectionRight;
//    tapGesture.direction=(UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionRight);
    NSString *str = @"http://google.co.in";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [_mapWebView loadRequest:req];

    tapGesture.cancelsTouchesInView = NO;
    [_mapWebView addGestureRecognizer:tapGesture];
    _mapWebView.userInteractionEnabled=true;

    //creating and allocating location manager
    locationManagerLink =[[CLLocationManager alloc]init];
    locationManagerLink.delegate=self;
    locationManagerLink.desiredAccuracy = kCLLocationAccuracyBest;
    // locationManagerLink.distanceFilter=16;
    [locationManagerLink requestWhenInUseAuthorization];
    
    //accessing info.plist for alert
    if ([locationManagerLink respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManagerLink requestWhenInUseAuthorization];
    }
    [self method];
   //[locationManagerLink startUpdatingLocation];

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return true;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{return true;
}
-(void)dismissKeyboard2:(UIPanGestureRecognizer *) sender {
    
    //textfield resign
//    self.hidesBottomBarWhenPushed=YES;
//    [self.tabBarController hidesBottomBarWhenPushed];

    UIGestureRecognizerState state = [sender state];
    
   self.tabBarController.tabBar.hidden=YES;

//    while (tapGesture.state==UIGestureRecognizerStateChanged) {
//       // self.tabBarController.tabBar.hidden=YES;
//
//    }
//    if (state==UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
//        self.tabBarController.tabBar.hidden=YES;
//        
//   }
//    while (state != UIGestureRecognizerStateEnded) {
//        self.tabBarController.tabBar.hidden=YES;
////        if (state==UIGestureRecognizerStateEnded) {
////            break;
////        }
//
//    }
//    else
//    if (tapGesture.state==UIGestureRecognizerStateEnded) {
//        self.tabBarController.tabBar.hidden=NO;
//
//    }
    if (state == UIGestureRecognizerStateCancelled
        || state == UIGestureRecognizerStateFailed
        || state == UIGestureRecognizerStateEnded)
    {
        // Long press ended, stop the timer
        
        self.tabBarController.tabBar.hidden=NO;

    }
    
    if(UIGestureRecognizerStateRecognized == UIGestureRecognizerStateEnded)
    {
       // self.tabBarController.tabBar.hidden=NO;

    }
    NSLog(@"hello");
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    touch = touches.anyObject;
    
    CGPoint location = [ touch locationInView: _mapWebView];
    
    if(touch.phase==UITouchPhaseBegan)
    {
        NSLog(@"touch phase began at %f   and %f",location.x,location.y);
        self.tabBarController.tabBar.hidden=YES;

        
    }
    //    if(touch.phase == UITouchPhaseEnded)
    //    {
    //        NSLog(@"touch phase ended");
    //    }
    //    if(touch.phase == UITouchPhaseMoved)
    //    {
    //        NSLog(@"touch phase moved");
    //    }
    //    if(touch.phase==UITouchPhaseCancelled)
    //    {
    //        NSLog(@"cancelled");
    //    }
    //
    //
 
    
    //}
    //
    //-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
    //{
    //    UITouch *touch = touches.anyObject;
    //    if(touch.phase ==UITouchPhaseEnded)
    //    {
    //        NSLog(@"touch phase ended");
    //    }
    //}
    //
    //-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
    //{
    //    UITouch *touch = touches.anyObject;
    //    if(touch.phase==UITouchPhaseMoved)
    //    {
    //        NSLog(@"touch is moved");
    //    }
    //}
    //
    //
    //-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
    //{
    //    UITouch *touch = touches.anyObject;
    //    if(touch.phase==UITouchPhaseCancelled)
    //    {
    //        NSLog(@"touch phase cancelled");
    //    }
    //}
    
    
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if(touch.phase ==UITouchPhaseEnded)
    {
        self.tabBarController.tabBar.hidden=NO;

    }
}


-(void)runMethod1222:(NSTimer* )timer

{
    stopUpdating=false;
    if (stopUpdating==false) {
        [locationUpdateTimer invalidate];
        locationUpdateTimer=nil;
        
        //SHOWING PROGRESS TIMER
        //[_activityIndicator startAnimating];
        //UPDATING LOCATION
        [locationManagerLink startUpdatingLocation];
        if (!locationUpdateTimer.isValid) {
            locationUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(runMethod1222:) userInfo:nil repeats:YES];
            
        }
        
    }
    
}
-(void)method
{
    //TIMER FOR UPDATING LOCATION AFTER EVERY 55 SECONDS
    //timeIntervalForLocationRefresh=[appdelegate.location_refresh_time doubleValue];
    
    locationUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalForLocationRefresh target:self selector:@selector(runMethod1222:) userInfo:nil repeats:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//CHECKING FOR ERROR IN LOCATION UPDATE
- (void)locationManager:locationManagerLink
       didFailWithError:error
{
    //GETTING ERROR IF LOCATION UPDATES ARE RESTRICTED
    //NSLog(@"Location Fetching errror - %@",error);
    
    //CHECKING FOR ALREADY PRESENTED ALERT CONTROLLER
    if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
    {
        
    }
    else
    {
        // [self locationServicesStatusCheckAlertMethod];
    }
}


//-(BOOL)actionCheck
//{
//    //    if (locationManagerLink.locationServicesEnabled()) {
//    //
//    //    }
//    return true;
//}

//WEBVIEW DELEGATE METHODS
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

//CALLED WHEN WEBVIEW START LOADING
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //START TIMER WHILE WEBVIEW IS LOADING
    //[_activityIndicator startAnimating];
}

//CALLED WHENWEBVIEW FINISH LOADING
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //STOP LOADING WEBVIEW FOR CURRENT LOCATION
    //[webView stopLoading];
    //STOP ACTIVITY INDICATOR
    //[_activityIndicator stopAnimating];
}

//CALLED WHEN ERROR OCCURS WHILE LOADING WEBVIEW
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    //PRINTING ERROR IF OCCURED
    //NSLog(@"error coming %@",error);
}


//UPDATE LOCATION DELEGATE METHOD
- (void)locationManager:locationManagerLink didUpdateLocations:(NSArray *)locations
{
    if (fullCheck==true) {
        
    }
    [locationManagerLink stopUpdatingLocation];
    
    if (currentLocation!=nil)
    {
        newLocation=[locations lastObject];
        distance = [newLocation distanceFromLocation:currentLocation];
        NSLog(@"distance  = %f",distance);
    }
    //inputCodeTextField.text=[NSString stringWithFormat:@"%f",distance];
    currentLocation = [locations lastObject];
    //getting latitude
    a=currentLocation.coordinate.latitude;
    //GETTING LONGITUDE
    b=currentLocation.coordinate.longitude;
    //set current location to NIL
    //currentLocation=nil;
    
    if (locationLatitudeString!=nil)
    {
        newLocationLatitudeString = [NSString stringWithFormat:@"%f",a];
        newLocationLongitudeString = [NSString stringWithFormat:@"%f",b];
        
    }
    //SAVING LOCATION COORDINATES
    locationLatitudeString = [NSString stringWithFormat:@"%f",a];
    locationLongitudeString = [NSString stringWithFormat:@"%f",b];
    defaultSavedLocationCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"Person3"];
    
    //MAKE DICTIONARY FOR API HITTING
    //IF USER DEFAULT IS NULL
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
    
    
    
        
        
        
        
        
        [RequestManager getFromServer:@"location" parameters:locationCodeDictionary completionHandler:^(NSDictionary *responseDict) {
            
            
            
            
            //NSLog(@"%@",responseDict);
            //SETTING VARIABLES FOR RECIEVING DATA
            dataRecievedDictionary = [responseDict objectForKey:@"data"];
            serverStatus = [responseDict objectForKey:@"code"];
            recievedLocationURLAsString = [dataRecievedDictionary objectForKey:@"location_url"];
            recievedLocationCode = [dataRecievedDictionary objectForKey:@"location_code"];
            recievedServerMessage = [responseDict objectForKey:@"message"];
            shareCodeText = [dataRecievedDictionary objectForKey:@"ios_sharing_text"];
            //CHECKING FOR CODE EXPIRY
            timeIntervalForLocationRefresh=[appdelegate.location_refresh_time doubleValue];
            minimumDistance = [appdelegate.location_refresh_distance doubleValue];
            timeIntervalForWebviewRefresh = [appdelegate.webview_refresh_time doubleValue];
            locationError = appdelegate.location_error;
            locationErrorMessage = appdelegate.location_error_message;
            fullCheck=true;
            [self method];
            
            check2=false;

            if (![recievedLocationCode isEqualToString: codeUnique])
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Person3"];
                [[NSUserDefaults standardUserDefaults] setValue:recievedLocationCode forKey:@"Person3"];
                
               // shareCodeTextField.text=recievedLocationCode;
                
                if (check==true) {
                    check=false;
                }
                
            }
            else
            {
                if (check2==true) {
                   // shareCodeTextField.text=recievedLocationCode;
                    timeIntervalForLocationRefresh=[appdelegate.location_refresh_time doubleValue];
                    minimumDistance = [appdelegate.location_refresh_distance doubleValue];
                    timeIntervalForWebviewRefresh = [appdelegate.webview_refresh_time doubleValue];
                    locationError = appdelegate.location_error;
                    locationErrorMessage = appdelegate.location_error_message;
                    fullCheck=true;
                    [self method];
                    
                    check2=false;
                    
                }
            }
            check=false;
            //pasting code in textfiled only once
            
            //URL FOR CALLING WEBVIEW
            currentLocationUrl = [NSURL URLWithString:recievedLocationURLAsString];
            requestObj = [NSURLRequest requestWithURL:currentLocationUrl];
            
            // IF SERVER IS WORKING AND DATA RECIEVED
            if ([serverStatus isEqualToString:@"1"])
            {                        [_mapWebView loadRequest:requestObj];

                
                //CHECK FOR CURRENT_LOCATION UPDATE(IF TRUE  ROUTE WILL ALSO BE UPDATED)
                if (toggle==false)
                {
                    //[mapWebView bringSubviewToFront:_activityIndicator];
                    if (!_mapWebView.isLoading) {
                        [_mapWebView loadRequest:requestObj];
                    }
                }
                //ROUTE UPDATE IF TOGGLE ==TRUE
                else
                {
                    //SAVING user CURRENT_LOCATION CODE
                    userSavedCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Person3"];
                    //
                    // [locationUpdateTimer invalidate];
                    //HIDE KEYBOARD
                  //  [inputCodeTextField resignFirstResponder];
                    //ROUTE_DICTIONAR FOR API HITTING
                    routeDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"erginus",@"from_location_code",  @"QF867Z",@"to_location_code",nil];
                    
                    
                    
                    //ACCESING ROUTE APPI HITTING
                    
                    
                    
                    
                    
                    
                    [RequestManager getFromServer:@"route" parameters:routeDictionary completionHandler:^(NSDictionary *responseDict)
                     {
                         
                         
                         if (!webviewTimer.isValid) {
                             webviewTimer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalForWebviewRefresh target:self selector:@selector(webviewRefreshMethod:) userInfo:nil repeats:NO];
                         }
                         
                         
                         // NSLog(@"%@",responseDict);
                         //SETTING VARIABLES FOR RECIEVING DATA
                         recievedRouteDictionary = [responseDict objectForKey:@"data"];
                         routeURLAsString = [recievedRouteDictionary objectForKey:@"route_url"];
                         routeUrlFromString = [NSURL URLWithString:routeURLAsString];
                         requestObj = [NSURLRequest requestWithURL:routeUrlFromString];
                         routeServerStatus = [responseDict objectForKey:@"code"];
                         routeServerMessage = [responseDict objectForKey:@"message"];
                         
                         //IF ROUTE API HITTING IS SUCCESSFUL
                         if ([routeServerStatus isEqualToString:@"1"])
                         {
                             [_fullScreenWebView stopLoading];
                             //showing big webview AND BACK BUTTON AND HIDING WELCOME SCREEN
                             [_mapWebView stopLoading];
                             _activityIndicator.hidden=false;
                             
                             
                             
                             [_mapWebView addSubview:_activityIndicator];
                             //mapWebView.hidden=true;
                             if (!_mapWebView.isLoading) {
                                 [_mapWebView loadRequest:requestObj];
                             }
                             //[_fullScreenWebView loadRequest:requestObj];
                             
                             //                                        [self.view bringSubviewToFront:_fullScreenWebView];
                             //                                        [_fullScreenWebView bringSubviewToFront:_minimizeBigMapButton];
                             //                                        [_fullScreenWebView addSubview:_minimizeBigMapButton];
                             //                                        [_fullScreenWebView bringSubviewToFront:_activityIndicator];
                             
                             
                         }
                         //IF INTERNET NOT WORKING
                         else if (routeServerStatus==nil)
                         {
                             //CHECKING FOR ALREADY PRESENTED ALERT CONTROLLER
                             if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                             {
                                 
                             }
                             else
                             {
                                 //CALLING ALERT IF INTERNET NOT WORKING
                                // [self internetConnectionCheckAlertMethod];
                             }
                             [webviewTimer invalidate];
                             webviewTimer=nil;
                             webviewTimer =NULL;
                             check=false;
                             
                         }
                         //IF SERVER NOT WORKING
                         else if([routeServerStatus isEqualToString:@"0"])
                         {
                             //CHECKING FOR ALREADY PRESENTED ALERT CONTROLLER
                             if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                             {
                                 
                             }
                             else
                             {
                                 //PRESENT ALERT IF SERVER IS NOT WORKING
                                 //[self internalServerErrorAlert:routeServerMessage withStatus:routeServerStatus];
                             }
                             
                             [webviewTimer invalidate];
                             webviewTimer=nil;
                             webviewTimer =NULL;
                             check=false;
                             
                         }
                         
                         
                         
                         
                         
                     }];//END OF ROUTE_API_HITTING METHOD
                    
                    
                }
                
                
                
            }
            
            //IF INTERNET NOT WORKING
            else if (serverStatus==nil)
            {
                
                //CHECK IF THERE IS ANYVIEW CONTROLLER ALREADY PRESENTED
                if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                {
                    
                }
                else
                {
                    //CALL ALERT METHOD
                    //[self internetConnectionCheckAlertMethod];
                }
                
                
            }
            
            //IF SERVER NOT WORKING
            else if ([serverStatus isEqualToString:@"0"])
            {
                //CHECKING FOR ALREADY PRESENTED ALERT CONTROLLER
                if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                {
                    
                }
                else
                {
                    //CALL ALERT IN CASE OF SERVER ERROR
                    //[self internalServerErrorAlert:recievedServerMessage withStatus:serverStatus];
                }
                
                
            }
            
            
            
            
            
            
        }];//END OF LOCATION_API_HITTING METHOD
        
        
    
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
