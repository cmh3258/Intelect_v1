//
//  AppDelegate.m
//  Intelect_v1
//
//  Created by Recommenu on 3/19/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1].CGColor]
    
    /*
     * Override point for customization after application launch.
     */
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(10/256.0) green:(225/256.0) blue:(102/256.0) alpha:(1.0)]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(37/256.0) green:(236/256.0) blue:(110/256.0) alpha:(1.0)]];

    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                    [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                        NULL, NSShadowAttributeName,
                        [UIFont fontWithName:@"PTSans-Bold" size:21.0], NSFontAttributeName, nil]];
    
    
    /*
     *  Page Controller settings
     */
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:(37/255.0) green:(225/255.0) blue:(102/255.0) alpha:1];
    pageControl.backgroundColor = [UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
