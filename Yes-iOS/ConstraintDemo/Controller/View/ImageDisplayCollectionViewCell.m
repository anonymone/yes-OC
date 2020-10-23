//
//  ImageDisplayCollectionViewCell.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/23.
//

#import "ImageDisplayCollectionViewCell.h"

@interface ImageDisplayCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong)  UIActivityIndicatorView *loadingIndicator;

@end

@implementation ImageDisplayCollectionViewCell
- (UIImageView *) imageView {
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setClipsToBounds:YES];
        [_imageView setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
    }
    return _imageView;
}

- (UIActivityIndicatorView *) loadingIndicator {
    if(!_loadingIndicator){
        _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_loadingIndicator startAnimating];
    }
    return _loadingIndicator;
}

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self.contentView addSubview:[self imageView]];
        [self.contentView addSubview:[self loadingIndicator]];
    }
    return  self;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    _loadingIndicator.center = CGPointMake(bounds.size.width/2.0, bounds.size.height/2.0);
    _imageView.frame = bounds;
}

- (void) setImage:(UIImage *)image{
    _imageView.image = image;
    NSLog(@"Image Size %@", image);
    if(image){
        [_loadingIndicator stopAnimating];
    }else{
        [_loadingIndicator startAnimating];
    }
}

@end
