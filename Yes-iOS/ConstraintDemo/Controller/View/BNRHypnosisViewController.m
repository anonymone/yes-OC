//
//  BNRHypnosisViewController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/9.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"
#import <Masonry/Masonry.h>

@interface BNRHypnosisViewController ()
@property (nonatomic, strong) BNRHypnosisView *BNRView;
@end

@implementation BNRHypnosisViewController

- (instancetype) init{
    self  = [super init];
    if(!self){
        return nil;
    }
    [self setTitle:@"Draw Demo"];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _BNRView = [[BNRHypnosisView alloc] initWithFrame:self.view.bounds];
    [_BNRView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_BNRView];
    
    [_BNRView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
