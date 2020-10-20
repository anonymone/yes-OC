//
//  WebPageView.h
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/16.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebPageView : UIView
@property (nonatomic, strong) UIButton *exit;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) WKWebView *webPage;

- (void) updatePage;

@end

NS_ASSUME_NONNULL_END
