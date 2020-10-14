//
//  VideoCollectionViewCell.h
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString *num;
@property (nonatomic, strong) UIColor *color;

- (void) refreshData;

@end

NS_ASSUME_NONNULL_END
