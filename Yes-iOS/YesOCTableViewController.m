//
//  YesOCTableViewController.m
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/5.
//

#import <Masonry/Masonry.h>
#import "dataContainer.h"
#import "dataItem.h"
#import "YesOCTableViewController.h"
#import "NSLayoutConstraintViewController.h"
#import "NSLayoutAnchorViewController.h"
#import "MasonryVersionAutoLayoutViewController.h"
#import "CollectionViewDemoController.h"
#import "ScrollViewDemoController.h"
#import "TimeSelectViewDemoController.h"
#import "TabBarViewDemoController.h"
#import "ZoomViewDemoController.h"
#import "NavigationViewDemoController.h"
#import "URLSessionViewDemoController.h"

@interface YesOCTableViewController ()
@property (nonatomic, strong) dataContainer *dataContainer;
@property (nonatomic, strong) dataContainer *dataContainerAdd;
@property (nonatomic, strong) NSArray *componentList;

@property (nonatomic, strong) UIView  *bar;
@property (nonatomic, strong) UIButton *edit;
@property (nonatomic, strong) UIButton *add;
@property (nonnull, strong) UIView *footerView;

@end

@implementation YesOCTableViewController

- (instancetype) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(!self) return nil;
    [self setTitle:@"All Demos"];
    
    _componentList = @[
        NSLayoutConstraintViewController.class,
        NSLayoutAnchorViewController.class,
        MasonryVersionAutoLayoutViewController.class,
        CollectionViewDemoController.class,
        ScrollViewDemoController.class,
        TimeSelectViewDemoController.class,
        TabBarViewDemoController.class,
        ZoomViewDemoController.class,
        NavigationViewDemoController.class,
        URLSessionViewDemoController.class
    ];
    
    _dataContainer = [[dataContainer alloc] init];
    for(int i=0; i<[_componentList count]; i++){
        [_dataContainer creatItem:_componentList[i]];
    }
    
    _dataContainerAdd = [[dataContainer alloc] init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"YesOCCellReuseIdentifier"];
    
    _bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _edit = [UIButton buttonWithType:UIButtonTypeSystem];
    [_edit.layer setCornerRadius:20.0];
    [_edit setTitle:@"Edit" forState:UIControlStateNormal];
    [_edit.titleLabel setFont:[UIFont fontWithName:_edit.titleLabel.font.fontName size:18.0f]];
    [_edit setBackgroundColor:[UIColor colorWithRed:0.527 green:0.804 blue:0.976 alpha:0.9]];
    [_edit addTarget:self action:@selector(EditMode:) forControlEvents:UIControlEventTouchDown];
    [_bar setBackgroundColor:[UIColor clearColor]];
    
    _add = [UIButton buttonWithType:UIButtonTypeSystem];
    [_add.layer setCornerRadius:20.0];
    [_add setTitle:@"+" forState:UIControlStateNormal];
    [_add.titleLabel setFont:[UIFont fontWithName:_edit.titleLabel.font.fontName size:18.0f]];
    [_add setBackgroundColor:[UIColor colorWithRed:0.527 green:0.804 blue:0.976 alpha:0.9]];
    [_add addTarget:self action:@selector(addNewItem:) forControlEvents:UIControlEventTouchDown];
    [_bar addSubview:_edit];
    [_bar addSubview:_add];
    
    [_edit mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_bar.mas_top).offset(5);
        make.bottom.equalTo(_bar.mas_bottom).offset(-5);
        make.width.mas_equalTo(100);
        make.trailing.equalTo(_add.mas_leading).offset(-5);
    }];
    
    [_add mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_bar.mas_top).offset(5);
        make.bottom.equalTo(_bar.mas_bottom).offset(-5);
        make.width.mas_equalTo(40);
        make.trailing.equalTo(_bar.mas_trailing).offset(-5);
    }];
    
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60.0)];
    UILabel *la = [[UILabel alloc ]init ];
    la.frame = CGRectMake(20, 20, self.view.frame.size.width- 40, 20);
    la.text = @"o(*≧▽≦)ツ┏━┓别看了，到头了！";
    la.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.9];
    la.font = [UIFont systemFontOfSize:15.f];
    la.textAlignment = NSTextAlignmentCenter;
    [_footerView addSubview:la];
    
    [self.tableView setTableHeaderView:_bar];
    [self.tableView setTableFooterView:_footerView];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *items = nil;
    dataItem *item = nil;
    if(indexPath.section==0){
        items = [_dataContainer allItems];
        item = items[indexPath.row];
    }else{
        items = [_dataContainerAdd allItems];
        item = items[indexPath.row];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YesOCCellReuseIdentifier" forIndexPath:indexPath];
    
    [cell.textLabel setText:[item title]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?[_dataContainer countOfAllItems]:[_dataContainerAdd countOfAllItems];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *items = nil;
    dataItem *item = nil;
    if(indexPath.section==0){
        items = [_dataContainer allItems];
        item = items[indexPath.row];
    }else{
        items = [_dataContainerAdd allItems];
        item = items[indexPath.row];
    }
    if([item.viewController respondsToSelector:@selector(setData:)]){
        [(NavigationViewDemoController *)item.viewController  setData:item];
    }
    UIViewController *viewController = item.viewController;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section==0?[NSString stringWithFormat:@"候选Demo (o´ω`o)"]:[NSString stringWithFormat:@"你加的Demo(๑•̀ㅂ•́)✧"];
}

//Do not show edit the Section 0;
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // fix Section 0 with editing unable.
    if (indexPath.section == 1) {
        return YES;
    }
    return NO;
}

// Do not move specific Row int section.
- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1 && indexPath.row==0){
        return NO;
    }else{
        return YES;
    }
}

// Foibid specific row in movable state.
- (NSIndexPath *) tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    if(sourceIndexPath.row == 0 || proposedDestinationIndexPath.row == 0 || proposedDestinationIndexPath.section != 1){
        return sourceIndexPath;
    }else{
        return proposedDestinationIndexPath;
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSArray *items = nil;
    if(editingStyle == UITableViewCellEditingStyleDelete){
        items = [_dataContainerAdd allItems];
        dataItem *item = items[indexPath.row];
        [_dataContainerAdd removeItem:item];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if(destinationIndexPath.section == 0 || destinationIndexPath.row == 0){
        destinationIndexPath = sourceIndexPath;
        return;
    }
    [_dataContainerAdd moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

// Modify the editingAccessryView
- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"_(:з」∠)_ 删除"];
}

#pragma mark Button Action

- (void) EditMode:(id)sender
{
    [self setEditing:!self.editing animated:YES];
    if(self.editing){
        [_edit setTitle:@"Done" forState:UIControlStateNormal];
    }else{
        [_edit setTitle:@"Edit" forState:UIControlStateNormal];
    }
}

- (void) addNewItem:(id)sender
{
    dataItem *item = [_dataContainerAdd creatItem:_componentList[arc4random()%[_componentList count]]];
    NSInteger lastRow = [[_dataContainerAdd allItems] indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:1];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    NSLog(@"Add new Item at Section %li Row %li", (long)indexPath.section, (long)indexPath.row);
}

@end
