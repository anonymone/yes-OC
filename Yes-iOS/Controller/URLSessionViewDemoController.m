//
//  URLSessionViewDemoController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/15.
//

#import "URLSessionViewDemoController.h"
#import <Masonry/Masonry.h>
#import <WebKit/WebKit.h>
#import "AppDelegate.h"

@interface URLSessionViewDemoController ()
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) UITextField *URLText;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIProgressView *prograssBar;
@property (nonatomic, strong) UITextView *consoleText;

@property (nonatomic,strong) UIViewController *webController;
@property (nonatomic, strong) WKWebView *webPage;

//load Task

@end

@implementation URLSessionViewDemoController

- (instancetype) init{
    self = [super init];
    if(self){
        [self setTitle:@"Network Demo"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDateProgressBar:) name:kDownloadProgressBar object:nil];
    }
    return self;
}

- (void) loadView{
    [super loadView];
    [self backgroudURLSession];
    
    _URLText = [[UITextField alloc] init];
    _loadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _prograssBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _consoleText = [[UITextView alloc] init];
    
    [_URLText setBorderStyle:UITextBorderStyleRoundedRect];
    [_URLText setText:@"https://www.bytedance.com/"];
    
    [_loadButton setTitle:@"Search" forState:UIControlStateNormal];
    [_loadButton.layer setBorderWidth:0.5f];
    [_loadButton.layer setCornerRadius:4.0f];
    [_loadButton.layer setBorderColor:[UIColor grayColor].CGColor];
    [_loadButton addTarget:self action:@selector(searchWeb:) forControlEvents:UIControlEventTouchUpInside];
    
    [_prograssBar setHidden:YES];
    [_prograssBar.layer setShadowRadius:5.0f];
    
    [_consoleText.layer setBorderWidth:0.5f];
    [_consoleText.layer setCornerRadius:10.0f];
    [_consoleText.layer setBorderColor:[UIColor grayColor].CGColor];
    [_consoleText.layer setBackgroundColor:[UIColor blackColor].CGColor];
    [_consoleText setTextColor:[UIColor whiteColor]];
    [_consoleText setText:@"JAVIS@iPhone12 ~ % "];
    [_consoleText setEditable:NO];
    
    _webController = [[UIViewController alloc] init];
    _webPage =  [[WKWebView alloc] initWithFrame:self.view.bounds];
    [_webController.view addSubview:_webPage];
    
    [self.view addSubview:_URLText];
    [self.view addSubview:_loadButton];
    [self.view addSubview:_prograssBar];
    [self.view addSubview:_consoleText];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeConstraint];
}

- (void) makeConstraint{
    [_webPage mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_webController.view.mas_safeAreaLayoutGuideTop);
        make.leading.equalTo(_webController.view.mas_leading);
        make.trailing.equalTo(_webController.view.mas_trailing);
        make.bottom.equalTo(_webController.view.mas_bottom);
    }];
    
    [_URLText mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(50);
        make.leading.equalTo(self.view.mas_leading).offset(20);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.6);
        make.height.mas_equalTo(40);
    }];
    
    [_loadButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.URLText.mas_top);
        make.leading.equalTo(self.URLText.mas_trailing).offset(10);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.height.equalTo(self.URLText.mas_height);
    }];
    
    [_prograssBar mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.URLText.mas_bottom).offset(10);
        make.leading.equalTo(self.URLText.mas_leading);
        make.trailing.equalTo(self.loadButton.mas_trailing);
        make.height.mas_offset(5);
    }];
    
    [_consoleText mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_URLText.mas_bottom).offset(10);
        make.leading.equalTo(self.URLText.mas_leading);
        make.trailing.equalTo(self.loadButton.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom).offset(-200);
    }];
}

#pragma mark Network

- (void)backgroudURLSession{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
}

#pragma mark Delegate

- (void) upDateProgressBar:(NSNotification *) notification{
    NSDictionary *userInfo = notification.userInfo;
    CGFloat fProgress = [userInfo[@"progress"] floatValue];
    [_prograssBar setProgress:fProgress];
}

#pragma mark Action

- (void) searchWeb:(id) sender{
    NSLog(@"%@ searchWeb", self.title);
    NSURL *url = [NSURL URLWithString:_URLText.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.consoleText setText:[NSString stringWithFormat:@"%@", response]];
        });
    }];
    [task resume];
    
    [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.prograssBar.hidden = NO;
        [self.consoleText mas_remakeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.prograssBar.mas_bottom).offset(1);
            make.leading.equalTo(self.URLText.mas_leading);
            make.trailing.equalTo(self.loadButton.mas_trailing);
            make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished){
        if(finished){
            //[self.navigationController pushViewController:self.webController animated:YES];
            [self.webPage loadRequest:request];
        }
    }];
    [_URLText resignFirstResponder];
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
