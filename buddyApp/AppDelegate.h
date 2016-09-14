//
//  AppDelegate.h
//  buddyApp
//
//  Created by Manish Anand on 10/05/16.
//  Copyright © 2016 Manish Anand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<CoreLocation/CoreLocation.h>
#define BaseUrl @"http://erginus.net/buddyfinder_web/api/"
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,NSURLSessionDelegate,UITabBarControllerDelegate>

{
    
    float a,b;
    
    NSDictionary *appData;

}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSNumber *x;
@property (strong, nonatomic) NSNumber *y;
@property (strong, nonatomic) NSString *location_refresh_time;
@property (strong, nonatomic) NSString *location_refresh_distance;
@property (strong, nonatomic) NSString *webview_refresh_time;
@property (strong, nonatomic) NSString *location_error;
@property (strong, nonatomic) NSString *location_error_message;
@property (strong, nonatomic) NSString *ios_url;
@property bool enablePortrait;
@property (strong,nonatomic) CLLocationManager *locationMang;


@end

