//
//  AppDelegate.m
//  OCTest
//
//  Created by Jun Zhou on 2019/4/15.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "AppDelegate.h"
#import <Debugo/Debugo.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

void UncaughtExceptionHandler(NSException *exception) {
    /**
     *  获取异常崩溃信息
     */
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString * dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString * userID   =   @"";
    NSString * userName =   @"";
    
    NSString * iOS_Version = [[UIDevice currentDevice] systemVersion];
    NSString * PhoneSize    =   NSStringFromCGSize([[UIScreen mainScreen] bounds].size);
    
    NSString * App_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * iPhoneType = @"";
    
    NSString *content = [NSString stringWithFormat:@"%@<br>\niOS_Version : %@----PhoneSize : %@<br>\n----iPhoneType: %@<br>\nApp_Version : %@<br>\nuserID : %@<br>\nuserName : %@<br>\nname:%@<br>\nreason:\n%@<br>\ncallStackSymbols:\n%@",dateStr,iOS_Version,PhoneSize,iPhoneType,App_Version,userID,userName,name,reason,[callStack componentsJoinedByString:@"\n"]];
    
#if DEBUG
    NSDictionary * dictionary   =   @{@"content":content,
                                      @"isDebug":@(1),
                                      @"packageName":@"com.thinkjoy.NetworkTaxiDriver"};
#else
    NSDictionary * dictionary   =   @{@"content":content,
                                      @"isDebug":@(0),
                                      @"packageName":@"com.thinkjoy.NetworkTaxiDriver"};
#endif
    
    NSLog(@"Exception info: %@", dictionary);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [DGDebugo fireWithConfiguration:^(DGConfiguration * _Nonnull configuration) {
//        // 设置 configuration 的属性，定制你的需求
//    }];
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    return UIInterfaceOrientationMaskLandscapeRight;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
