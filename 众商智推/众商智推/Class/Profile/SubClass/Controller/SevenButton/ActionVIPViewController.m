//
//  ActionVIPViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/14.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ActionVIPViewController.h"
#import "ZaiXianZhiFuViewController.h"
#import "VIPJiHuoViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ActionVIPViewController ()

//激活VIP的提示语Label
@property (strong, nonatomic) UILabel *textLabel;
//在线支付
@property (strong, nonatomic) UIButton *zaiXianZFBtn;
//VIP激活码
@property (strong, nonatomic) UIButton *VIPJiHuoBtn;
//暂不激活
@property (strong, nonatomic) UIButton *zanBuJiHuoBtn;

@end

@implementation ActionVIPViewController
#pragma mark -
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    [self createHeadUI];
    
//    获取沙盒中存取的数据信息
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"yesOrNoPayMoney.txt"];//当前应用的沙盒路径
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSString *string = [array objectAtIndex:0];
    
    if ([string isEqualToString:@"已支付399元"]) {
        [self removeControls];
        [self createHeadUI];
    }else{
        //创建二个View
        [self createViewHeight:75 andImage:[UIImage imageNamed:@"v-red"] andTitle:@" 在线支付  " andButtonClickEventName:@selector(weiNameButtonClickEvent)];
        [self createViewHeight:152 andImage:[UIImage imageNamed:@"v-yellow"] andTitle:@"VIP激活码" andButtonClickEventName:@selector(ADsButtonClickEvent)];
    }
    //通知传值 注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getchangeinfo:) name:@"changeinfo" object:nil];
}

#pragma mark -
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
    titleLabel.text = @"激活VIP";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark - 通知的方法
-(void)getchangeinfo:(NSNotification*)notification
{
    if ([notification.object isKindOfClass:[NSNumber class]]) {
        
        [self removeControls];
    }
}

- (void)removeControls
{
      //移除多余的视图
    for (int i = 0; i < self.view.subviews.count; i ++) {
        UIView *tempView = (UIView *)self.view.subviews.lastObject;
        [tempView removeFromSuperview];
    }    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, ScreenWidth - 40, 50)];
    textLabel.text = @"您已激活VIP";
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont boldSystemFontOfSize:20];
    textLabel.textColor = [UIColor blackColor];
    [self.view addSubview:textLabel];
}
#pragma mark -
#pragma mark - 二个view
- (void)createViewHeight:(NSUInteger)height andImage:(UIImage*)image andTitle:(NSString*)title andButtonClickEventName:(SEL)buttonClickEventName
{
    UIView *ADView = [[UIView alloc] initWithFrame:CGRectMake(0, height, ScreenWidth, 65)];
    ADView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ADView];
    
    UIButton *ADBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ADBtn.frame = CGRectMake(15, 8, 160, 50);
    [ADBtn setImage:image forState:UIControlStateNormal];
    [ADBtn setTitle:title forState:UIControlStateNormal];
    [ADBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ADBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    ADBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [ADView addSubview:ADBtn];
    
    UIButton *ADRightExtenionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ADRightExtenionBtn.frame = CGRectMake(ScreenWidth - 40, 12, 30, 30);
    [ADRightExtenionBtn setImage:[UIImage imageNamed:@"rightExtension.png"] forState:UIControlStateNormal];
    [ADView addSubview:ADRightExtenionBtn];
    
    UIButton *btnclickEvent = [UIButton buttonWithType:UIButtonTypeCustom];
    btnclickEvent.frame = CGRectMake(0, 0, ScreenWidth, 55);
    btnclickEvent.backgroundColor = [UIColor clearColor];
    [btnclickEvent addTarget:self action:buttonClickEventName forControlEvents:UIControlEventTouchUpInside];
    [ADView addSubview:btnclickEvent];
}
#pragma mark -
#pragma mark - 按钮的点击事件
- (void)weiNameButtonClickEvent
{
    ZaiXianZhiFuViewController *popularizeVC = [[ZaiXianZhiFuViewController alloc] init];
    [self presentViewController:popularizeVC animated:YES completion:nil];
    
}
- (void)ADsButtonClickEvent
{
    VIPJiHuoViewController *articleListVC = [[VIPJiHuoViewController alloc] init];
    [self presentViewController:articleListVC animated:YES completion:nil];
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
