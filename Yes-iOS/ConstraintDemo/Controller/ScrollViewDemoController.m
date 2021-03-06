//
//  ScrollViewDemoController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/9.
//

#import "ScrollViewDemoController.h"
#import "BNRHypnosisView.h"
#import <Masonry/Masonry.h>

@interface ScrollViewDemoController () <UITextFieldDelegate>
@property (nonatomic, strong) BNRHypnosisView *BNRviewPre;
@property (nonatomic, strong) BNRHypnosisView *BNRView;
@property (nonatomic, strong) BNRHypnosisView *BNRViewNext;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *slogen;

@end

@implementation ScrollViewDemoController
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self.tabBarItem setTitle:@"Scroll"];
    }
    return self;
}

- (instancetype) init{
    self  = [super init];
    if(!self){
        return nil;
    }
    // setTitle also change the value in self.tabBarItem.title
    [self setTitle:@"ScrollView Demo"];
    return self;
}

- (void) loadView{
    [super loadView];
    NSLog(@"%@ loadView.", self.title);
    
    // Do any additional setup after loading the view.
    CGRect screenRect = self.view.bounds;
    CGRect bigRect = screenRect;
    
    bigRect.size.width *= 3.0;
    //bigRect.size.height *= 2.0;

    
    _scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    [_scrollView setPagingEnabled:YES];

    _BNRviewPre = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    screenRect.origin.x += screenRect.size.width;
    _BNRView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    screenRect.origin.x += screenRect.size.width;
    _BNRViewNext = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    
    _slogen = [[UITextField alloc] init];
    [_slogen setBorderStyle:UITextBorderStyleRoundedRect];
    [_slogen setPlaceholder:@"Spells"];
    [_slogen setReturnKeyType:UIReturnKeyDone];
    _slogen.delegate = self;
    
    [_BNRviewPre setBackgroundColor:[UIColor whiteColor]];
    [_BNRView setBackgroundColor:[UIColor whiteColor]];
    [_BNRViewNext setBackgroundColor:[UIColor whiteColor]];
    
    [_scrollView addSubview:_BNRviewPre];
    [_scrollView addSubview:_BNRView];
    [_scrollView addSubview:_BNRViewNext];
    
    [self.view addSubview:_scrollView];
    [self.view addSubview:_slogen];
    
    //tell the UIScrollView how large the window is.
    [_scrollView setContentSize:bigRect.size];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
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

#pragma mark Delegate textField

- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
    NSLog(@"%@", textField.text);
    
    [self drawHypnoticMessage:textField.text];
    
    [textField setText:@""];
    
    //hide the keyboard.
    [textField resignFirstResponder];
    return YES;
}

- (void) drawHypnoticMessage:(NSString *) message
{
    for(int i =0; i<10; i++){
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
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
    }
}
@end
