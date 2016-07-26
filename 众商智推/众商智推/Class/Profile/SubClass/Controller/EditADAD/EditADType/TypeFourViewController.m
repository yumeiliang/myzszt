//
//  TypeFourViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/27.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "TypeFourViewController.h"

@interface TypeFourViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
/**
 *标题
 */
@property (strong, nonatomic) UITextField *adTitleTextField;
/**
 *简介
 */
@property (strong, nonatomic) UITextField *adIntroductionTextField;

/**
 *广告链接
 */
@property (strong, nonatomic) UITextField *linkTextField;
/**
 *保存按钮
 */
@property (strong, nonatomic) UIButton *saveMessageBtn;


@end

@implementation TypeFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
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
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //标题按钮
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-60, 25, 120, 40)];
    titleLabel.text = @"广告类型4";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
//退出此控制器返回到上级的控制器
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createContentControls
{
    //上传图片
    UIView *pictureView = [[UIView alloc] initWithFrame:CGRectMake(10, 80, ScreenWidth-20, 85)];
    pictureView.backgroundColor = [UIColor whiteColor];
    pictureView.layer.cornerRadius = 5;
    pictureView.layer.masksToBounds = YES;
    [self.view addSubview:pictureView];
    
    UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pictureBtn.frame = CGRectMake(15, 12, 60, 60);
    pictureBtn.backgroundColor = [UIColor grayColor];
    pictureBtn.layer.cornerRadius = 30;
    pictureBtn.layer.masksToBounds = YES;
    [pictureView addSubview:pictureBtn];
    
    UIButton *uploadpictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadpictureBtn.frame = CGRectMake(ScreenWidth - 280, 20, 260, 50);
    //    uploadQrCodeBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:211/255.0 blue:100/255.0 alpha:1];
    [uploadpictureBtn setTitle:@"上传图片(120px*120px)" forState:UIControlStateNormal];
    [uploadpictureBtn setImage:[UIImage imageNamed:@"rightExtension.png"] forState:UIControlStateNormal];
    uploadpictureBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 240, 0, 0);
    uploadpictureBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
    [uploadpictureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    [uploadQrCodeBtn addTarget:self action:@selector(saveMessageBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [pictureView addSubview:uploadpictureBtn];
    //二维码
    UIView *qrCodeView = [[UIView alloc] initWithFrame:CGRectMake(10, 180, ScreenWidth-20, 85)];
    qrCodeView.backgroundColor = [UIColor whiteColor];
    qrCodeView.layer.cornerRadius = 5;
    qrCodeView.layer.masksToBounds = YES;
    [self.view addSubview:qrCodeView];
    
    UIButton *qrCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qrCodeBtn.frame = CGRectMake(15, 12, 60, 60);
    qrCodeBtn.backgroundColor = [UIColor grayColor];
    [qrCodeView addSubview:qrCodeBtn];
    
    UIButton *uploadQrCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadQrCodeBtn.frame = CGRectMake(ScreenWidth - 280, 20, 260, 50);
    //    uploadQrCodeBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:211/255.0 blue:100/255.0 alpha:1];
    [uploadQrCodeBtn setTitle:@"上传二维码(420px*420px)" forState:UIControlStateNormal];
    [uploadQrCodeBtn setImage:[UIImage imageNamed:@"rightExtension.png"] forState:UIControlStateNormal];
    uploadQrCodeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 240, 0, 0);
    uploadQrCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
    [uploadQrCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    [uploadQrCodeBtn addTarget:self action:@selector(saveMessageBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [qrCodeView addSubview:uploadQrCodeBtn];

    UILabel *adLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 275, 100, 40)];
    adLabel.text = @"广告语";
    adLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:adLabel];
    
    UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(10, 325, ScreenWidth-20, 110)];
    adView.backgroundColor = [UIColor whiteColor];
    adView.layer.cornerRadius = 5;
    adView.layer.masksToBounds = YES;
    [self.view addSubview:adView];
    
    UILabel *adTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 40)];
    adTitleLabel.text = @"标题:";
    adTitleLabel.font = [UIFont systemFontOfSize:16];
    adTitleLabel.textColor = [UIColor grayColor];
    [adView addSubview:adTitleLabel];
    self.adTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10, ScreenWidth-90, 40)];
    self.adTitleTextField.placeholder = @"请输入广告标题";
    self.adTitleTextField.delegate = self;
    self.adTitleTextField.borderStyle = UITextBorderStyleRoundedRect;
    [adView addSubview:self.adTitleTextField];
    
    UILabel *adIntroductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 50, 40)];
    adIntroductionLabel.text = @"简介:";
    adIntroductionLabel.font = [UIFont systemFontOfSize:16];
    adIntroductionLabel.textColor = [UIColor grayColor];
    [adView addSubview:adIntroductionLabel];
    self.adIntroductionTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 60, ScreenWidth-90, 40)];
    self.adIntroductionTextField.placeholder = @"请输入广告简介(限30字)";
    self.adIntroductionTextField.delegate = self;
    self.adIntroductionTextField.borderStyle = UITextBorderStyleRoundedRect;
    [adView addSubview:self.adIntroductionTextField];
    
    UILabel *linkLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 445, 100, 40)];
    linkLabel.text = @"广告链接";
    linkLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:linkLabel];
    
    self.linkTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 495, ScreenWidth-20, 60)];
    self.linkTextField.placeholder = @"请输入您的广告链接，网址请加http://";
    self.linkTextField.delegate = self;
    self.linkTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.linkTextField];
    
    self.saveMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        _saveBtn.frame = CGRectMake(10, 500, ScreenWidth-20, 50);
    self.saveMessageBtn.frame = CGRectMake(10, 565, ScreenWidth-20, 50);
    self.saveMessageBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:211/255.0 blue:100/255.0 alpha:1];
    [self.saveMessageBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.saveMessageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.saveMessageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.saveMessageBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.saveMessageBtn addTarget:self action:@selector(saveMessageBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    self.saveMessageBtn.layer.cornerRadius = 5;
    self.saveMessageBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.saveMessageBtn];
    
}

- (void)saveMessageBtnMethod
{
    ZSLog(@"保存按钮被点击!!");
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //上下文动画内，改变当前视图坐标
    [UIView beginAnimations:@"text" context:nil];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    rect.origin.y = -210;
    self.view.frame = rect;
    
    [UIView commitAnimations];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"text" context:nil];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    self.view.frame = rect;
    
    [UIView commitAnimations];
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
