//
//  EditADWeiNameViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/11.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "EditADWeiNameViewController.h"
//编辑个人信息
#import "EditPersonalinformationViewController.h"
#import "PreviewViewController.h"

@interface EditADWeiNameViewController ()

//headView
@property (strong, nonatomic) UIView *headView;

//头像
@property (strong, nonatomic) UIButton *iconBtn;
//昵称
@property (strong, nonatomic) UILabel *nameLabel;
//公司
@property (strong, nonatomic) UILabel *companyLabel;
//职务
@property (strong, nonatomic) UILabel *jobLabel;
//关注
@property (strong, nonatomic) UIButton *concernBtn;
//编辑
@property (strong, nonatomic) UIButton *editPIBtn;
//预览
@property (strong, nonatomic) UIButton *previewBtn;
//分享提示Label
@property (strong, nonatomic) UILabel *textLabel;

@end

@implementation EditADWeiNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"profileBackImage.png"]]];
    [self createHeadUI];
    
    //headView
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.iconBtn];
    [self.headView addSubview:self.nameLabel];
    [self.headView addSubview:self.companyLabel];
    [self.headView addSubview:self.jobLabel];
    [self.headView addSubview:self.concernBtn];
    
    [self.view addSubview:self.editPIBtn];
    [self.view addSubview:self.previewBtn];
    [self.view addSubview:self.textLabel];

    
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
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, 25, 80, 40)];
    titleLabel.text = @"我的名片";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
//退出此控制器返回到上级的控制器
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - btn的方法实现
//编辑个人信息按钮的实现方法
- (void)editPIBtnClick
{
    EditPersonalinformationViewController *editPIVC = [[EditPersonalinformationViewController alloc] init];
    [self presentViewController:editPIVC animated:YES completion:nil];
}
//预览按钮的实现方法
- (void)previewBtnClick
{
    PreviewViewController *previewVC = [[PreviewViewController alloc] init];
    [self presentViewController:previewVC animated:YES completion:nil];
}

#pragma mark -
#pragma mark - 懒加载
//头部的view
- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(10, 85, ScreenWidth - 20, 90)];
        _headView.backgroundColor = [UIColor whiteColor];
        _headView.layer.cornerRadius = 10;
        _headView.layer.masksToBounds = YES;
    }
    return _headView;
}
//头像按钮Btn
- (UIButton *)iconBtn
{
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconBtn.frame = CGRectMake(10, 10, 75, 75);
        _iconBtn.backgroundColor = [UIColor clearColor];
        _iconBtn.layer.cornerRadius = 38;
        _iconBtn.layer.masksToBounds = YES;
        
        //加载首先访问本地沙盒是否存在相关图片
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];
        if (!savedImage)
        {
            //默认头像
            [_iconBtn setImage:[UIImage imageNamed:@"flower.png"] forState:UIControlStateNormal];
        }
        else
        {
            [_iconBtn setImage:savedImage forState:UIControlStateNormal];
        }
    }
    return _iconBtn;
}
//昵称Label
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 30)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.text = @"昵称";
        //        _nameLabel.textColor= [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    return _nameLabel;
}
//公司Label
- (UILabel *)companyLabel
{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 55, 100, 25)];
        _companyLabel.backgroundColor = [UIColor clearColor];
        _companyLabel.text = @"公司:";
        _companyLabel.font = [UIFont systemFontOfSize:15];
        _companyLabel.textColor = [UIColor lightGrayColor];
    }
    return _companyLabel;
}
//职务Label
- (UILabel *)jobLabel
{
    if (!_jobLabel) {
        _jobLabel = [[UILabel alloc] initWithFrame:CGRectMake(205, 55, 140, 25)];
        _jobLabel.backgroundColor = [UIColor clearColor];
        _jobLabel.text = @"职务:";
        _jobLabel.font = [UIFont systemFontOfSize:15];
        _jobLabel.textColor = [UIColor lightGrayColor];
    }
    return _jobLabel;
}
//关注Btn
- (UIButton *)concernBtn
{
    if (!_concernBtn) {
        _concernBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _concernBtn.frame = CGRectMake(self.headView.frame.size.width- 90, 15, 80, 25);
        _concernBtn.backgroundColor = [UIColor clearColor];
        [_concernBtn setImage:[UIImage imageNamed:@"guanzhu.png"] forState:UIControlStateNormal];
        [_concernBtn setTitle:@"关注0" forState:UIControlStateNormal];
        [_concernBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _concernBtn;
}
//编辑个人信息的按钮Btn
- (UIButton *)editPIBtn
{
    if (!_editPIBtn) {
        _editPIBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editPIBtn.frame = CGRectMake(10, 200, (ScreenWidth-30)/2, 50);
        _editPIBtn.backgroundColor = [UIColor whiteColor];
        [_editPIBtn setImage:[UIImage imageNamed:@"editImage.png"] forState:UIControlStateNormal];
        [_editPIBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editPIBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_editPIBtn addTarget:self action:@selector(editPIBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _editPIBtn.layer.cornerRadius = 10;
        _editPIBtn.layer.masksToBounds = YES;
        
    }
    return _editPIBtn;
}
//预览按钮Btn
- (UIButton *)previewBtn
{
    if (!_previewBtn) {
        _previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _previewBtn.frame = CGRectMake((ScreenWidth-30)/2 + 20, 200, (ScreenWidth-30)/2, 50);
        _previewBtn.backgroundColor = [UIColor whiteColor];
        [_previewBtn setImage:[UIImage imageNamed:@"previewImage.png"] forState:UIControlStateNormal];
        [_previewBtn setTitle:@"预览" forState:UIControlStateNormal];
        [_previewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_previewBtn addTarget:self action:@selector(previewBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _previewBtn.layer.cornerRadius = 10;
        _previewBtn.layer.masksToBounds = YES;
        
    }
    return _previewBtn;
}
//分享提示Label
- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 120, 260, 240, 30)];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.text = @"分享名片请点击预览后再进行分享";
        _textLabel.textColor= [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:15];
    }
    return _textLabel;
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
