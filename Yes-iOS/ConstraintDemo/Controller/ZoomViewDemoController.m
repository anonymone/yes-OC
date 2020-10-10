//
//  ZoomViewDemoController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/10.
//

#import "ZoomViewDemoController.h"
#import "BNRHypnosisView.h"
#import <Masonry/Masonry.h>

@interface ZoomViewDemoController () <UIScrollViewDelegate, UITextFieldDelegate>
@property (nonatomic,strong) BNRHypnosisView *BNRview;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *slogen;

@end

@implementation ZoomViewDemoController

- (instancetype) init{
    self = [super init];
    if(self){
        [self setTitle:@"Zoom Demo"];
    }
    return self;
}

- (void) loadView {
    [super loadView];
    NSLog(@"%@ loadView.", self.title);
    CGRect screenRect = self.view.frame;
    
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setPagingEnabled:NO];
    [_scrollView setDelegate:self];
    [_scrollView setContentSize:screenRect.size];
    [_scrollView setMinimumZoomScale:1.0];
    [_scrollView setMaximumZoomScale:2.0];
    
    _slogen = [[UITextField alloc] init];
    [_slogen setBorderStyle:UITextBorderStyleRoundedRect];
    [_slogen setPlaceholder:@"Spells"];
    [_slogen setReturnKeyType:UIReturnKeyDone];
    _slogen.delegate = self;
    
    //add Parallax Effect
    UIInterpolatingMotionEffect *motionEffect;
    motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionEffect.minimumRelativeValue = @(-25);
    motionEffect.maximumRelativeValue = @(25);
    [_slogen addMotionEffect:motionEffect];
    
    motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    motionEffect.minimumRelativeValue = @(-25);
    motionEffect.maximumRelativeValue = @(25);
    [_slogen addMotionEffect:motionEffect];
    
    
    _BNRview = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [_BNRview setBackgroundColor:[UIColor whiteColor]];
    
    [_scrollView addSubview:_BNRview];
    
    [self.view addSubview:_scrollView];
    [self.view addSubview:_slogen];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_bottom);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
    }];
    
    [_slogen mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(_scrollView).multipliedBy(0.5);
        make.height.equalTo(_slogen.mas_width).multipliedBy(0.2);
        make.centerX.equalTo(_scrollView);
        make.top.equalTo(_scrollView).offset(50);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@ viewDidLoad.", self.title);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@ viewWillAppear.", self.title);
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%@ viewDidAppear.", self.title);
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%@ viewWillDisappear", self.title);
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%@ viewDidDisappear", self.title);
}


#pragma mark Delegate ScrollView

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"%@ viewForZoomingInScrollView", self.title);
    return _BNRview;
}

#pragma mark Delegate tectFieldView

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@ textFieldShouldReturn receive message %@", self.title, textField.text);
    [self drawHypnoticMessage:textField.text];
    [textField setText:@""];
    [textField resignFirstResponder];
    return YES;
}

- (void) drawHypnoticMessage:(NSString *) message
{
    for(int i =0; i<20; i++){
        UILabel *messageLabel = [[UILabel alloc] init];
        
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        [messageLabel setText:message];
        [messageLabel setTextColor:[UIColor blackColor]];
        
        [messageLabel sizeToFit];
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random()%width;
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random()%height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.view addSubview:messageLabel];
        
        // add Parallax Effect
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-50);
        motionEffect.maximumRelativeValue = @(50);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-50);
        motionEffect.maximumRelativeValue = @(50);
        [messageLabel addMotionEffect:motionEffect];
    }
}

#pragma mark TouchEvent

//- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"%@ was touched", self);
//    [_slogen resignFirstResponder];
//    [super touchesBegan:touches withEvent:event];
//}

@end
