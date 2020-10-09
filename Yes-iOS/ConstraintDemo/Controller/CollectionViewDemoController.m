//
//  CollectionViewDemoController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/9.
//
#import "CollectionViewDemoController.h"

@interface CollectionViewDemoController ()
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation CollectionViewDemoController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype) init{
    self = [super init];
    if(!self){
        return nil;
    }
    [self setTitle:@"CollectionView Demo"];
    _data = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3",nil];
    
    // 设置流水布局
    _layout = [[UICollectionViewFlowLayout alloc]init];
    // 定义大小
    _layout.itemSize = CGSizeMake(100, 100);
    // 设置最小行间距
    _layout.minimumLineSpacing = 2;
    // 设置垂直间距
    _layout.minimumInteritemSpacing = 2;
    // 设置滚动方向（默认垂直滚动）
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [self initWithCollectionViewLayout:_layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:_layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
//    // Do any additional setup after loading the view.
//    _viewCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
//    [self.view addSubview:_viewCollectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    [cell setBackgroundColor:[UIColor colorWithRed:rand() green:rand() blue:rand() alpha:1]];
    cell.largeContentTitle = _data[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
