//
//  ScrollViewDemoController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/9.
//

#import "ScrollViewDemoController.h"
#import "BNRHypnosisView.h"
#import <Masonry/Masonry.h>

@interface ScrollViewDemoController ()
@property (nonatomic, strong) BNRHypnosisView *BNRviewPre;
@property (nonatomic, strong) BNRHypnosisView *BNRView;
@property (nonatomic, strong) BNRHypnosisView *BNRViewNext;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ScrollViewDemoController
- (instancetype) init{
    self  = [super init];
    if(!self){
        return nil;
    }
    [self setTitle:@"ScrollView Demo"];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    [_BNRviewPre setBackgroundColor:[UIColor whiteColor]];
    [_BNRView setBackgroundColor:[UIColor whiteColor]];
    [_BNRViewNext setBackgroundColor:[UIColor whiteColor]];
    
    [_scrollView addSubview:_BNRviewPre];
    [_scrollView addSubview:_BNRView];
    [_scrollView addSubview:_BNRViewNext];
    
    [self.view addSubview:_scrollView];
    
    //tell the UIScrollView how large the window is.
    [_scrollView setContentSize:bigRect.size];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
}

@end
