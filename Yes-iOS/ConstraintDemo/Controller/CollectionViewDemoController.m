//
//  CollectionViewDemoController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/9.
//
#import "CollectionViewDemoController.h"
#import "VideoCollectionViewCell.h"
#import "VideoSupplementaryCollectionReusableView.h"
#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

static NSString *VIDEO_CELL_IDENTIFIER = @"VideoContainer";
static NSString *VIDEO_SUPPLEMENTARY_IDENTIFIER = @"VideoSupplementaryIdentifier";

@interface CollectionViewDemoController () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic, strong) UICollectionViewLayout *layout;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) VideoSupplementaryCollectionReusableView *footer;

//State
@property (nonatomic) BOOL loading;

@end

@implementation CollectionViewDemoController
//@synthesize collectionView =_collectionView;

- (instancetype) init{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _loading = NO;
    _dataList = [[NSMutableArray alloc] init];
    
    self = [super initWithCollectionViewLayout:_flowLayout];
    if(self){
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self setTitle:@"CollectionView Demo"];
        
        //load Data
        for(int i=0; i<3; i++){
            [_dataList addObject:[self randColor]];
        }
    }
    return self;
}

- (void) loadView{
    [super loadView];
    
    [_flowLayout setMinimumInteritemSpacing:0];
    [_flowLayout setMinimumLineSpacing:0];
    [_flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_flowLayout setFooterReferenceSize:CGSizeMake(self.view.frame.size.width, 30)];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:_flowLayout];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setPagingEnabled:YES];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
    }];
    
    [self.collectionView registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:VIDEO_CELL_IDENTIFIER];
//    [self.collectionView registerClass:[VideoSupplementaryCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:VIDEO_SUPPLEMENTARY_IDENTIFIER];
    [self.collectionView registerClass:[VideoSupplementaryCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:VIDEO_SUPPLEMENTARY_IDENTIFIER];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark Delegate

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = collectionView.safeAreaLayoutGuide.layoutFrame.size;
    return size;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*0.1);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(_loading || _footer==nil){
        return;
    }
    
    if(self.footer.frame.origin.y < (scrollView.contentOffset.y + scrollView.bounds.size.height)){
        _loading =YES;
        [_footer activeIndicator];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //load Data
            for(int i=0; i<3; i++){
                [self.dataList addObject:[self randColor]];
            }
            CGPoint recentPoint = self.collectionView.contentOffset;
            recentPoint.y -= self.footer.frame.size.height;
            
            [UICollectionView transitionWithView:self.collectionView duration:0.2 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){
                [self.collectionView setContentOffset:recentPoint];
                self.footer = nil;
                [self.collectionView reloadData];
            } completion:nil];
            
            self.loading =NO;
        });
    }
}

#pragma mark SourceDelegate

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoCollectionViewCell *cell = (VideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:VIDEO_CELL_IDENTIFIER forIndexPath:indexPath];
    [cell setNum:[NSString stringWithFormat:@"%ld", indexPath.item]];
    [cell setColor:[_dataList objectAtIndex:indexPath.row]];
    [cell refreshData];
    return cell;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    VideoSupplementaryCollectionReusableView *reusableCell = (VideoSupplementaryCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:VIDEO_SUPPLEMENTARY_IDENTIFIER forIndexPath:indexPath];
    if(kind == UICollectionElementKindSectionHeader){
        reusableCell.num = [NSString stringWithFormat:@"The Header."];
    }else if(kind == UICollectionElementKindSectionFooter){
        reusableCell.num = [NSString stringWithFormat:@"The Footer."];
        _footer = reusableCell;
    }else{
        reusableCell.num = [NSString stringWithFormat:@"UnKnown Thing."];
    }
//    if(kind != UICollectionElementKindSectionFooter){
//        _footer = nil;
//    }
    NSLog(@"%@ Loaded.", reusableCell.num);
    [reusableCell refreshData];
    return reusableCell;
}

- (void)addItem:(id)sender {
    
}

- (UIColor *) randColor{
    float red = (50+(arc4random()%200))/250.0;
    float green = ((arc4random()%250))/250.0;
    float blue = ((arc4random()%250))/250.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.8];
    return color;
}

@end
