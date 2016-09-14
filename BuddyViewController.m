//
//  BuddyViewController.m
//  buddyApp
//
//  Created by Manish Anand on 19/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "BuddyViewController.h"
#import "contactUsScreen.h"
#import "scrollViewController.h"
@interface BuddyViewController ()
{
    scrollViewController * scvObject;
    CLLocationManager *locationManagerLink;
    contactUsScreen *newView;
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
    UITapGestureRecognizer *tapGesture;
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

@implementation BuddyViewController
@synthesize mapWebView;
@synthesize findFriendLabel;
@synthesize findFriendButton;
@synthesize invisibleFindFriendButton;
@synthesize contactUsLabel;
@synthesize shareCodeButton;
@synthesize shareIconButton;
@synthesize shareCodeTextField;
@synthesize shareLocationLabel;
@synthesize invisibleShareLocationButton;
@synthesize findFriendIconButton;
@synthesize inputCodeTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    scvObject = [[scrollViewController alloc]init];
    
    fullCheck=false;
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    runOnce=false;
  
//     normalPlaceholderForInputField = [[NSAttributedString alloc] initWithString:@"Enter Friend's Code" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    stopUpdating=false;
    check2=true;
    //CHECK FOR PASTING CODE ON TEXTFIELD ONCE
        j=1;
    //hide navigation bar
        [self.navigationController setNavigationBarHidden:true];
    
    //sett  TEXTFIELD's DELEGATE
        inputCodeTextField.delegate=self;
        shareCodeTextField.delegate=self;
    
    //checking and saving data if there is LOCATION_CODE
        if ([[NSUserDefaults standardUserDefaults] stringForKey:@"Person3"]!=nil) {
            codeUnique = [[NSUserDefaults standardUserDefaults] stringForKey:@"Person3"];
        }
    mapWebView.scrollView.showsHorizontalScrollIndicator = NO;
    mapWebView.scrollView.showsVerticalScrollIndicator = NO;

    condition= true;
   _minimizeBigMapButton.layer.cornerRadius = 21;
    
    //SET TEXTFIELD TAG
        inputCodeTextField.tag=1;
        shareCodeTextField.tag=2;
    
    //[self internetConnectionCheckAlertMethod];
    //RESIGN KEYBOARD IF PRESENT
        [inputCodeTextField resignFirstResponder];
   
    inputCodeTextField.userInteractionEnabled=true;
    
    check = true;
//    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
//    {
//    appdelegate.enablePortrait=YES;
//    }
//    else
//    {
//        appdelegate.enablePortrait=NO;
//    }
//    appdelegate.enablePortrait=YES;
    
    
    _shareappButtonView.layer.borderWidth=3;
    _shareappButtonView.layer.borderColor=[UIColor whiteColor].CGColor;
    
    _directionToerginusButtonView.layer.borderWidth=1;
    _directionToerginusButtonView.layer.borderColor=[UIColor colorWithRed:0.2196 green:0.2196 blue:0.2196 alpha:1.0].CGColor;
    //SET TEXTFIELD BORDER WIDTH
        shareCodeTextField.layer.borderWidth = 1.0;
    //MAKE SHARE CODEFIELD BLACK TEXT
        shareCodeTextField.textColor = [UIColor whiteColor];
    //SET BACK COLOR OF FIELD
        shareCodeTextField.backgroundColor = [UIColor darkGrayColor];
    //SET BORDER COLOR
        shareCodeTextField.layer.borderColor = [UIColor colorWithRed:0.49 green:0.76 blue:0.274 alpha:1.0].CGColor;
   
    //set WEBVIEW DELEGATE
        mapWebView.delegate=self;
        _fullScreenWebView.delegate=self;
    
    //BRING BACK BUTTON FRONT
        [_fullScreenWebView bringSubviewToFront:_minimizeBigMapButton];

    //CREATE A DUMMYVIEW FOR SHARECODE FIELD
        dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        //ASSIGN VIEW TO SHARECODE FIELD
            shareCodeTextField.inputView = dummyView; // Hide keyboard, but show blinking cursor

    //SET TEXTFIELD BORDER WIDTH
        inputCodeTextField.layer.borderWidth = 1.0;
    //SET TEXT COLOR ON CODEFIELD
        inputCodeTextField.textColor = [UIColor whiteColor];
    //SET BACK COLOR OF FIELD
        inputCodeTextField.backgroundColor = [UIColor darkGrayColor];
    //SET BORDER COLOR
        inputCodeTextField.layer.borderColor = [UIColor colorWithRed:0.49 green:0.76 blue:0.274 alpha:1.0].CGColor;
    
    [self.view bringSubviewToFront:mapWebView];
    //SET BORDER OF SHARECODE BUTTON
        shareCodeButton.layer.borderWidth = 1.0;
    //SET BACK COLOR OF FIELD
        shareCodeButton.backgroundColor = [UIColor darkGrayColor];
    //SET BORDER COLOR
        shareCodeButton.layer.borderColor = [UIColor colorWithRed:0.49 green:0.76 blue:0.274 alpha:1.0].CGColor;
    
    
    //SET INPUTFIELD PLACEHOLDER TO WHITE COLOR
        normalPlaceholderForInputField = [[NSAttributedString alloc] initWithString:@"Enter Friend's Code" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
        inputCodeTextField.attributedPlaceholder = normalPlaceholderForInputField;
    
    //SET INPUTFIELD PLACEHOLDER TO RED COLOR IF NOT EMPTY
    emptyFieldPlaceholder = [[NSAttributedString alloc] initWithString:@"Field EMPTY" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
    //SETTING CORNER RADIUS FOR BACK BUTTON
        _minimizeBigMapButton.layer.cornerRadius=21.0;
    
    //THIS VARIABLE CHECKS IF USER IS SEEING CURRENT LOCATION OR ROUTE
        toggle=false;
    
    //SET BORDER WIDTH ON "FIND FRIEND BUTTON"
        findFriendButton.layer.borderWidth = 1.0;
    //SET TEXT COLOR ON CODEFIELD
   
    //SET BACK COLOR OF FIELD
        findFriendButton.backgroundColor = [UIColor darkGrayColor];
    //SET BORDER COLOR
        findFriendButton.layer.borderColor = [UIColor colorWithRed:0.49 green:0.76 blue:0.274 alpha:1.0].CGColor;
    
    
   
    //

   
    //allocating a tap gesture
        tapGesture = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard2:)];
        tapGesture.delegate = self;
        tapGesture.cancelsTouchesInView = NO;
        [mapWebView addGestureRecognizer:tapGesture];
        mapWebView.userInteractionEnabled=true;
    

    _shareappButtonView.layer.borderColor=[UIColor whiteColor].CGColor;
    _shareappButtonView.layer.borderWidth=2;
    
    _directionToerginusButtonView.layer.borderColor=[UIColor whiteColor].CGColor;
    _directionToerginusButtonView.layer.borderWidth=1;
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
    //START UPDATING LOCATION
        //[locationManagerLink startUpdatingLocation];
    
    
}

-(void)method
{
    //TIMER FOR UPDATING LOCATION AFTER EVERY 55 SECONDS
    //timeIntervalForLocationRefresh=[appdelegate.location_refresh_time doubleValue];
    if (!locationUpdateTimer.isValid) {
         locationUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalForLocationRefresh target:self selector:@selector(runMethod1222:) userInfo:nil repeats:NO];
    }
  
}


//this is a method for dismissing keyboard when user tap anywhere
-(void)dismissKeyboard2:(UITapGestureRecognizer *) sender {
    
    //textfield resign
        [inputCodeTextField resignFirstResponder];
        [shareCodeTextField resignFirstResponder];
    
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // UIKit changes the first responder after this method, so we need to show the copy menu after this method returns.
    if (textField.tag==1) {
        return YES;
    }
    else
           if (textField.tag==2) {
            
            [shareCodeTextField resignFirstResponder];
               return NO;
           // [shareCodeTextField selectAll:self];
        }
    else
    return YES;
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //share code textfield
    if (textField.tag==2) {
        
        //prevent user from editing sharecode field and keyboard showing
            return NO;
    }
    
    //inputcode field
    else
    {
        //resign keyboard
            [shareCodeTextField resignFirstResponder];
        
        //checking for length of textfield
            if(range.length + range.location > textField.text.length)
            {
                return NO;
            }
        
         newLength = [textField.text length] + [string length] - range.length;
        
        //set textfield max length =8
            return newLength <= 8;

    }
    
}

//called when user press enter in textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //HIDE KEYBOARD
    [textField resignFirstResponder];
    
    //returning input codefield and generating route
        if (textField.tag==1)
        {
            //STOP UPDATING LOCATION FOR CURRENT LOCATION
                [locationManagerLink stopUpdatingLocation];
                [_activityIndicator startAnimating];
            //CHANGE URL RQUEST TO  ROUTE REQUEST
                toggle =true;
           //SHOW BACK BUTTON
               // _minimizeBigMapButton.hidden=false;
            //SHOW BACKBUTTON TO FRONT
                //[_fullScreenWebView bringSubviewToFront:_minimizeBigMapButton];
            check = true;
            runOnce=true;
            findFriendLabel.textColor = [UIColor colorWithRed:0.49 green:0.76 blue:0.274 alpha:1.0];
            [findFriendIconButton setImage:[UIImage imageNamed:@"new3.png"] forState:UIControlStateNormal];
            contactUsLabel.textColor = [UIColor whiteColor];
            [_contactUsIconButton setImage:[UIImage imageNamed:@"dss6.png"] forState:UIControlStateNormal];


                //[locationManagerLink startUpdatingLocation];
            if (!webviewTimer.isValid) {
                webviewTimer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalForWebviewRefresh target:self selector:@selector(webviewRefreshMethod:) userInfo:nil repeats:NO];
            }
        }
        //IF ANYOTHER TEXTFIELD
        else
        {
            
        }
    //DEFAULT
        return true;
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
            [_activityIndicator startAnimating];
    }

//CALLED WHENWEBVIEW FINISH LOADING
    - (void)webViewDidFinishLoad:(UIWebView *)webView
    {
        //STOP LOADING WEBVIEW FOR CURRENT LOCATION
            [webView stopLoading];
        //STOP ACTIVITY INDICATOR
            [_activityIndicator stopAnimating];
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
    //[_activityIndicator startAnimating];
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
    
    
    if (distance>minimumDistance||check==true) {
        
   
        [_activityIndicator startAnimating];
            
        
    
    [RequestManager getFromServer:@"location" parameters:locationCodeDictionary completionHandler:^(NSDictionary *responseDict) {
        
        
[_activityIndicator startAnimating];
        
        //NSLog(@"%@",responseDict);
        //SETTING VARIABLES FOR RECIEVING DATA
            dataRecievedDictionary = [responseDict objectForKey:@"data"];
            serverStatus = [responseDict objectForKey:@"code"];
            recievedLocationURLAsString = [dataRecievedDictionary objectForKey:@"location_url"];
            recievedLocationCode = [dataRecievedDictionary objectForKey:@"location_code"];
            recievedServerMessage = [responseDict objectForKey:@"message"];
            shareCodeText = [dataRecievedDictionary objectForKey:@"ios_sharing_text"];
        //CHECKING FOR CODE EXPIRY
            if (![recievedLocationCode isEqualToString: codeUnique])
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Person3"];
                [[NSUserDefaults standardUserDefaults] setValue:recievedLocationCode forKey:@"Person3"];
                
                shareCodeTextField.text=recievedLocationCode;

                if (check==true) {
                    check=false;
                }

            }
            else
            {
                if (check2==true) {
                    shareCodeTextField.text=recievedLocationCode;
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
         {
             
             //CHECK FOR CURRENT_LOCATION UPDATE(IF TRUE  ROUTE WILL ALSO BE UPDATED)
                if (toggle==false)
                {
                    [mapWebView bringSubviewToFront:_activityIndicator];
                    if (!mapWebView.isLoading) {
                        [mapWebView loadRequest:requestObj];
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
                        [inputCodeTextField resignFirstResponder];
                    //ROUTE_DICTIONAR FOR API HITTING
                        routeDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:shareCodeTextField.text,@"from_location_code",  inputCodeTextField.text,@"to_location_code",nil];
                 
                 
                 
                    //ACCESING ROUTE APPI HITTING
                    
                    
                   
                        
                    
                    
                        [RequestManager getFromServer:@"route" parameters:routeDictionary completionHandler:^(NSDictionary *responseDict)
                    {
                        [_activityIndicator startAnimating];
                        
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
                                        //[mapWebView stopLoading];
                                        //showing big webview AND BACK BUTTON AND HIDING WELCOME SCREEN
                                        //[mapWebView stopLoading];
                                        _activityIndicator.hidden=false;
                                        
                                        
                                        
                                        [mapWebView addSubview:_activityIndicator];
                                        //mapWebView.hidden=true;
                                        if (!mapWebView.isLoading) {
                                            [mapWebView loadRequest:requestObj];
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
                                                    [self internetConnectionCheckAlertMethod];
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
                                                    [self internalServerErrorAlert:routeServerMessage withStatus:routeServerStatus];
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
                        [self internetConnectionCheckAlertMethod];
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
                    [self internalServerErrorAlert:recievedServerMessage withStatus:serverStatus];
            }
            
            
        }
        
        
       
        
       
        
    }];//END OF LOCATION_API_HITTING METHOD
    
        
    }
   // [_activityIndicator stopAnimating];
    [locationManagerLink stopUpdatingLocation];
    
}




- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}

//CONTROLLER  LIFECYCLE METHODS
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: false];
    
    //HIDE NAVIGATION BAR IF NOT
        [self.navigationController setNavigationBarHidden:true];
    //HIDE KEYBOARD
        [inputCodeTextField resignFirstResponder];
    check2=true;
    check=true;
    toggle =false;
    [mapWebView addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    [locationManagerLink startUpdatingLocation];
   
    //[self method];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:false];
    //HIDE KEYBOARD
        [inputCodeTextField resignFirstResponder];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doYourStuff)
     
                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
}
-(void)doYourStuff{
    
    NSLog(@"hello");
    check2=true;
    check=true;
    toggle =false;
    [mapWebView addSubview:_activityIndicator];
//    [_activityIndicator startAnimating];
    [locationManagerLink startUpdatingLocation];
    
    // do whatever you want to do when app comes back from background.
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:false];
    //ENDING TIMER METHODS
        [locationUpdateTimer invalidate];
        locationUpdateTimer=nil;
    
    //STOP UPDATING LOCATION
        [locationManagerLink stopUpdatingLocation];
    
    
}



-(void)runMethod1222:(NSTimer* )timer

{
    if (stopUpdating==false) {
        [locationUpdateTimer invalidate];
        locationUpdateTimer=nil;
        
        //SHOWING PROGRESS TIMER
        //[_activityIndicator startAnimating];
        //UPDATING LOCATION
        [locationManagerLink startUpdatingLocation];
        if (!locationUpdateTimer.isValid) {
            locationUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalForLocationRefresh target:self selector:@selector(runMethod1222:) userInfo:nil repeats:NO];
            
        }

    }
    
}







- (IBAction)contactUsButtonActionTapped:(id)sender
{
    stopUpdating=true;
    inputCodeTextField.placeholder  = @"Enter Friend's Code";
    //SET TEXTFIELD HIDDEN
    shareCodeTextField.hidden=true;
    //SHOW INPUTCODE FIELD SHOW
    inputCodeTextField.hidden=false;
    
    //HIDE SHARECODE BUTTON
    shareCodeButton.hidden=true;
    //SHOW FIND FRIEND BUTTON
    findFriendButton.hidden=false;
    
    [locationManagerLink stopUpdatingLocation];
    [webviewTimer invalidate];
    webviewTimer=nil;
    
    locationUpdateTimer=nil;
    [locationUpdateTimer invalidate];
   //SETTING placeholder in inputcodeField
    
        inputCodeTextField.attributedPlaceholder = normalPlaceholderForInputField;

    //ENDING TIMER METHODS
        [locationUpdateTimer invalidate];
        locationUpdateTimer=nil;
    //STOP UPDATING LOCATION
        [locationManagerLink stopUpdatingLocation];
    
    //HIDE KEYBOARD
        [inputCodeTextField resignFirstResponder];
    
    _contactUsView.hidden=false;
    
    //SET PREVIOUS ICONT TO WHITE/NORMAL
    findFriendLabel.textColor = [UIColor whiteColor];
    //SET PREVIOUS ICONT TO WHITE/NORMAL
    [findFriendIconButton setImage:[UIImage imageNamed:@"dss2.png"] forState:UIControlStateNormal];
    //SET PREVIOUS ICONT TO WHITE/NORMAL
    shareLocationLabel.textColor = [UIColor whiteColor];
    //SET PREVIOUS ICONT TO WHITE/NORMAL
    [shareIconButton setImage:[UIImage imageNamed:@"dss.png"] forState:UIControlStateNormal];
    
    //SET CURENT BUTTON AS HIGHLIGHTED
    contactUsLabel.textColor =[UIColor colorWithRed:0.49 green:0.76 blue:0.274 alpha:1.0];
    //SET CURENT BUTTON AS HIGHLIGHTED
    [_contactUsIconButton setImage:[UIImage imageNamed:@"new1.png"] forState:UIControlStateNormal];
    

    
    [self.view bringSubviewToFront:_contactUsView];
    
    
    
    
}
//-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//
//    // Return YES for supported orientations
//    return true;
//
//}




    
    
//SHARE LOCATION TAB CLICKED
- (IBAction)invisibleShareLocationButtonTapped:(id)sender
{
    inputCodeTextField.placeholder  = @"Enter Friend's Code";

    //SETTING placeholder in inputcodeField
   
    stopUpdating=false;
    toggle=false;
    check =true;
    [webviewTimer invalidate];
    webviewTimer=nil;
    webviewTimer =NULL;
    [_activityIndicator startAnimating];
           inputCodeTextField.attributedPlaceholder = normalPlaceholderForInputField;
    
    _contactUsView.hidden=true;
    //SET CURENT BUTTON AS HIGHLIGHTED
    contactUsLabel.textColor =[UIColor whiteColor];
    //SET CURENT BUTTON AS HIGHLIGHTED
    [_contactUsIconButton setImage:[UIImage imageNamed:@"dss6.png"] forState:UIControlStateNormal];

    //START LOCATION UPDATES
       // [locationManagerLink startUpdatingLocation];
    //SET PREVIOUS ICONT TO WHITE/NORMAL
        findFriendLabel.textColor = [UIColor whiteColor];
    //SET PREVIOUS ICONT TO WHITE/NORMAL
        [findFriendIconButton setImage:[UIImage imageNamed:@"dss2.png"] forState:UIControlStateNormal];
    
    //SET CURENT BUTTON AS HIGHLIGHTED
        shareLocationLabel.textColor =[UIColor colorWithRed:0.49 green:0.76 blue:0.274 alpha:1.0];
    //SET CURENT BUTTON AS HIGHLIGHTED
        [shareIconButton setImage:[UIImage imageNamed:@"new2.png"] forState:UIControlStateNormal];
    
    //SHOW SHARECODE TEXTFIELD
        shareCodeTextField.hidden=false;
    //HIDE INPUTCODE TEXTFIELD
        inputCodeTextField.hidden=true;
    
    //SHOW SHARECODE BUTTON
        shareCodeButton.hidden=false;
    //HIDE INPUTCODE BUTTON
        findFriendButton.hidden=true;

    //HIDE KEYBOARD
        [inputCodeTextField resignFirstResponder];
    //BRING SHARECODE FIELD TO FRONT
        [_textfieldAndButtonView bringSubviewToFront:shareCodeTextField];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doYourStuff)
//     
//                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [_activityIndicator startAnimating];

    [locationManagerLink startUpdatingLocation];
}


//FIND FRIEND BUTTON CLICKED
- (IBAction)invisibleFindFriendButtonTapped:(id)sender
{
    inputCodeTextField.placeholder  = @"Enter Friend's Code";

     stopUpdating=false;
    toggle=false;
    [webviewTimer invalidate];
    webviewTimer=nil;
    webviewTimer =NULL;
    check=true;
    inputCodeTextField.placeholder=@"Enter Friend's Code";
    stopUpdating=false;
    //SETTING placeholder in inputcodeField

    //SET PREVIOUS LABEL TO WHITE/NORMAL
    contactUsLabel.textColor = [UIColor whiteColor];
    [_contactUsIconButton setImage:[UIImage imageNamed:@"dss6.png"] forState:UIControlStateNormal];

        inputCodeTextField.attributedPlaceholder = normalPlaceholderForInputField;
    _contactUsView.hidden=true;
    //SET TEXTFIELD HIDDEN
    shareCodeTextField.hidden=true;
    //SHOW INPUTCODE FIELD SHOW
    inputCodeTextField.hidden=false;
    
    //HIDE SHARECODE BUTTON
    shareCodeButton.hidden=true;
    //SHOW FIND FRIEND BUTTON
    findFriendButton.hidden=false;
    
    //SHOW INPUTFIELD TO FRONT
    [_textfieldAndButtonView bringSubviewToFront:inputCodeTextField];
    
    //START LOCATION UPDATES
        //[locationManagerLink startUpdatingLocation];
    

    //HIDE KEYBOARD
      //  [shareCodeTextField resignFirstResponder];
    
    //SET CURRENT LABEL TO HIGHLIGHTED
        findFriendLabel.textColor = [UIColor colorWithRed:0.49 green:0.76 blue:0.274 alpha:1.0];
        [findFriendIconButton setImage:[UIImage imageNamed:@"new3.png"] forState:UIControlStateNormal];
    
    //SET PREVIOUS LABEL TO WHITE/NORMAL
        shareLocationLabel.textColor = [UIColor whiteColor];
        [shareIconButton setImage:[UIImage imageNamed:@"dss.png"] forState:UIControlStateNormal];
    
    
   // [_activityIndicator startAnimating];
    
    [locationManagerLink startUpdatingLocation];

   
    
}


//SHARE CODE BUTTON TAPPED
- (IBAction)shareCodeButtonTapped:(id)sender {
    
    //STRING TO SHARE
    stringForSharingAppCode = shareCodeText;
    
    //MAKE ARRAY OF SHARING ITEMS
        shareLocationCodeMessage = [NSMutableArray new];

        //ADD ITEMS TO SHARE TO ARRAY
        if (stringForSharingAppCode)
        {
            [shareLocationCodeMessage addObject:recievedLocationCode];
        }
    
    //CREATE ACTIVITY CONTROLLER TO SHARE
        controllerForSharingInformation = [[UIActivityViewController alloc] initWithActivityItems:shareLocationCodeMessage applicationActivities:nil];
    

        //CHECK DEVICE TO SEPARATE BETWEEN IPHONE AND IPAD
            //for IPAD
            if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                
                controllerForSharingInformation.modalPresentationStyle = UIModalPresentationPopover;
                controllerForSharingInformation.popoverPresentationController.sourceView =shareCodeButton.titleLabel;
                [self presentViewController:controllerForSharingInformation animated:YES completion:nil];
            }
    
        //FOR IPHONES
            else
            {
            
            
            //CHECKING FOR ALREADY PRESENTED ALERT CONTROLLER
            if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
            {
                
            }
            else
            {
                //PRESENT ALERT
                    [self presentViewController:controllerForSharingInformation animated:YES completion:nil];
            }
            
            
            }
    controllerForSharingInformation=nil;
    
   
}


//FIND RUTE BUTTON TAPPED
- (IBAction)findRouteButtonTapped:(id)sender
{
    [inputCodeTextField resignFirstResponder];
    [shareCodeTextField resignFirstResponder];
    [locationManagerLink stopUpdatingLocation];

    findFriendLabel.textColor = [UIColor colorWithRed:0.49 green:0.76 blue:0.274 alpha:1.0];
    [findFriendIconButton setImage:[UIImage imageNamed:@"new3.png"] forState:UIControlStateNormal];
    contactUsLabel.textColor = [UIColor whiteColor];
    [_contactUsIconButton setImage:[UIImage imageNamed:@"dss6.png"] forState:UIControlStateNormal];

    
        [mapWebView stopLoading];
        
        //START PROGRESS TIMER
        [_activityIndicator startAnimating];
       
        //HIDE KEYBOARD IF PRESENT
        [inputCodeTextField resignFirstResponder];
        //SHOW PROGRESS TIMER
        _activityIndicator.hidden=false;
        //CHECK FOR ROUTE UPDATE
        toggle =true;
        //SHOWING PROGRESS TIMER ON FULLWEBVIEW
        [mapWebView addSubview:_activityIndicator];
        [_activityIndicator startAnimating ];
        //START UPDATING LOCATION
    if (!webviewTimer.isValid) {
        webviewTimer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalForWebviewRefresh target:self selector:@selector(webviewRefreshMethod:) userInfo:nil repeats:NO];
    }
        
        check = true;
        runOnce=true;
        fullCheck=true;
    toggle=true;;

    
}
-(void)delayMethod
{
    if (!webviewTimer.isValid) {
        webviewTimer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalForWebviewRefresh target:self selector:@selector(webviewRefreshMethod:) userInfo:nil repeats:NO];
    }
    if (!locationUpdateTimer.isValid) {
        locationUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalForLocationRefresh target:self selector:@selector(runMethod1222:) userInfo:nil repeats:NO];
    }
}
- (IBAction)showRouteToErginusMethod:(id)sender
{
    
    [inputCodeTextField resignFirstResponder];
    [shareCodeTextField resignFirstResponder];
    
   // _contactUsView.hidden=true;
   // mapWebView.hidden=false;
    //[self.view bringSubviewToFront:mapWebView];
    
    _activityIndicator.hidden=false;
    [mapWebView bringSubviewToFront:_activityIndicator];
    [_activityIndicator startAnimating];
    
  
    
    routeInputDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"Person3"],@"from_location_code", @"ERGINUS",@"to_location_code",nil];
    
    
    j=true;
    
    [RequestManager getFromServer:@"route" parameters:routeInputDictionary completionHandler:^(NSDictionary *responseDict) {
        // mapWebView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        if (responseDict==nil) {
            NSLog(@"nil dictionary");
        }
        
        
        
        NSLog(@"%@",responseDict);
        //  NSLog(@"%@",[loc returnvalues]);
        routeDataDictionary2 = [responseDict objectForKey:@"data"];
         routeURLString2 = [routeDataDictionary2 objectForKey:@"route_url"];
        
        inputCodeTextField.text=@"ERGINUS";
        routeURL2 = [NSURL URLWithString:routeURLString2];
        requestObj = [NSURLRequest requestWithURL:routeURL2];
        
        //   NSLog(@"%@");
        
        
        routeServerStatus = [responseDict objectForKey:@"code"];
        routeServerMessage = [responseDict objectForKey:@"message"];
        
        if ([routeServerStatus isEqualToString:@"1"]) {
            
       
            //SET CURRENT LABEL TO HIGHLIGHTED
            findFriendLabel.textColor = [UIColor colorWithRed:0.49 green:0.76 blue:0.274 alpha:1.0];
            [findFriendIconButton setImage:[UIImage imageNamed:@"new3.png"] forState:UIControlStateNormal];
            
            
            
            //SET PREVIOUS LABEL TO WHITE/NORMAL
            contactUsLabel.textColor = [UIColor whiteColor];
            [_contactUsIconButton setImage:[UIImage imageNamed:@"dss6.png"] forState:UIControlStateNormal];
            
            
            // [_fullScreenWebView addSubview:_minimizeBigMapButton];
//            [_fullScreenWebView addSubview:_activityIndicator];
            
            
            _contactUsView.hidden=true;
            mapWebView.hidden=false;
            if (!mapWebView.isLoading) {
                [mapWebView loadRequest:requestObj];

            }
            [mapWebView bringSubviewToFront:_activityIndicator];
            check = true;
            runOnce=true;
            fullCheck=true;
            toggle=true;
            check2=true;
            stopUpdating=false;
            inputCodeTextField.text=@"ERGINUS";
            //SET TEXTFIELD HIDDEN
            shareCodeTextField.hidden=true;
            //SHOW INPUTCODE FIELD SHOW
            inputCodeTextField.hidden=false;
            
            //HIDE SHARECODE BUTTON
            shareCodeButton.hidden=true;
            //SHOW FIND FRIEND BUTTON
            findFriendButton.hidden=false;
            //[self.view bringSubviewToFront:_fullScreenWebView];
            //[_fullScreenWebView bringSubviewToFront:_dismissWebViewRoute];
            //                        [_fullScreenWebView addSubview:_minimizeBigMapButton];
            
            //[locationManagerLink startUpdatingLocation];
            [self performSelector:@selector(delayMethod) withObject:self afterDelay:20];
            
            //[_fullScreenWebView bringSubviewToFront:_activityIndicator];
            
            //    //START THE TIMER
        }
        
        else if (routeServerStatus==nil)
        {
            toggle=false;
           // _dismissWebViewRoute.hidden=false;
            
            if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
            {
                
            }
            else{
                [self internetConnectionCheckAlertMethod];
            }
            
            
        }
        
        else if ([routeServerStatus isEqualToString:@"0"])
        {
           // _dismissWebViewRoute.hidden=false;
            toggle=false;

            if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
            {
                
            }
            else{
                [self internalServerErrorAlert:routeServerMessage withStatus:routeServerStatus];
            }
            
            
        }
        
        
        
        
    }];
    
    [locationManagerLink startUpdatingLocation];
    
}

- (IBAction)appTutorialScreenAction:(id)sender {
    scvObject = [self.storyboard instantiateViewControllerWithIdentifier:@"abc"];
        //PUSING VIEW CONTROLLER TO STACK
    [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"seenTutorial"];
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
     [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"dismissTutorial"];
    [self.navigationController pushViewController:scvObject animated:NO];
    
    //[self.navigationController pushViewController:scvObject animated:false];
}

- (IBAction)shareAppButtonTapped:(id)sender {
    
    //STRING TO SHARE
    stringForSharingAppCode = appdelegate.ios_url;
    
    //MAKE ARRAY OF SHARING ITEMS
    shareLocationCodeMessage = [NSMutableArray new];
    
    //ADD ITEMS TO SHARE TO ARRAY
    if (stringForSharingAppCode)
    {
        [shareLocationCodeMessage addObject:stringForSharingAppCode];
    }
    
    //CREATE ACTIVITY CONTROLLER TO SHARE
    controllerForSharingInformation = [[UIActivityViewController alloc] initWithActivityItems:shareLocationCodeMessage applicationActivities:nil];
    
    //CHECK DEVICE TO SEPARATE BETWEEN IPHONE AND IPAD
    //for IPAD
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        
        controllerForSharingInformation.modalPresentationStyle = UIModalPresentationPopover;
        controllerForSharingInformation.popoverPresentationController.sourceView =_invisibleShareAppButton.titleLabel;
        [self presentViewController:controllerForSharingInformation animated:YES completion:nil];
    }
    
    //FOR IPHONES
    else
    {
        
        
        //CHECKING FOR ALREADY PRESENTED ALERT CONTROLLER
        if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
        {
            
        }
        else
        {
            //PRESENT ALERT
            [self presentViewController:controllerForSharingInformation animated:YES completion:nil];
        }
        
        
    }
    
}




-(void)webviewRefreshMethod:(NSTimer *)timer
{
    check = true;
    [webviewTimer invalidate];
    webviewTimer=nil;
    toggle=true;
    [locationManagerLink startUpdatingLocation];
    if (!webviewTimer.isValid) {
        webviewTimer = [NSTimer scheduledTimerWithTimeInterval:timeIntervalForWebviewRefresh target:self selector:@selector(webviewRefreshMethod:) userInfo:nil repeats:NO];
    }
    
}
//EXIT FULL SCREEN ROUTE  VIEW
- (IBAction)minimizeBigMapButtonTapped:(id)sender
{
    //STOP UPLOADING WEBVIEW
        [_fullScreenWebView stopLoading];
    //STOP LOCATION UPDATES
        [locationManagerLink stopUpdatingLocation];
    //CHECK FOR LOCATION UPDATE NOW
        toggle=false;
    //SHOW CURRENTLOCATION WEBVIEW
        mapWebView.hidden=false;
    //START UPDATING LOCATION
        [locationManagerLink startUpdatingLocation];
    //HIDE ROUTE WEBVIEW
        [_fullScreenWebView setHidden:true];
    //HIDE BACK BUTTON
        [_minimizeBigMapButton setHidden: true];
    [mapWebView addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    check =true;
    [webviewTimer invalidate];
    webviewTimer=nil;
    webviewTimer =NULL;
}


-(void)internalServerErrorAlert:(NSString *)message withStatus:(NSString *)Status
{
    
    //SERVER ERROR ALERT
        serverErrorAlert=   [UIAlertController
                                          alertControllerWithTitle:@"Error"
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    //OK BUTTON
        okActionServerError = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //DISMISS ALERT
                                [serverErrorAlert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    //ADD ACTION TO ALERT
        [serverErrorAlert addAction:okActionServerError];
    
    
   //FOR IPAD
        if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [serverErrorAlert setModalPresentationStyle:UIModalPresentationPopover];
            popPresenter = [serverErrorAlert popoverPresentationController];
            popPresenter.sourceView = _textfieldAndButtonView;
            popPresenter.sourceRect = _textfieldAndButtonView.bounds;
            
            //CHECK IF THERE IS ANYVIEW CONTROLLER ALREADY PRESENTED
                if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                {
            
                }
                else
                {
                    //PRESENT ALERT
                        [self presentViewController:serverErrorAlert animated:YES completion:nil];
                }
        
        
        
        
        
    }
    
    //FOR IPHONES
        else
        {
            //CHECK IF THERE IS ANYVIEW CONTROLLER ALREADY PRESENTED
                if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                {
            
                }
                else
                {
                    [self presentViewController:serverErrorAlert animated:YES completion:nil];
                }
        
        }
    

       // [_activityIndicator stopAnimating];
    controllerForSharingInformation=nil;

        toggle=false;
   

}

//LOCATION SERVICES ERRO ALERT METHOD
-(void)locationServicesStatusCheckAlertMethod
{
    //LOCATION ERROR ALERT
        locationCheckAlert=   [UIAlertController
                                                   alertControllerWithTitle:locationError
                                                   message:locationErrorMessage
                                                   preferredStyle:UIAlertControllerStyleAlert];
    //OK ACTION
        okActionLocationError = [UIAlertAction
                         actionWithTitle:@"Settings"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //NAVIGATE TO SETTINGS->LOCATION
                                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                [[UIApplication sharedApplication] openURL:url];
                         }];
    //CANCEL ACTION BUTTON
        cancelActionLocationError = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                //DISMISS ALERT
                                    [locationCheckAlert dismissViewControllerAnimated:YES completion:nil];

                             }];
    //ADD ACTION TO ALERTS
        [locationCheckAlert addAction:okActionLocationError];
        [locationCheckAlert addAction:cancelActionLocationError];
    
    
    //FOR IPAD
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [locationCheckAlert setModalPresentationStyle:UIModalPresentationPopover];
        popPresenter = [locationCheckAlert popoverPresentationController];
        popPresenter.sourceView = _textfieldAndButtonView;
        popPresenter.sourceRect = _textfieldAndButtonView.bounds;
        
        //CHECK IF THERE IS ANYVIEW CONTROLLER ALREADY PRESENTED
            if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
            {
            
            }
            else
            {
                //PRESENT ALERT
                    [self presentViewController:locationCheckAlert animated:YES completion:nil];
            }
        
        
        }
    
    //FOR IPHONES
        else
        {
            //CHECK IF THERE IS ANYVIEW CONTROLLER ALREADY PRESENTED
                if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                    {
            
                    }
                else
                {
                    //PRESENT ALERT
                        [self presentViewController:locationCheckAlert animated:YES completion:nil];
                }
    }
    
    
    controllerForSharingInformation=nil;

    
}


//INTERNET CONNECTION DISBALED ALERT
-(void)internetConnectionCheckAlertMethod
{
    //ALERT FOR INTERNET ERROR
        internetCheckErrorAlert=   [UIAlertController
                                                   alertControllerWithTitle:@"Internet Not Available!!!"
                                                   message:@"Please enable cellular data or connect to WiFi to start using Buddy Finder app."
                                                   preferredStyle:UIAlertControllerStyleAlert];
    //OK ACTION
        okActionInternetError = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //DISMISS ALERT
                                [internetCheckErrorAlert dismissViewControllerAnimated:YES completion:nil];
                             //NSURL *url = [NSURL URLWithString:@"http://google.co.in"];
                             //[[UIApplication sharedApplication] openURL:url];
                         }];
    
    //ADD AACTION TO ALERT
        [internetCheckErrorAlert addAction:okActionInternetError];
    
   //FOR IPAD
        if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [internetCheckErrorAlert setModalPresentationStyle:UIModalPresentationPopover];
                popPresenter = [internetCheckErrorAlert popoverPresentationController];
                popPresenter.sourceView = _textfieldAndButtonView;
                popPresenter.sourceRect = _textfieldAndButtonView.bounds;
                
                //CHECK IF THERE IS ANYVIEW CONTROLLER ALREADY PRESENTED
                if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                {
            
                }
                else
                {
                    //PRESENT ALERT
                        [self presentViewController:internetCheckErrorAlert animated:YES completion:nil];
                }
        
        
    }
    //FOR IPHONE
        else
        {
            //CHECK IF THERE IS ANYVIEW CONTROLLER ALREADY PRESENTED
                if ([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                {
            
                }
                else
                {
                    //PRESNET ALERT
                        [self presentViewController:internetCheckErrorAlert animated:YES completion:nil];
                }
        }
    
    controllerForSharingInformation=nil;

}


//
//
//- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
//    
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//
//
//
////- (NSUInteger)supportedInterfaceOrientations {
////    return UIInterfaceOrientationMaskAll;
////}
//
//
//- (BOOL) shouldAutorotate {
//    return NO;
//}
//
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationPortrait;
//}
//

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)

    {
        return  UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

@end
