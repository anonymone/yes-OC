//
//  VideoSupplementaryCollectionReusableView.h
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoSupplementaryCollectionReusableView : UICollectionReusableView
@property (nonatomic, copy) NSString *num;

- (void) refreshData;

- (BOOL) activeIndicator;
- (BOOL) muteIndicator;

@end

NS_ASSUME_NONNULL_END
