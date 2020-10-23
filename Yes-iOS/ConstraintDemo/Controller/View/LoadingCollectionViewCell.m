//
//  LoadingCollectionViewCell.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/22.
//

#import "LoadingCollectionViewCell.h"

@implementation LoadingCollectionViewCell
- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:_activityIndicator];
    }
    return _activityIndicator;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds=self.bounds;
    self.activityIndicator.center=CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
}
@end
