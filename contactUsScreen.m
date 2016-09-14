//
//  contactUsScreen.m
//  buddyApp
//
//  Created by Manish Anand on 20/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "contactUsScreen.h"

@interface contactUsScreen ()
{
    DirectionToErginusViewController *newView;
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

@implementation contactUsScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:false animated:false];
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    routeToErginus = [[DirectionToErginusViewController alloc]init];
    
    
    //set delegate of WEBVIEW
        _fullScreenWebView.delegate=self;
        _activityIndicator.hidden=true;
   
        
    timeIntervalForLocationRefresh=[appdelegate.location_refresh_time doubleValue];
    minimumDistance = [appdelegate.location_refresh_distance doubleValue];
    timeIntervalForWebviewRefresh = [appdelegate.webview_refresh_time doubleValue];
    locationError = appdelegate.location_error;
    locationErrorMessage = appdelegate.location_error_message;

   
   
    update=true;
    toggle=true;
    check=true;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//DIRECTION TO ERGINUS BUTTON METHOD
- (IBAction)ddirectionToErginusButtonTapped:(id)sender {
   
//    ////START AND SHOW PROGRESS TIMER
//        [_activityIndicator startAnimating];
//        _activityIndicator.hidden=false;
//   
//    update=true;
//    //RUN A 1 TIME METHOD
//        [self showRouteToErginusMethod];
//    //START THE TIMER
//        [self performSelector:@selector(methodUpdate) withObject:nil afterDelay:12];
//    [self.navigationController pushViewController:routeToErginus animated:false];
    
    //CREATING A VIEW CONTROLLER VARIABLE
    newView = [self.storyboard instantiateViewControllerWithIdentifier:@"hello55"];
    //PUSING VIEW CONTROLLER TO STACK
    [self.navigationController pushViewController:newView animated:YES];
}



//SHARE APP BUTTON METHOD
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
        controllerForSharingInformation.popoverPresentationController.sourceView =_directionToErginusButton.titleLabel;
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




-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:false];
//    [locationManagerLink stopUpdatingLocation];
//    [locationUpdateTimer invalidate];
//    locationUpdateTimer=nil;
//    [timer invalidate];
//    timer=nil;
//    check=nil;
//    [timer invalidate];
//    timer=nil;
//    timer =NULL;
//    [webviewTimer invalidate];
//    webviewTimer=nil;
//    webviewTimer =NULL;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:false];
    [self.navigationController setNavigationBarHidden:false animated:false];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:false];
    [self.navigationController setNavigationBarHidden:false animated:false];

}
@end
