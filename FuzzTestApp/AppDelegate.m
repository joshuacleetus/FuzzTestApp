//
//  AppDelegate.m
//  FuzzTestApp
//
//  Created by Joshua on 3/26/15.
//  Copyright (c) 2015 Joshuasoft. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TextViewController.h"
#import "ImagesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    NSMutableArray *tabItems = [[NSMutableArray alloc] initWithCapacity:3];
    
    ViewController *dvc = [[ViewController alloc] init];
    UINavigationController *dvc_nc = [[UINavigationController alloc] initWithRootViewController:dvc];
    dvc_nc.tabBarItem.title = @"All";
//    dvc_nc.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default" ofType:@"png"]];
    [tabItems addObject:dvc_nc];

    
    TextViewController *ovc = [[TextViewController alloc] init];
    UINavigationController *ovc_nc = [[UINavigationController alloc] initWithRootViewController:ovc];
    ovc_nc.tabBarItem.title = @"Text";
//    ovc_nc.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Optiomn" ofType:@"png"]];
    [tabItems addObject:ovc_nc];
    
    ImagesViewController *ovc2 = [[ImagesViewController alloc] init];
    UINavigationController *ovc2_nc = [[UINavigationController alloc] initWithRootViewController:ovc2];
    ovc2_nc.tabBarItem.title = @"Images";
    //    ovc_nc.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Optiomn" ofType:@"png"]];
    [tabItems addObject:ovc2_nc];

    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = tabItems;
    self.tabBarController = tbc;
    
    [self.window addSubview:self.tabBarController.view];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
