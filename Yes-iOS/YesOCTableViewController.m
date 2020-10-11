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

@interface YesOCTableViewController ()
@property (nonatomic, strong) dataContainer *dataContainer;
@property (nonatomic, strong) UIView  *bar;
@property (nonatomic, strong) UIButton *edit;
@property (nonnull, strong) UIView *footerView;

@end

@implementation YesOCTableViewController

- (instancetype) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(!self) return nil;
    [self setTitle:@"All Demos"];
    
    _dataContainer = [dataContainer sharedContainer];
    [_dataContainer creatItem:NSLayoutConstraintViewController.class];
    [_dataContainer creatItem:NSLayoutAnchorViewController.class];
    [_dataContainer creatItem:MasonryVersionAutoLayoutViewController.class];
    [_dataContainer creatItem:CollectionViewDemoController.class];
    [_dataContainer creatItem:ScrollViewDemoController.class];
    [_dataContainer creatItem:TimeSelectViewDemoController.class];
    [_dataContainer creatItem:TabBarViewDemoController.class];
    [_dataContainer creatItem:ZoomViewDemoController.class];
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
    [_bar addSubview:_edit];
    
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60.0)];
    UILabel *la = [[UILabel alloc ]init ];
    la.frame = CGRectMake(20, 20, self.view.frame.size.width- 40, 20);
    la.text = @"o(*≧▽≦)ツ┏━┓别看了，到头了！";
    la.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.9];
    la.font = [UIFont systemFontOfSize:15.f];
    la.textAlignment = NSTextAlignmentCenter;
    [_footerView addSubview:la];
    
    [_edit mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_bar.mas_top).offset(5);
        make.bottom.equalTo(_bar.mas_bottom).offset(-5);
        make.width.mas_equalTo(100);
        make.trailing.equalTo(_bar.mas_trailing).offset(-5);
    }];
    
    [self.tableView setTableHeaderView:_bar];
    [self.tableView setTableFooterView:_footerView];
}

#pragma mark - Table view data source
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *items = [_dataContainer allItems];
    dataItem *item = items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YesOCCellReuseIdentifier" forIndexPath:indexPath];
    [cell.textLabel setText:[item title]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataContainer countOfAllItems];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *items = [_dataContainer allItems];
    dataItem *item = items[indexPath.row];
    UIViewController *viewController = item.viewController;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %ld", (long)section];
}

#pragma mark Button Action

- (void) EditMode:(id)sender
{
    self.tableView.editing = !self.tableView.editing;
    if(self.tableView.editing){
        [_edit setTitle:@"Done" forState:UIControlStateNormal];
    }else{
        [_edit setTitle:@"Edit" forState:UIControlStateNormal];
    }
}

@end
