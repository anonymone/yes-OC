//
//  AppDelegate.m
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/3.
//

#import "AppDelegate.h"
#import "NSLayoutAnchorViewController.h"
#import "MasonryVersionAutoLayoutViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) MasonryVersionAutoLayoutViewController *viewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _viewController = [[MasonryVersionAutoLayoutViewController alloc] init];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:_viewController];
    _window.rootViewController = _navigationController;
    [_window makeKeyAndVisible];
    return YES;
}


@end
