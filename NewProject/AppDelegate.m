//
//  AppDelegate.m
//  NewProject
//
//  Created by fan on 17/5/9.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "AppDelegate.h"
#import "ClockNumberController.h"
#import "SecondController.h"
#import "EventKitController.h"
#import "AutoLayoutController.h"
#import "CoreAnimtionController.h"
#import "ProxyViewController.h"


@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
//    UIViewController *viewController1 = [[ClockNumberController alloc] init];
//    viewController1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"第一页" image:nil tag:1];
//    UIViewController *viewController2 = [[SecondController alloc] init];
//    viewController2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"第二页" image:nil tag:2];
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//    tabBarController.viewControllers = @[viewController1, viewController2];
//    tabBarController.delegate = self;
//    self.window.rootViewController = tabBarController;
    
    
//    EventKitController *vc = [[EventKitController alloc] init];
//    AutoLayoutController *vc = [[AutoLayoutController alloc] init];
//    CoreAnimtionController *vc = [[CoreAnimtionController alloc] init];
//    ProxyViewController *vc = [[ProxyViewController alloc] init];
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    
    return YES;
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionFade;
//    [tabBarController.view.layer addAnimation:transition forKey:nil];
//}

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
