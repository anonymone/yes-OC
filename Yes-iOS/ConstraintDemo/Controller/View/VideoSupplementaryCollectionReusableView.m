//
//  VideoSupplementaryCollectionReusableView.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/14.
//

#import "VideoSupplementaryCollectionReusableView.h"
#import <Masonry/Masonry.h>

@interface VideoSupplementaryCollectionReusableView ()
@property (nonatomic,strong) UIActivityIndicatorView *indicator;

@end

@implementation VideoSupplementaryCollectionReusableView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_indicator setBackgroundColor:[UIColor whiteColor]];
        
        [self setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.8]];
        [self addSubview:_indicator];

        [_indicator mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.leading.equalTo(self.mas_leading);
            make.trailing.equalTo(self.mas_trailing);
        }];
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    NSLog(@"VideoSupplementaryCollectionReusableView load.");
}

- (BOOL) activeIndicator{
    [_indicator startAnimating];
    return [_indicator isAnimating];
}

- (BOOL) muteIndicator{
    [_indicator stopAnimating];
    return [_indicator isAnimating];
}

- (void) refreshData{
    
}

-(void) prepareForReuse{
    [super prepareForReuse];
    self.num = @"";
}

@end
