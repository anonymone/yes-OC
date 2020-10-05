//
//  AppDelegate.m
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/3.
//

#import "AppDelegate.h"
#import "YesOCTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _window.backgroundColor = [UIColor whiteColor];    
    _navigationController = [[UINavigationController alloc] initWithRootViewController:YesOCTableViewController.new];
    _window.rootViewController = _navigationController;
    [_window makeKeyAndVisible];
    return YES;
}


@end
