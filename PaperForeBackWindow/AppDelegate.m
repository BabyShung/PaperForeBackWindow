//
//  AppDelegate.m
//  PaperForeBackWindow
//
//  Created by Hao Zheng on 8/10/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "AppDelegate.h"
#import "ProfileViewController.h"
#import "CardsViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"Profile"];
    [self.window makeKeyAndVisible];
    
    self.foregroundWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.foregroundWindow.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CardsNav"];
    self.foregroundWindow.windowLevel = UIWindowLevelStatusBar;
    [self.foregroundWindow makeKeyAndVisible];
    
    return YES;
}
						
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
