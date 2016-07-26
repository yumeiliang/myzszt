//
//  ZaiXianZhiFuViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/10.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ZaiXianZhiFuViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ZaiXianZhiFuViewController ()<UIAlertViewDelegate>

//立即支付按钮
@property (strong, nonatomic) UIButton *payMoneyBtn;

@property (strong, nonatomic) NSMutableArray *saveArray;

@end

@implementation ZaiXianZhiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(233, 233, 233)];
    //顶部View
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
    titleLabel.text = @"在线激活";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createContentControls
{
    UILabel *vipLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 40, 80, 80, 30)];
    vipLabel.text = @"激活VIP";
//    vipLabel.backgroundColor = [UIColor cyanColor];
    vipLabel.textAlignment = NSTextAlignmentCenter;
    vipLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:vipLabel];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 100, 100, 200, 80)];
    moneyLabel.text = @"￥399.00";
//    moneyLabel.backgroundColor = [UIColor orangeColor];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:moneyLabel];
    
//    收款方
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 190, ScreenWidth-20, 50)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = 5;
    view1.layer.masksToBounds = YES;
    [self.view addSubview:view1];
    
    UILabel *collectMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, 40)];
    collectMoneyLabel.text = @"收款方";
    collectMoneyLabel.textColor = [UIColor lightGrayColor];
    collectMoneyLabel.textAlignment = NSTextAlignmentLeft;
    collectMoneyLabel.font = [UIFont systemFontOfSize:15];
    [view1 addSubview:collectMoneyLabel];
    
    UILabel *putMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(view1.frame.size.width-130, 5, 125, 40)];
    putMoneyLabel.text = @"众商智推";
    putMoneyLabel.textAlignment = NSTextAlignmentRight;
    putMoneyLabel.font = [UIFont systemFontOfSize:15];
    [view1 addSubview:putMoneyLabel];
//    支付方式
    UILabel *payTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 250, 70, 40)];
    payTypeLabel.text = @"支付方式";
    collectMoneyLabel.textColor = [UIColor lightGrayColor];
    collectMoneyLabel.textAlignment = NSTextAlignmentLeft;
    payTypeLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:payTypeLabel];
    
    //支付方式的view
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(10, 300, ScreenWidth-20, 100)];
    view2.backgroundColor = [UIColor whiteColor];
    view2.layer.cornerRadius = 5;
    view2.layer.masksToBounds = YES;
    [self.view addSubview:view2];

    //付款方式1-使用零钱支付
    UILabel *payType1Label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 40)];
    payType1Label.text = @"使用零钱支付";
//    payType1Label.textColor = [UIColor blackColor];
    payType1Label.textAlignment = NSTextAlignmentLeft;
    payType1Label.font = [UIFont systemFontOfSize:15];
    [view2 addSubview:payType1Label];
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(view2.frame.size.width-50, 5, 40, 40);
    [selectBtn setImage:[UIImage imageNamed:@"selectBtn"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"selectBtn"] forState:UIControlStateSelected];
    [view2 addSubview:selectBtn];
    
    UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(10, 50, view2.frame.size.width-20, 1)];
    lineview.backgroundColor = [UIColor lightGrayColor];
    [view2 addSubview:lineview];
    
    //付款方式2-添加银行卡支付
    UILabel *payType2Label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 120, 40)];
    payType2Label.text = @"添加银行卡支付";
    payType2Label.textAlignment = NSTextAlignmentLeft;
    payType2Label.font = [UIFont systemFontOfSize:15];
    [view2 addSubview:payType2Label];

    self.payMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.payMoneyBtn.frame = CGRectMake(10, 430, ScreenWidth-20, 40);
    [self.payMoneyBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.payMoneyBtn setBackgroundColor:ZSColor(0, 211, 100)];
    [self.payMoneyBtn addTarget:self action:@selector(saveInformationMethod) forControlEvents:UIControlEventTouchUpInside];
    self.payMoneyBtn.layer.cornerRadius = 5;
    self.payMoneyBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.payMoneyBtn];
    
}
-(void)saveInformationMethod
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统将扣除您399.00元" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles:@"取消", nil];
    
    [alert show];
    
}
#pragma mark - 警示框代理方法

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [MBProgressHUD showSuccess:@"支付成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //把数据存到沙盒中
                NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"yesOrNoPayMoney.txt"];//当前应用的沙盒路径
                self.saveArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];//将沙盒路径下的归档对象解档出来
                if (self.saveArray == nil) {
                    self.saveArray = [NSMutableArray array];
                }
                
                NSString *str = @"已支付399元";
                [self.saveArray insertObject:str atIndex:0];
                //把刚才写的数组存到沙盒当中去
                if ([NSKeyedArchiver archiveRootObject:self.saveArray toFile:path]) {
                    ZSLog(@"信息保存成功");
                    //            [self goBack];
                }else{
                    ZSLog(@"信息保存失败");
                }
                ZSLog(@"%@",path);
                [self goBack];
            });
            //用通知传值显示改变编辑后的内容
            NSNumber *number = [[NSNumber alloc] initWithInt:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeinfo" object:number];

        }
            break;
        case 1:
        {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD hideHUD];
//                [self goBack];
//            });
        }
            break;
        default:
            break;
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
