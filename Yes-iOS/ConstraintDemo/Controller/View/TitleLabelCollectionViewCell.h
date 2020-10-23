//
//  TitleLabelCollectionViewCell.h
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TitleLabelCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *label;

+(CGFloat)textHeight:(NSString *)text width:(CGFloat)width;
+ (CGFloat) singleLineHeight;

@end

NS_ASSUME_NONNULL_END
