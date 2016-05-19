//
//  AppDelegate.m
//  IOSProject
//
//  Created by KulikovS on 19.04.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSAppDelegate.h"
#import "KSLabelViewController.h"
#import "KSUserViewController.h"
#import "KSArrayModel.h"
#import "KSStringModel.h"

@interface KSAppDelegate ()
@property (nonatomic, strong) KSArrayModel *arrayModel;

@end

@implementation KSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    KSUserViewController *viewController = [KSUserViewController controllerFromNib];
    
    KSArrayModel *arrayModel = [KSArrayModel new];
    viewController.arrayModel = arrayModel;
    self.arrayModel = viewController.arrayModel;

    window.rootViewController = viewController;
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.arrayModel save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.arrayModel save];
}

@end
