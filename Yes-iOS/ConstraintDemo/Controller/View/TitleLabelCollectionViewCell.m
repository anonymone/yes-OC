//
//  TitleLabelCollectionViewCell.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/21.
//

#import "TitleLabelCollectionViewCell.h"

@interface TitleLabelCollectionViewCell ()
@property (nonatomic, strong) CALayer *separator;
@property (nonatomic, assign) CGFloat singleLineHeight;

@end

@implementation TitleLabelCollectionViewCell

-  (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self.contentView addSubview:self.label];
        [self.contentView.layer addSublayer:self.separator];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+(UIFont *)font{
    return [UIFont systemFontOfSize:17.0];
}

+(UIEdgeInsets)insets{
    return UIEdgeInsetsMake(8, 15, 8, 15);
}

+(CGFloat)singleLineHeight{
    return self.font.lineHeight + self.insets.top + self.insets.bottom;
}

+(CGFloat)textHeight:(NSString *)text width:(CGFloat)width{
    CGSize constrainedSize = CGSizeMake(width - self.insets.left - self.insets.right, FLT_MAX);
    
    NSDictionary *attributes=@{NSFontAttributeName:self.font};
    
    CGRect bounds=[text boundingRectWithSize:constrainedSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return ceil(bounds.size.height) + self.insets.top + self.insets.bottom;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.numberOfLines=1;
        _label.font=[TitleLabelCollectionViewCell font];
    }
    return _label;
}

- (CALayer *)separator {
    if (!_separator) {
        _separator = [CALayer layer];
        _separator.backgroundColor=[UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1].CGColor;
    }
    return _separator;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    _label.frame = UIEdgeInsetsInsetRect(bounds, [TitleLabelCollectionViewCell insets]);
    CGFloat height = 0.5;
    CGFloat left=[TitleLabelCollectionViewCell insets].left;
    _separator.frame = CGRectMake(left, bounds.size.height, bounds.size.width-left, height);
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    self.contentView.backgroundColor=[UIColor colorWithWhite:highlighted ? 0.9 : 1 alpha:1];
}

@end
