//
//  TabBarViewDemoController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/9.
//

#import "TabBarViewDemoController.h"
#import "ScrollViewDemoController.h"
#import "TimeSelectViewDemoController.h"

@interface TabBarViewDemoController ()
@property (nonatomic, strong) UITabBarController *tabbbarController;
@property (nonatomic, strong) ScrollViewDemoController *scroll;
@property (nonatomic, strong) TimeSelectViewDemoController *timeSelect;

@end

@implementation TabBarViewDemoController

- (instancetype)  init{
    self = [super init];
    if(!self){
        return nil;
    }
    [self setTitle:@"TabBar Demo"];
    _scroll = [[ScrollViewDemoController alloc] init];
    [_scroll.tabBarItem setTitle:@"Scroll"];
    [_scroll.tabBarItem setImage:[UIImage imageNamed:@"tabBar_essence_icon"]];
    
    _timeSelect = [[TimeSelectViewDemoController alloc] init];
    [_timeSelect.tabBarItem setTitle:@"Time Select"];
    [_timeSelect.tabBarItem setImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    
    [self addChildViewController:_scroll];
    [self addChildViewController:_timeSelect];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
