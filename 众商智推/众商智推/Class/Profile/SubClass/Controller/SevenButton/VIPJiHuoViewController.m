//
//  VIPJiHuoViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/10.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "VIPJiHuoViewController.h"

@interface VIPJiHuoViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *JiHuoMaTextField;

@property (strong, nonatomic) UIButton *successBtn;

@end

@implementation VIPJiHuoViewController

#pragma mark -
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    //顶部View
    [self createHeadUI];
    [self createContentcontrols];
    
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
    titleLabel.text = @"VIP激活码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createContentcontrols
{
    //请输入提现金额的Label
    UILabel *textlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, ScreenWidth - 20, 50)];
    textlabel.text = @"请输入激活码";
    textlabel.textAlignment = NSTextAlignmentLeft;
    textlabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textlabel];
    
    //    输入金额的view
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(5, 140, ScreenWidth - 10, 50)];
    
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    //金额
    //请输入金额的Label
    UILabel *moneylabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 40)];
    moneylabel.text = @"十六位码";
    moneylabel.textAlignment = NSTextAlignmentLeft;
    moneylabel.font = [UIFont systemFontOfSize:16];
    [contentView addSubview:moneylabel];
    
    [contentView addSubview:self.JiHuoMaTextField];
    [self.view addSubview:self.successBtn];
    
}
#pragma mark -
#pragma mark - 懒加载
- (UITextField *)JiHuoMaTextField
{
    if (!_JiHuoMaTextField) {
        _JiHuoMaTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, ScreenWidth - 110, 40)];
        _JiHuoMaTextField.delegate = self;
        _JiHuoMaTextField.borderStyle = UITextBorderStyleNone;
        _JiHuoMaTextField.font = [UIFont systemFontOfSize:16];
        _JiHuoMaTextField.placeholder = @"请输入激活码";
    }
    return _JiHuoMaTextField;
}
//完成Button
- (UIButton *)successBtn
{
    if (!_successBtn) {
        _successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _successBtn.frame = CGRectMake(10, 200, ScreenWidth-20, 50);
        _successBtn.backgroundColor = ZSColor(19, 143, 253);
        [_successBtn setTitle:@"完成" forState:UIControlStateNormal];
        _successBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _successBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//        [_successBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [_successBtn addTarget:self action:@selector(successMethod) forControlEvents:UIControlEventTouchUpInside];
        _successBtn.layer.cornerRadius = 5;
        _successBtn.layer.masksToBounds = YES;
    }
    return _successBtn;
}
#pragma mark -
#pragma mark - 完成按钮的点击事件
- (void)successMethod
{
    if (self.JiHuoMaTextField.text.length == 16) {
        //用通知传值显示改变编辑后的内容
        NSNumber *number = [[NSNumber alloc] initWithInt:1];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeinfo" object:number];
        [self goBack];
    }
    
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
