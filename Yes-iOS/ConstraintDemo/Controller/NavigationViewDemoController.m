//
//  NavigationViewDemoController.m
//  Yes-iOS
//
//  Created by ShichenPeng on 2020/10/12.
//

#import <Masonry/Masonry.h>
#import "NavigationViewDemoController.h"
#import "dataItem.h"
#import "dataImageItem.h"
#import "dataImageStore.h"

@interface NavigationViewDemoController () <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UITextField *titleName;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageDisplay;
@property (nonatomic, strong) UIToolbar *tools;
@property (nonatomic, strong) UIBarButtonItem *cameraShot;
@property (nonatomic, strong) UIBarButtonItem *albums;
 
// used to store the previous view color of navigationbar.
@property (nonatomic, strong) UIColor *lastviewColer;
@property (nonatomic, strong) dataImageStore *imageStore;

@end

@implementation NavigationViewDemoController

- (instancetype) init{
    self = [super init];
    if(self){
        [self setTitle:@"Navigation View Demo"];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearText)];
        UINavigationItem *navItem = self.navigationItem;
        [navItem setRightBarButtonItem:item animated:YES];
        _imageStore = [dataImageStore sharedStore];
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
    [_imageDisplay setBackgroundColor:[UIColor clearColor]];
    [_imageDisplay setContentMode:UIViewContentModeScaleAspectFit];
    
    _tools = [[UIToolbar alloc] init];
    [_tools setBarStyle:UIBarStyleDefault];
    
//    UIImage *camera = [UIImage imageNamed:@"camera.png"];
//    UIImage *gallery = [UIImage imageNamed:@"gallery.png"];
    
    UIBarButtonItem *gap0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    _cameraShot = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture:)];
    UIBarButtonItem *gap1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    _albums = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(selectFromAlbum:)];
    UIBarButtonItem *gap2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    _tools.items = @[gap0, _cameraShot, gap1, _albums, gap2];

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
        make.height.equalTo(_naviView.mas_width).multipliedBy(0.15);
    }];
    
}

#pragma mark Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_titleName resignFirstResponder];
    
    return YES;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    if(view ==_naviView || view == _imageDisplay){
        [_titleName resignFirstResponder];
    }
}

#pragma mark Action

- (void) clearText{
    
    NSArray *items = [_imageStore allItems];
    dataImageItem *item = [items lastObject];
    
    if(item){
        [_imageStore removeItem:item];
    }
    
    item = [items lastObject];
    
    NSString *title = nil;
    UIImage *image = nil;
    if(item){
        title = item.itemName;
        image = [_imageStore imageForKey:item.imageIdentification];
    }
    
    [_titleName setText:title];
    [_imageDisplay setImage:image];
    
}

- (void) takePicture:(id)sender{
    NSLog(@"Take Picture!");
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //allows Editing
    [imagePicker setAllowsEditing:YES];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"发现错误!"
                                       message:@"相机好像罢工了 _(:з」∠)_"
                                       preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"寡人知道了。" style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void) selectFromAlbum:(id)sender{
    NSLog(@"Select Picture From Album.");
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //allows Editing
    [imagePicker setAllowsEditing:YES];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"发现错误!"
                                       message:@"相册好像藏起来了 (つд⊂)"
                                       preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"寡人知道了。" style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    NSString *type = info[UIImagePickerControllerMediaType];
    
    if([type isEqual:@"public.image"]){
        UIImage *image = info[UIImagePickerControllerEditedImage];
        dataImageItem *item = [_imageStore creatItem:_titleName.text valueInDollars:arc4random()%100 serialNumber:@"IPhone"];
        [_imageStore setImage:image forKey:item.imageIdentification];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [_imageDisplay setImage:image];
    }else if([type isEqual:@"public.movie"]){
        NSURL *mediaURL = info[UIImagePickerControllerMediaURL];
        if(mediaURL){
            if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([mediaURL path])){
                UISaveVideoAtPathToSavedPhotosAlbum([mediaURL path], nil, nil, nil);
                //[[NSFileManager defaultManager] removeItemAtPath:[mediaURL path] error:nil];
            }
        }
    }else{
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
