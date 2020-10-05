//
//  MasonryVersionAutoLayoutViewController.m
//  Yes-iOS
//
//  Created by Severus Peng on 2020/10/4.
//

#import "MasonryVersionAutoLayoutViewController.h"
#import <Masonry.h>
@interface MasonryVersionAutoLayoutViewController ()

@end

@implementation MasonryVersionAutoLayoutViewController

- (instancetype) init{
    self = [super init];
    if(!self){
        return nil;
    }
    [self setTitle:@"Masonry"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    return self;
}

- (void) loadView
{
    [super loadView];
    
    _yellow = [[UIView alloc] init];
    _green = [[UIView alloc] init];
    _red = [[UIView alloc] init];
    
    [_yellow setBackgroundColor:[UIColor yellowColor]];
    [_green setBackgroundColor:[UIColor greenColor]];
    [_red setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:_yellow];
    [_yellow addSubview:_green];
    [_yellow addSubview:_red];
    
    CGFloat margin = 20;
    
    [_yellow mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(self.view).offset(margin);
        make.trailing.equalTo(self.view).offset(-margin);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(margin);
        make.bottom.equalTo(self.view).offset(-margin);
    }];
    
    [_green mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(_yellow).offset(margin);
        make.trailing.equalTo(_yellow).offset(-margin);
        make.top.equalTo(_yellow).offset(margin);
        make.bottom.equalTo(_red.mas_top).offset(-margin);
    }];
    
    [_red mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(_yellow).offset(margin);
        make.trailing.equalTo(_yellow).offset(-margin);
        make.height.equalTo(_green).multipliedBy(2.0);
        make.bottom.equalTo(_yellow).offset(-margin);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
