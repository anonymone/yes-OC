//
//  NSLayoutAnchorViewController.m
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/5.
//

#import "NSLayoutAnchorViewController.h"

@interface NSLayoutAnchorViewController ()

@end

@implementation NSLayoutAnchorViewController

- (instancetype) init{
    self = [super init];
    if(!self){
        return nil;
    }
    [self setTitle:@"NSLayoutAnchor"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    return self;
}

- (void) loadView {
    [super loadView];

    _yellow = [[UIView alloc] init];
    _green = [[UIView alloc] init];
    _red = [[UIView alloc] init];
    
    [_yellow setBackgroundColor:[UIColor yellowColor]];
    [_green setBackgroundColor:[UIColor greenColor]];
    [_red setBackgroundColor:[UIColor redColor]];
    
    _yellow.translatesAutoresizingMaskIntoConstraints = NO;
    _green.translatesAutoresizingMaskIntoConstraints = NO;
    _red.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_yellow];
    [_yellow addSubview:_green];
    [_yellow addSubview:_red];
    
    CGFloat margin = 20;
    
    [_yellow.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:margin].active = YES;
    [_yellow.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-margin].active = YES;
    [_yellow.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:margin].active = YES;
    [_yellow.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-margin].active = YES;
    
    [_green.topAnchor constraintEqualToAnchor:_yellow.topAnchor constant:margin].active = YES;
    [_green.bottomAnchor constraintEqualToAnchor:_red.topAnchor constant:-margin].active = YES;
    [_green.leadingAnchor constraintEqualToAnchor:_yellow.leadingAnchor constant:margin].active = YES;
    [_green.trailingAnchor constraintEqualToAnchor:_yellow.trailingAnchor constant:-margin].active = YES;
    
    [_red.leadingAnchor constraintEqualToAnchor:_green.leadingAnchor].active = YES;
    [_red.trailingAnchor constraintEqualToAnchor:_green.trailingAnchor].active = YES;
    [_red.heightAnchor constraintEqualToAnchor:_green.heightAnchor multiplier:2.0].active = YES;
    [_red.bottomAnchor constraintEqualToAnchor:_yellow.bottomAnchor constant:-margin].active = YES;
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
