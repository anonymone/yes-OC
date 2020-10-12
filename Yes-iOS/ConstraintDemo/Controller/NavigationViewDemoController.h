//
//  NavigationViewDemoController.h
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/12.
//

#import <UIKit/UIKit.h>

@class dataItem;

NS_ASSUME_NONNULL_BEGIN

@interface NavigationViewDemoController : UIViewController
@property (nonatomic, strong) dataItem *data;

- (void) setData:(dataItem * _Nullable)data;

@end

NS_ASSUME_NONNULL_END
