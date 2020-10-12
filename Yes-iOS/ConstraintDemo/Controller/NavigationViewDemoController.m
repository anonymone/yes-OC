//
//  NavigationViewDemoController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/12.
//

#import <Masonry/Masonry.h>
#import "NavigationViewDemoController.h"
#import "dataItem.h"

@interface NavigationViewDemoController () <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UITextField *titleName;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageDisplay;
@property (nonatomic, strong) UIToolbar *tools;
@property (nonatomic, strong) UIBarButtonItem *cameraShot;
 
// used to store the previous view color of navigationbar.
@property (nonatomic, strong) UIColor *lastviewColer;

@end

@implementation NavigationViewDemoController

- (instancetype) init{
    self = [super init];
    if(self){
        [self setTitle:@"Navigation View Demo"];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearText)];
        UINavigationItem *navItem = self.navigationItem;
        [navItem setRightBarButtonItem:item animated:YES];
    }
    return self;
}

- (void) loadView{
    [super loadView];
    NSLog(@"%@ loadView.", self.title);
    
    _naviView = [[UIView alloc] init];
    [_naviView setBackgroundColor:[UIColor whiteColor]];
    
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setBackgroundColor:[UIColor whiteColor]];
    [_titleLabel setText:@"Title"];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel.font fontWithSize:22.0f];
    
    _titleName = [[UITextField alloc] init];
    [_titleName setBorderStyle:UITextBorderStyleRoundedRect];
    [_titleName setReturnKeyType:UIReturnKeyDone];
    [_titleName setDelegate:self];
    
    _imageDisplay = [[UIImageView alloc] init];
    [_imageDisplay setBackgroundColor:[UIColor grayColor]];
    [_imageDisplay setContentMode:UIViewContentModeScaleAspectFit];
    
    _tools = [[UIToolbar alloc] init];
    [_tools setBackgroundColor:[UIColor grayColor]];
    
    UIImage *camera = [UIImage imageNamed:@"camera.png"];
    _cameraShot = [[UIBarButtonItem alloc] initWithImage:camera style:UIBarButtonItemStylePlain target:self action:@selector(takePicture:)];
    
    [_tools setItems:@[_cameraShot] animated:YES];
    
    [_naviView addSubview:_titleLabel];
    [_naviView addSubview:_titleName];
    [_naviView addSubview:_imageDisplay];
    [_naviView addSubview:_tools];
    [self.view addSubview:_naviView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@ viewDidLoad.", self.title);
    
    [self makeConstraint];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _lastviewColer = self.navigationController.navigationBar.barTintColor;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.527 green:0.804 blue:0.976 alpha:0.9];
    NSLog(@"Source %@ ---> Destination %@", _data.title, _titleName.text);
    
    if(_data){
        [self setTitle:_data.title];
    }
    dataItem *item = self.data;
    [_titleName setText:item.title];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = _lastviewColer;
    [self.view endEditing:YES];
    NSLog(@"Source %@ <--- Destination %@", _data.title, _titleName.text);
    dataItem *item = _data;
    item.title = _titleName.text;
}

#pragma mark Constraint

- (void) makeConstraint{
    [_naviView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_bottom);
        make.trailing.equalTo(self.view.mas_trailing);
        make.leading.equalTo(self.view.mas_leading);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_naviView.mas_top).offset(50);
        make.leading.equalTo(_naviView.mas_leading).offset(20);
        make.trailing.equalTo(_titleName.mas_leading);
        make.height.mas_equalTo(40);
    }];
    
    [_titleName mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_titleLabel.mas_top);
        make.height.equalTo(_titleLabel.mas_height);
        make.width.mas_equalTo(250);
        make.trailing.equalTo(_naviView.mas_trailing).offset(-40);
    }];
    
    [_imageDisplay mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_titleName.mas_bottom).offset(20);
        make.leading.equalTo(_titleLabel.mas_leading);
        make.trailing.equalTo(_titleName.mas_trailing).offset(20);
        make.height.equalTo(_imageDisplay.mas_width);
    }];
    
    [_tools mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(_naviView.mas_leading);
        make.trailing.equalTo(_naviView.mas_trailing);
        make.bottom.equalTo(_naviView.mas_bottom);
        make.height.equalTo(_naviView.mas_width).multipliedBy(0.1);
    }];
    
//    [_cameraShot mas_makeConstraints:^(MASConstraintMaker *make){
//        make.leading.equalTo(_tools.mas_leading).offset(2);
//        make.top.equalTo(_tools.mas_top).offset(2);
//        make.bottom.equalTo(_tools.mas_bottom).offset(-2);
//        make.width.equalTo(_cameraShot.mas_height);
//    }];
}

#pragma mark Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_titleName resignFirstResponder];
    
    return YES;
}

#pragma mark Action

- (void) clearText{
    [_titleName setText:@""];
    [_imageDisplay setImage:nil];
}

- (void) takePicture:(id)sender{
    NSLog(@"take Picture!");
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [_imageDisplay setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
