//
//  AppDelegate.m
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/3.
//

#import "AppDelegate.h"
#import "NSLayoutConstraintViewController.h"
#import "NSLayoutAnchorViewController.h"
#import "MasonryVersionAutoLayoutViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSLayoutConstraintViewController *viewController_NSC;
@property (nonatomic, strong) NSLayoutAnchorViewController *viewController_NSA;
@property (nonatomic, strong) MasonryVersionAutoLayoutViewController *viewController_Mas;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    _viewController_NSC = [[NSLayoutConstraintViewController alloc] init];
    _viewController_NSA = [[NSLayoutAnchorViewController alloc] init];
    _viewController_Mas = [[MasonryVersionAutoLayoutViewController alloc] init];
    
    _navigationController = [[UINavigationController alloc] initWithRootViewController:_viewController_NSC];
    _window.rootViewController = _navigationController;
    [_window makeKeyAndVisible];
    return YES;
}


@end
