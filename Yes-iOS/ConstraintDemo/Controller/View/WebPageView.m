//
//  WebPageView.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/16.
//

#import "WebPageView.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>

@interface WebPageView ()

@property (nonatomic, strong) UIView *viewContainer;
@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation WebPageView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        
        _viewContainer = [[UIView alloc] init];
        [_viewContainer setBackgroundColor:[UIColor clearColor]];
        
        _webPage = [[WKWebView alloc] initWithFrame:frame];
        _title = [[UILabel alloc] init];
        [_title setTextAlignment:NSTextAlignmentCenter];
        
        _exit = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_exit setTitle:@"Exit" forState:UIControlStateNormal];
        
        [_exit setBackgroundColor:[UIColor whiteColor]];
        
        _effectView = [[UIVisualEffectView alloc] initWithFrame:self.frame];
        [_effectView setEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        [_effectView setAlpha:0.8f];
        
        //[self addSubview:_effectView];
        [self addSubview:_viewContainer];
        [self.viewContainer addSubview:_webPage];
        [self.viewContainer addSubview:_exit];
        [self.viewContainer addSubview:_title];
        
        NSInteger marginTitle = 5;
        
        [_viewContainer mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top).offset(100);
            make.bottom.equalTo(self.mas_bottom);
            make.trailing.equalTo(self.mas_trailing);
            make.leading.equalTo(self.mas_leading);
        }];
        
        [_exit mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.viewContainer.mas_top).offset(marginTitle);
            make.leading.equalTo(self.viewContainer.mas_leading).offset(marginTitle);
            make.height.mas_equalTo(@40);
            make.width.equalTo(_exit.mas_height).multipliedBy(1.5);
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_exit.mas_top);
            make.leading.equalTo(_exit.mas_trailing);
            make.trailing.equalTo(self.viewContainer.mas_trailing).offset(-marginTitle);
            make.height.equalTo(_exit.mas_height);
        }];
        
        [_webPage mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_exit.mas_bottom);
            make.leading.equalTo(self.viewContainer.mas_leading);
            make.trailing.equalTo(self.viewContainer.mas_trailing);
            make.bottom.equalTo(self.viewContainer.mas_bottom);
        }];
    }
    return self;
}

- (void) willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    [self.layer setCornerRadius:8.0f];
}

- (void) updatePage{
    [_webPage loadRequest:_request];
    [_title setText:[_request URL].host];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
