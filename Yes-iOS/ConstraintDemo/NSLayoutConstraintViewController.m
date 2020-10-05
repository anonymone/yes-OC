//
//  NSLayoutConstraintViewController.m
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/5.
//

#import "NSLayoutConstraintViewController.h"

@interface NSLayoutConstraintViewController ()

@end

@implementation NSLayoutConstraintViewController

- (instancetype) init{
    self = [super init];
    if(!self){
        return nil;
    }
    [self setTitle:@"NSLayoutConstraint"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    return self;
}

- (void) loadView
{
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
    
    NSLayoutConstraint *yellowLeading = [NSLayoutConstraint constraintWithItem:_yellow attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:margin];
    NSLayoutConstraint *yellowTrailing = [NSLayoutConstraint constraintWithItem:_yellow attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-margin];
    NSLayoutConstraint *yellowTop = [NSLayoutConstraint constraintWithItem:_yellow attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin];
    NSLayoutConstraint *yellowBotton = [NSLayoutConstraint constraintWithItem:_yellow attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-margin];
    yellowLeading.active = YES;
    yellowTrailing.active = YES;
    yellowTop.active = YES;
    yellowBotton.active = YES;
    
    NSLayoutConstraint *greenLeading = [NSLayoutConstraint constraintWithItem:_green attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_yellow attribute:NSLayoutAttributeLeading multiplier:1.0 constant:margin];
    NSLayoutConstraint *greenTrailing = [NSLayoutConstraint constraintWithItem:_green attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_yellow attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-margin];
    NSLayoutConstraint *greenTop = [NSLayoutConstraint constraintWithItem:_green attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_yellow attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin];
    NSLayoutConstraint *greenBotton = [NSLayoutConstraint constraintWithItem:_green attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_red attribute:NSLayoutAttributeTop multiplier:1.0 constant:-margin];
    greenLeading.active = YES;
    greenTrailing.active = YES;
    greenTop.active = YES;
    greenBotton.active = YES;
    
    NSLayoutConstraint *redLeading = [NSLayoutConstraint constraintWithItem:_red attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_yellow attribute:NSLayoutAttributeLeading multiplier:1.0 constant:margin];
    NSLayoutConstraint *redTrailing = [NSLayoutConstraint constraintWithItem:_red attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_yellow attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-margin];
    NSLayoutConstraint *redBotton = [NSLayoutConstraint constraintWithItem:_red attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_yellow attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-margin];
    NSLayoutConstraint *redHeight = [NSLayoutConstraint constraintWithItem:_red attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_green attribute:NSLayoutAttributeHeight multiplier:2.0 constant:0.0];
    redLeading.active = YES;
    redTrailing.active = YES;
    redBotton.active = YES;
    redHeight.active = YES;
    
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
