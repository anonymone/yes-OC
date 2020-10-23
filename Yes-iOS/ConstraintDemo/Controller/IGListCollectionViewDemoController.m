//
//  IGListCollectionViewDemoController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/21.
//

#import "IGListCollectionViewDemoController.h"
#import "LoadingCollectionViewCell.h"
#import "ImageSectionController.h"
#import "LabelSectionController.h"
#import <IGListKit.h>
#import <Masonry/Masonry.h>

@interface IGListCollectionViewDemoController () <IGListAdapterDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic,strong) IGListCollectionView *collectionView;

@property (nonatomic, strong) UIView *toolsBarView;
@property (nonatomic, strong) UIPanGestureRecognizer *adjustRecongnizer;
@property (nonatomic, assign) CGSize SectionSize;

@property (nonatomic) BOOL isLoading;
@property (nonatomic, assign) NSInteger colunm;

@end

@implementation IGListCollectionViewDemoController

- (instancetype) init{
    if(self){
        self.title = @"IGList CollectionView Demo";
        _colunm = 2;
    }
    _isLoading = NO;
    return self;
}

- (NSMutableArray *) configData{
    _SectionSize = CGSizeMake(self.view.bounds.size.width/self.colunm, self.view.bounds.size.width);
    
    if(_data){
        _data = [NSMutableArray arrayWithObjects:
                 [[ImageItem alloc] init:[self randColor] itemSize: &_SectionSize webURL:@"https://picsum.photos/200/300"],
                 [[ImageItem alloc] init:[self randColor] itemSize: &_SectionSize webURL:@"https://picsum.photos/200/300"],
                 [[ImageItem alloc] init:[self randColor] itemSize: &_SectionSize webURL:@"https://picsum.photos/200/300"],
                 [[ImageItem alloc] init:[self randColor] itemSize: &_SectionSize webURL:@"https://picsum.photos/200/300"],
                 [[ImageItem alloc] init:[self randColor] itemSize: &_SectionSize webURL:@"https://picsum.photos/200/300"],
                 nil];
    }
    return _data;
}

#pragma mark ViewLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    
    [self.view addSubview:[self collectionView]];
    [self.view addSubview:[self toolsBarView]];
    
    [self makeConstraint];
    
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
    self.adapter.scrollViewDelegate = self;
}

- (void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _collectionView.frame = self.view.bounds;
}

- (void) makeConstraint{
    [_toolsBarView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.2);
    }];
}

- (UIView *) toolsBarView{
    if(!_toolsBarView){
        _toolsBarView = [[UIView alloc] init];
        [_toolsBarView setBackgroundColor:[UIColor clearColor]];
    }
    return _toolsBarView;
}

- (CGSize *) getSectionSizeADD{
    return &_SectionSize;
}

#pragma mark IGListDataSource

- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self workingRangeSize:4];
    }
    return _adapter;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
//        MultiFeedCollectionFlowLayout *layout = [[MultiFeedCollectionFlowLayout alloc] init];
//        layout.columnCount = 3;
//        layout.itemList = _data;
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
    }
    return _collectionView;
}

- (NSArray<id<IGListDiffable>> *) objectsForListAdapter:(IGListAdapter *)listAdapter{
    if(_isLoading){
        [self.data addObject:@"loadingToken"];
    }
    return [self.data mutableCopy];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    if([object isKindOfClass:[NSString class]]){
        return [[IGListSingleSectionController  alloc] initWithCellClass:LoadingCollectionViewCell.class configureBlock:^(id _Nonnull item, __kindof LoadingCollectionViewCell * _Nonnull cell){
            [cell.activityIndicator startAnimating];
        } sizeBlock:^CGSize(id  _Nonnull item, id<IGListCollectionContext>  _Nullable collectionContext) {
            return CGSizeMake([collectionContext containerSize].width, 100);
        }];
    }else{
        return [[ImageSectionController alloc] init];
    }
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return nil;
}

- (void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (UIColor *) randColor{
    float red = (50+(arc4random()%200))/250.0;
    float green = ((arc4random()%250))/250.0;
    float blue = ((arc4random()%250))/250.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.8];
    return color;
}

#pragma mark UIGestureRecognizerDelegate


#pragma mark UIScrollViewDelegate

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGFloat distance = scrollView.contentSize.height - (targetContentOffset->y + scrollView.bounds.size.height);
    
    if(!_isLoading && distance< 200){
        _isLoading = YES;
        
        [self.adapter performUpdatesAnimated:YES completion:nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
            sleep(2);
            
            dispatch_async(dispatch_get_main_queue(), ^(){
                self.isLoading = NO;
                //NSInteger itemCount = self.data.count;
                [self.data removeLastObject];
                for(int i=0; i<10; i++){
                    [self.data addObject:[[ImageItem alloc] init:[self randColor] itemSize: [self getSectionSizeADD] webURL:@"https://picsum.photos/200/300"]];
                }
                [self.adapter performUpdatesAnimated:YES completion:nil];
            });
        });
    }
}

#pragma mark GestureAction

//- (void) changeColunmNumber:(UIPanGestureRecognizer *) gr{
//    if(gr.state == UIGestureRecognizerStateChanged){
//        CGPoint translation = [gr translationInView:_toolsBarView];
//        //NSLog(@"x:%f  y:%f", translation.x, translation.y);
//        if(translation.x<(self.view.bounds.size.width/self.colunm)){
//            return;
//        }else{
//            if(translation.x>0){
//                self.colunm = 3;
//            }else{
//                self.colunm = 2;
//            }
//        }
//        _SectionSize = CGSizeMake(self.view.bounds.size.width/self.colunm, self.view.bounds.size.width);
//        [self.adapter reloadDataWithCompletion:nil];
//    }
//}

@end
