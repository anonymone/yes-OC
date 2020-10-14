//
//  VideoCollectionViewCell.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/14.
//

#import "VideoCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface VideoCollectionViewCell () <UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIView  *cellView;
@property (nonatomic, strong) UILabel *title;

@end

@implementation VideoCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self buildCell];
        [self refreshData];
    }
    return self;
}

- (void) buildCell{
    _cellView = [[UIView alloc] initWithFrame:self.contentView.frame];
    _title = [[UILabel alloc] init];
    
    [_cellView addSubview:_title];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_cellView.mas_top).offset(2);
        make.bottom.equalTo(_cellView.mas_bottom).offset(-2);
        make.leading.equalTo(_cellView.mas_leading).offset(2);
        make.trailing.equalTo(_cellView.mas_trailing).offset(-2);
    }];
    
    [_title setTextAlignment:NSTextAlignmentCenter];
    
    [self.contentView addSubview:_cellView];
}

- (void)refreshData{
    [_title setText:_num];
    [_cellView setBackgroundColor:_color];
}

- (void) prepareForReuse{
    static NSInteger calledTimes = 0;
    NSLog(@"%@ prepareForReeuse called %li Times", self.title.text, (long)calledTimes++);
    [super prepareForReuse];
    self.num = @"";
}

@end
