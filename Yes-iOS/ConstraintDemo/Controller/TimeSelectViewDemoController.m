//
//  TimeSelectViewDemoController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/9.
//

#import "TimeSelectViewDemoController.h"
#import <Masonry/Masonry.h>

@interface TimeSelectViewDemoController ()
@property  (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) UIDatePicker *clock;
@property (nonatomic, strong) UIButton *reminderButton;
@property (nonatomic, copy) UILabel *console;

- (void) addReminder:(id) sender;

@end



@implementation TimeSelectViewDemoController

- (instancetype) init{
    self = [super init];
    if(!self){
        return nil;
    }
    [self setTitle:@"Time Select Demo"];
    return self;
}

- (void) loadView{
    [super loadView];
    NSLog(@"%@ loadView.", self.title);
    
    _timeView = [[UIView alloc] initWithFrame:self.view.frame];
    _clock = [[UIDatePicker alloc] initWithFrame:CGRectMake(30, 100, 250, 150)];
    _reminderButton = [[UIButton alloc] initWithFrame:CGRectMake(80, 300, 150, 50)];
    _console = [[UILabel alloc] initWithFrame:CGRectMake(80, 500, 300, 100)];
    
    [_timeView setBackgroundColor:[UIColor whiteColor]];
    
    [_reminderButton setBackgroundColor:[UIColor grayColor]];
    [_reminderButton.titleLabel setText:@"Save"];
    [_reminderButton.titleLabel setTextColor:[UIColor blackColor]];
    [_reminderButton addTarget:self action:@selector(addReminder:) forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:_timeView];
    [_timeView addSubview:_clock];
    [_timeView addSubview:_reminderButton];
    [_timeView addSubview:_console];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@ viewDidLoad.", self.title);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@ viewWillAppear.", self.title);
    
    self.clock.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
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

- (void) addReminder:(id)sender{
    NSDate *data = _clock.date;
    NSLog(@"Setting a reminder for %@", data);
    [_console setText:[NSString stringWithFormat:@"%@", data]];
    
    // Local Notification
//    UILocalNotification *note = [[UILocalNotification alloc] init];
//    [note setAlertBody:@"Hypnotize Me!"];
//    [note setFireDate:data];
//    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

@end
