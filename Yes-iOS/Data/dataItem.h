//
//  dataItem.h
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface dataItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIViewController *viewController;

- (instancetype) initWithClass:(Class) withClass;

@end

NS_ASSUME_NONNULL_END
