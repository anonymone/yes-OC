//
//  YesOCTableViewController.m
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/5.
//

#import "YesOCTableViewController.h"
#import "NSLayoutConstraintViewController.h"
#import "NSLayoutAnchorViewController.h"
#import "MasonryVersionAutoLayoutViewController.h"
#import "CollectionViewDemoController.h"
#import "BNRHypnosisViewController.h"

@interface YesOCTableViewController ()
@property (nonatomic, strong) NSArray *DemoList;

@end

@implementation YesOCTableViewController

- (instancetype) init
{
    self = [super init];
    if(!self) return nil;
    [self setTitle:@"All Demos"];
    _DemoList = @[
        [[NSLayoutConstraintViewController alloc] init],
        [[NSLayoutAnchorViewController alloc] init],
        [[MasonryVersionAutoLayoutViewController alloc] init],
        [[CollectionViewDemoController alloc] init],
        [[BNRHypnosisViewController alloc] init]
    ];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"YesOCCellReuseIdentifier"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *viewController = _DemoList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YesOCCellReuseIdentifier" forIndexPath:indexPath];
    [cell.textLabel setText:viewController.title];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _DemoList.count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *viewController = _DemoList[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
