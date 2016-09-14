//
//  AppDelegate.m
//  buddyApp
//
//  Created by Manish Anand on 10/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import "AppDelegate.h"
#import "BuddyViewController.h"
#import "contactUsScreen.h"
#import "scrollViewController.h"

@interface AppDelegate ()
{
    CLLocationManager *locationManagerLink;
    UIView *asd ;
    BuddyViewController * buddy;
    contactUsScreen *contact;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    buddy= [[BuddyViewController alloc] init];
    contact = [[contactUsScreen alloc ]init];
    
    
    _enablePortrait = YES;
    
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"seenTutorial"]  isEqual: @"true"]) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        BuddyViewController *buddy2 = [storyboard instantiateViewControllerWithIdentifier:@"hello"];
//        [self.window makeKeyAndVisible];
//        
//        [self.window.rootViewController presentViewController:buddy2 animated:NO completion:NULL];
////        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main.hello" bundle:nil];
////        BuddyViewController *securityCheck = [storyboard instantiateViewControllerWithIdentifier:@"hello"];
////        [self.window.rootViewController presentViewController:securityCheck animated:NO completion:nil];
//        
//    }
//    else
//    {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        scrollViewController *buddy2 = [storyboard instantiateViewControllerWithIdentifier:@"abc"];
//        [self.window makeKeyAndVisible];
//        [self.window.rootViewController presentViewController:buddy2 animated:NO completion:NULL];
//    }
//
    
    [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"dismissTutorial"];

    [RequestManager getFromServer:@"" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"as",@"current_timestamp", nil] completionHandler:^(NSDictionary *responseDict) {
        NSLog(@"%@",responseDict);
        
        
        NSString *p = [responseDict objectForKey:@"code"];
        appData = [responseDict objectForKey:@"data"];
        NSString *version = [appData objectForKey:@"ios_version"];
        NSLog(@"%@",p);
        NSString *systemVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        _location_refresh_time = [appData objectForKey:@"location_refresh"];
        _webview_refresh_time =  [appData objectForKey:@"route_refresh"];
        _location_error = [appData objectForKey:@"location_error"];
        _location_error_message = [appData objectForKey:@"gps_error"];
        _location_refresh_distance = [appData objectForKey:@"distance_meters"];
        _ios_url = [appData objectForKey:@"ios_url"];
        if ([p isEqualToString:@"1"]) {
            NSLog(@"internet");
            if (![version isEqualToString:systemVersion]) {
                [self updateApplicationAlertMethod];
            }
            //[self locationServicesStatusCheckAlertMethod];
            locationManagerLink =[[CLLocationManager alloc]init];
            if ([locationManagerLink respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [locationManagerLink requestWhenInUseAuthorization];
            }
            
            locationManagerLink.delegate=self;
            locationManagerLink.desiredAccuracy = kCLLocationAccuracyBest;
            
            [locationManagerLink requestWhenInUseAuthorization];
            if (![CLLocationManager locationServicesEnabled]) {
                [self locationServicesStatusCheckAlertMethod];
            }
            
        }
        else
        {
            [self internetConnectionCheckAlertMethod];
        }
        
               // [self.window.rootViewController setView:asd];
            }];
     [NSThread sleepForTimeInterval:2.5];
   
    return YES;
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_2)
{
    if ([CLLocationManager locationServicesEnabled]) {
        switch (status) {
            case kCLAuthorizationStatusAuthorizedAlways:
               // shouldFetchLocation= YES;
                
                break;
            case kCLAuthorizationStatusDenied:
            {
                [self locationServicesStatusCheckAlertMethod];

            }
                break;
            case kCLAuthorizationStatusNotDetermined:
            {
               // [self locationServicesStatusCheckAlertMethod];

            }
                break;
            case kCLAuthorizationStatusRestricted:
            {
                [self locationServicesStatusCheckAlertMethod];

            }
                break;
                
            default:
               // [self locationServicesStatusCheckAlertMethod];

                break;
        }
    }
    else{
//        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"Error" message:@"The location services seems to be disabled from the settings." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//        [alert show];
//        alert= nil;
        
        [self locationServicesStatusCheckAlertMethod];
    }
}
-(void)actionRedButton
{
    NSLog(@"red button");
    
    BuddyViewController* room = [[BuddyViewController alloc] init];
    [self.window.rootViewController presentViewController:room
                                                 animated:NO
                                               completion:nil];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //[buddy stopTimers];
//    [buddy stopTimers];
//    [buddy.webviewTimer invalidate];
//    buddy.webviewTimer =nil;
//    [buddy.locationUpdateTimer invalidate];
//    buddy.locationUpdateTimer=nil;
//    [buddy.locationManagerLink stopUpdatingLocation];
//    
//    [buddy viewDidDisappear:true];
    
    
    
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    BuddyViewController* room = [[BuddyViewController alloc] init];
//    [self.window.rootViewController presentViewController:room
//                                                 animated:NO
//                                               completion:nil];
   // [buddy viewWillAppear:YES];
    //[buddy method];
 

    
   }

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)updateApplicationAlertMethod
{
    UIAlertController * updateApplicationAlert=   [UIAlertController
                                          alertControllerWithTitle:@"Update Buddy Finder App!!!"
                                          message:@"A new version of Buddy Finder App is now available on Appstore."
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Update"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //[updateApplicationAlert dismissViewControllerAnimated:YES completion:nil];
                             NSURL *url = [NSURL URLWithString:_ios_url];
                             [[UIApplication sharedApplication] openURL:url];
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Later"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 UIAlertController * updateApplicationAlert=   [UIAlertController
                                                                                alertControllerWithTitle:@"ok"
                                                                                message:@"net is not working"
                                                                                preferredStyle:UIAlertControllerStyleAlert];
                                 
                                 UIAlertAction* ok = [UIAlertAction
                                                      actionWithTitle:@"Update"
                                                      style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                                      {
                                                          [updateApplicationAlert dismissViewControllerAnimated:YES completion:nil];
                                                          
                                                      }];
                                 UIAlertAction* cancel = [UIAlertAction
                                                          actionWithTitle:@"Later"
                                                          style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                                          {
                                                              [updateApplicationAlert dismissViewControllerAnimated:YES completion:nil];
                                                              
                                                          }];
                                 
                                 [updateApplicationAlert addAction:ok];
                                 [updateApplicationAlert addAction:cancel];
                                 
                                 UIWindow *alertWindow2 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                                 alertWindow2.rootViewController = [[UIViewController alloc] init];
                                 alertWindow2.windowLevel = UIWindowLevelAlert + 1;
                                 [alertWindow2 makeKeyAndVisible];
                                 
                                 [alertWindow2.rootViewController presentViewController:updateApplicationAlert animated:YES completion:nil];

                                 
                             }];
    
    [updateApplicationAlert addAction:ok];
    [updateApplicationAlert addAction:cancel];
    
    UIWindow *alertWindow2 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow2.rootViewController = [[UIViewController alloc] init];
    alertWindow2.windowLevel = UIWindowLevelAlert + 1;
    [alertWindow2 makeKeyAndVisible];

    [alertWindow2.rootViewController presentViewController:updateApplicationAlert animated:YES completion:nil];
    
//    [self presentViewController:updateApplicationAlert animated:YES completion:nil];
}
//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    NSLog(@"Interface orientations");
//  
//    
//    if(!_enablePortrait)
//    {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//        }
//    return UIInterfaceOrientationMaskPortrait;
//}


-(void)internetConnectionCheckAlertMethod
{
    UIAlertController * updateApplicationAlert=   [UIAlertController
                                                   alertControllerWithTitle:@"Internet Not Available!!!"
                                                   message:@"Please enable cellular data or connect to WiFi to start using Buddy Finder app."
                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [updateApplicationAlert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
 
    
    [updateApplicationAlert addAction:ok];
  
    
    UIWindow *alertWindow2 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow2.rootViewController = [[UIViewController alloc] init];
    alertWindow2.windowLevel = UIWindowLevelAlert + 1;
    [alertWindow2 makeKeyAndVisible];
    
    [alertWindow2.rootViewController presentViewController:updateApplicationAlert animated:YES completion:nil];
    
    //    [self presentViewController:updateApplicationAlert animated:YES completion:nil];
}


-(void)locationServicesStatusCheckAlertMethod
{
    UIAlertController * updateApplicationAlert=   [UIAlertController
                                                   alertControllerWithTitle:@"Location service Disabled!!!"
                                                   message:@"Please go to settings to enable location services."
                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Settings"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
//                             [updateApplicationAlert dismissViewControllerAnimated:YES completion:nil];

                             NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                             [[UIApplication sharedApplication] openURL:url];
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                                             [updateApplicationAlert dismissViewControllerAnimated:YES completion:nil];

                             }];
    
    [updateApplicationAlert addAction:ok];
    [updateApplicationAlert addAction:cancel];
    
    UIWindow *alertWindow2 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow2.rootViewController = [[UIViewController alloc] init];
    alertWindow2.windowLevel = UIWindowLevelAlert + 1;
    [alertWindow2 makeKeyAndVisible];
    
    [alertWindow2.rootViewController presentViewController:updateApplicationAlert animated:YES completion:nil];
    
   
}
@end
