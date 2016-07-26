//
//  JFSCSendGoodsViewController.m
//  众商智推
//
//  Created by 杨 on 16/6/14.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "JFSCSendGoodsViewController.h"
#import "MBProgressHUD+MJ.h"

@interface JFSCSendGoodsViewController ()<UITextFieldDelegate>
/**
 *姓名
 */
@property (strong, nonatomic) UITextField *nameTextField;
/**
 *电话
 */
@property (strong, nonatomic) UITextField *telephoneTextField;

/**
 *地址
 */
@property (strong, nonatomic) UITextField *adressTextField;
/**
 *保存按钮
 */
@property (strong, nonatomic) UIButton *changeGoodsBtn;

@end

@implementation JFSCSendGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    [self createHeadUI];
    [self addUserInfo];
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
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(60, 25, ScreenWidth - 110, 40)];
    titleLabel.text = @"商品兑换";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addUserInfo
{
    UILabel *adTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 50, 40)];
    adTitleLabel.text = @"姓名:";
    adTitleLabel.font = [UIFont systemFontOfSize:16];
    adTitleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:adTitleLabel];
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 100, ScreenWidth-90, 40)];
    self.nameTextField.placeholder = @"请输入您的姓名";
    self.nameTextField.delegate = self;
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.nameTextField];
    
    UILabel *telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 50, 40)];
    telephoneLabel.text = @"电话:";
    telephoneLabel.font = [UIFont systemFontOfSize:16];
    telephoneLabel.textColor = [UIColor grayColor];
    [self.view addSubview:telephoneLabel];
    
    self.telephoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 160, ScreenWidth-90, 40)];
    self.telephoneTextField.placeholder = @"请输入您的联系电话";
    self.telephoneTextField.delegate = self;
    self.telephoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.telephoneTextField];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 50, 40)];
    addressLabel.text = @"地址:";
    addressLabel.font = [UIFont systemFontOfSize:16];
    addressLabel.textColor = [UIColor grayColor];
    [self.view addSubview:addressLabel];
    
    self.adressTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 220, ScreenWidth-90, 40)];
    self.adressTextField.placeholder = @"请输入您的收获地址";
    self.adressTextField.delegate = self;
    self.adressTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.adressTextField];
    
    self.changeGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeGoodsBtn.frame = CGRectMake(10, 290, ScreenWidth-20, 50);
    self.changeGoodsBtn.backgroundColor = ZSColor(19, 143, 253);
    [self.changeGoodsBtn setTitle:@"确认兑换" forState:UIControlStateNormal];
    self.changeGoodsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.changeGoodsBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.changeGoodsBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.changeGoodsBtn addTarget:self action:@selector(changeGoodsBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    self.changeGoodsBtn.layer.cornerRadius = 5;
    self.changeGoodsBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.changeGoodsBtn];
    
}
- (void)changeGoodsBtnMethod
{
    if ((self.nameTextField.text.length == 0 || self.telephoneTextField.text.length == 0 || self.adressTextField.text.length == 0)) {
        [MBProgressHUD showError:@"姓名、电话或地址均不能为空！"];
    }else if (self.telephoneTextField.text.length != 11){
        [MBProgressHUD showError:@"请输入正确的手机号码"];
    }
    else{
        //创建面板
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示框" message:[NSString stringWithFormat:@"信息填写正确，确认兑换！"] preferredStyle:UIAlertControllerStyleAlert];
        //创建事件
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //当取消事件被触发后执行的回调操作
            NSLog(@"取消事件被触发");
        }];
        UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //当确定事件被触发后执行的回调操作
            NSLog(@"确定事件被触发");
            
            [MBProgressHUD showMessage:@"兑换成功，我们将为您尽快发货!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                [self goBack];
            });
        }];
        //把事件加载到面板上
        [alertView addAction:cancel];
        [alertView addAction:okBtn];
        [self presentViewController:alertView animated:YES completion:nil];
    }
}
#pragma mark -
#pragma mark - textField的代理事件
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
