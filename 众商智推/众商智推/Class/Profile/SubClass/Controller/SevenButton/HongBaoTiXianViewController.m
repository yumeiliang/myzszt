//
//  HongBaoTiXianViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/9.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "HongBaoTiXianViewController.h"

@interface HongBaoTiXianViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *moneyTextField;

@property (strong, nonatomic) UIButton *successBtn;



@end

@implementation HongBaoTiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    //顶部返回view
    [self createHeadUI];
    //内容的控件
    [self createContentcontrols];
    
    ZSLog(@"%@",self.yuEString);
    
}

#pragma mark - 创建顶部View
- (void)createHeadUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //搜索按钮
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, 25, 80, 40)];
    titleLabel.text = @"红包提现";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
    
    //横线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 3)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = (CGRect){CGPointZero,CGSizeMake(ScreenWidth, 3)};
    //颜色分配
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor blueColor].CGColor,
                       (id)[UIColor purpleColor].CGColor,
                       (id)[UIColor redColor].CGColor
                       ,nil];
    // 颜色分割线
    gradient.locations = @[@(0.25),@(0.5),@(0.75)];
    // 起始点
    gradient.startPoint = CGPointMake(0, 0);
    // 结束点
    gradient.endPoint = CGPointMake(1, 0);
    [lineLabel.layer insertSublayer:gradient atIndex:0];
    [self.view addSubview:lineLabel];
    
}
//退出此控制器返回到上级的控制器
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createContentcontrols
{
    //请输入提现金额的Label
    UILabel *textlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, ScreenWidth - 20, 50)];
    textlabel.text = @"请输入提现金额";
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
    moneylabel.text = @"金额（元）";
    moneylabel.textAlignment = NSTextAlignmentLeft;
    moneylabel.font = [UIFont systemFontOfSize:16];
    [contentView addSubview:moneylabel];
    
    [contentView addSubview:self.moneyTextField];
    [self.view addSubview:self.successBtn];
    
}
#pragma mark -
#pragma mark - 懒加载
- (UITextField *)moneyTextField
{
    if (!_moneyTextField) {
        _moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, ScreenWidth - 110, 40)];
        _moneyTextField.delegate = self;
        _moneyTextField.borderStyle = UITextBorderStyleNone;
        _moneyTextField.font = [UIFont systemFontOfSize:16];
        _moneyTextField.keyboardType = UIKeyboardTypePhonePad;
        _moneyTextField.placeholder = @"请输入1～200之间的金额";
    }
    return _moneyTextField;
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
        [_successBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
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
    //判断输入的数据在1-200之间  且为整数
    if ([self.moneyTextField.text intValue] >= 1 && [self.moneyTextField.text intValue] <= 200) {
//        for (int i = 0; i<self.moneyTextField.text.length; i++) {
//            <#statements#>
//        }
//        if ([self.moneyTextField.text substringFromIndex:<#(NSUInteger)#>]) {
//            <#statements#>
//        }
        if ([self.moneyTextField.text intValue] <= [self.yuEString intValue]) {
            //通知的响应方法
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeMoney" object:self.moneyTextField.text];
            [self goBack];
        } else {
             [MBProgressHUD showError:@"您的账户余额不足"];
            self.moneyTextField.text = nil;
        }
    } else {
          [MBProgressHUD showError:@"请输入金额在1-200之间"];
        self.moneyTextField.text = nil;
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
