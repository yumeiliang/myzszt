//
//  ContentViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/14.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ContentViewController.h"
//#import "Foundation/Foundation.h"

@interface ContentViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/**
 *图片按钮
 */
@property (strong, nonatomic) UIButton *imageBtn;
/**
 *新闻链接
 */
@property (strong, nonatomic) UITextField *linkTextField;
/**
 *保存按钮
 */
@property (strong, nonatomic) UIButton *saveMessageBtn;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(250, 250, 250)];
    [self createHeadUI];
    [self createContentControls];

}
#pragma mark - 创建顶部View
- (void)createHeadUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headView.backgroundColor = ZSColor(19, 143, 253);
    [self.view addSubview:headView];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //标题Label
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, 25, 80, 40)];
    titleLabel.text = @"内容提取";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createContentControls
{
    self.imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 50, 80, 100, 100)];
    [self.imageBtn setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    [self.imageBtn setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateHighlighted];
    [self.imageBtn addTarget:self action:@selector(changePicture) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.imageBtn];
    
    UILabel *selectImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 50, 180, 100, 50)];
    selectImageLabel.text = @"点击更换图片";
    selectImageLabel.textAlignment = NSTextAlignmentCenter;
    selectImageLabel.font = [UIFont systemFontOfSize:15];
    selectImageLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:selectImageLabel];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 250, 80, 40)];
    textLabel.text = @"新闻链接";
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.textColor = [UIColor blackColor];
    [self.view addSubview:textLabel];
    
    self.linkTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 295, ScreenWidth-20, 40)];
    self.linkTextField.placeholder = @"请输入以http://mp.weixin.qq.com开始的新闻链接";
    self.linkTextField.font = [UIFont systemFontOfSize:15];
    self.linkTextField.delegate = self;
    self.linkTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.linkTextField];
    
    self.saveMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveMessageBtn.frame = CGRectMake(10, 360, ScreenWidth-20, 50);
    self.saveMessageBtn.backgroundColor = ZSColor(0, 211, 100);
    [self.saveMessageBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.saveMessageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.saveMessageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.saveMessageBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.saveMessageBtn addTarget:self action:@selector(saveMessageBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    self.saveMessageBtn.layer.cornerRadius = 5;
    self.saveMessageBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.saveMessageBtn];

    
}
#pragma mark -
#pragma mark - 按钮被点击事件
- (void)changePicture
{
    UIAlertController *alertController;
    
    __block NSUInteger blockSourceType = 0;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //支持访问相机与相册情况
        alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //相册
            blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相机
            blockSourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            // 取消
            return;
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        //只支持访问相册情况
        alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相册
            blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:^{
                
            }];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // 取消
            return;
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
 
}
#pragma mark - 选择图片后,回调选择
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self.imageBtn setImage:image forState:UIControlStateNormal];
}

- (void)saveMessageBtnMethod
{
    ZSLog(@"保存按钮被点击!!");
    if ([self.linkTextField.text hasPrefix:@"http://"]) {
        [MBProgressHUD showMessage:@"正在保存！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }else if (self.linkTextField.text.length != 0) {
        [MBProgressHUD showError:@"请输入正确的格式！"];
    }else {
        [MBProgressHUD showError:@"请输入链接再进行保存！"];
    }
 

}

#pragma mark -
#pragma mark - 键盘的协议方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
