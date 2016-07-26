//
//  MoneyViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/14.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "MoneyViewController.h"
#import "MoneyTableViewCell.h"
#import "HongBaoTiXianViewController.h"
#import "EditPIDataModel.h"

@interface MoneyViewController ()<UITableViewDelegate,UITableViewDataSource>

//显示钱的多少的Label
@property (strong, nonatomic) UILabel *moneyLabel;
//余额明细的tableview
@property (strong, nonatomic) UITableView *YuEMXTableView;
//显示积分的多少的Label
@property (strong, nonatomic) UILabel *integralLabel;
//存取的数据模型
@property (strong, nonatomic) EditPIDataModel *editPIDataModel;
//保存money的数组
@property (strong, nonatomic)  NSMutableArray *saveArray;

@end

@implementation MoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    //通知传值 注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSecrt:) name:@"changeMoney" object:nil];
//    
    //获取沙盒中存取的数据信息
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"restMoney.txt"];//当前应用的沙盒路径
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    self.editPIDataModel = [array objectAtIndex:0];
    
    //顶部的返回view
    [self createHeadUI];
    //内容的控件
    [self createContent];
   
}

#pragma mark -
#pragma mark - 通知的方法
-(void)getSecrt:(NSNotification*)notification
{
    //把余额存到沙盒中
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"restMoney.txt"];//当前应用的沙盒路径
    self.saveArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];//将沙盒路径下的归档对象解档出来
    if (self.saveArray == nil) {
        self.saveArray = [NSMutableArray array];
    }
     EditPIDataModel *model = [[EditPIDataModel alloc] init];
    ZSLog(@"MoneyViewController.m余额保存的地址-----%@",path);
    NSString *money = self.moneyLabel.text;
    double oldMoney = [money doubleValue];
    if ([notification.object isKindOfClass:[NSString class]]) {
        double newMoney = [notification.object intValue];
//        self.moneyLabel.text = [NSString stringWithFormat:@"%.2f", oldMoney - newMoney];
        NSString *moneyStr = [NSString stringWithFormat:@"%.2f", oldMoney - newMoney];
        if ([moneyStr doubleValue] >= 0.0 ) {
            self.moneyLabel.text = moneyStr;
        }
        model.oldMoneyString = self.moneyLabel.text;
       [self.saveArray insertObject:model atIndex:0];
    }
    //把刚才写的数组存到沙盒当中去
    if ([NSKeyedArchiver archiveRootObject:self.saveArray toFile:path]) {
        ZSLog(@"信息保存成功");
        //        [self changeEnable];
        [self goBack];
    }else{
        ZSLog(@"信息保存失败");
    }
    
    ZSLog(@"%@",path);
    
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
    
    //标题按钮
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, 25, 80, 40)];
    titleLabel.text = @"余额明细";
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

#pragma mark -
#pragma mark - 内容的
- (void)createContent
{
    //余额钱数Label
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 100, 90, 200, 40)];
    if (self.editPIDataModel.oldMoneyString.length) {
        if ([self.editPIDataModel.oldMoneyString doubleValue] >= 0.0) {
            self.moneyLabel.text = self.editPIDataModel.oldMoneyString;
        }else {
            self.moneyLabel.text = @"0.0";
        }
    }
//    //如果沙盒中存储与输入的值相同的模型，则做出相应操作之后，跳出整个函数
//    if (self.editPIDataModel.oldMoneyString.length) {
//        self.moneyLabel.text = self.editPIDataModel.oldMoneyString;
//    }
    else
    {
        self.moneyLabel.text = @"222.22";
    }
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.moneyLabel];
    //我的余额汉字Label
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 40, 130, 80, 30)];
    textLabel.text = @"我的余额";
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textLabel];
    
    //积分Label
    self.integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 100, 170, 200, 40)];
    self.integralLabel.textAlignment = NSTextAlignmentCenter;
    self.integralLabel.font = [UIFont systemFontOfSize:20];
    self.integralLabel.text = @"222.22";
    [self.view addSubview:self.integralLabel];
    
    //我的积分汉字Label
    UILabel *textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 40, 210, 80, 30)];
    textLabel2.text = @"我的积分";
    textLabel2.textAlignment = NSTextAlignmentCenter;
    textLabel2.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textLabel2];
    
    UIButton *hongBaoTXBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hongBaoTXBtn.frame = CGRectMake(10, 260, ScreenWidth-20, 45);
    [hongBaoTXBtn setTitle:@"红包提现" forState:UIControlStateNormal];
    [hongBaoTXBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    hongBaoTXBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [hongBaoTXBtn setBackgroundColor:ZSColor(19, 143, 253)];
    hongBaoTXBtn.layer.cornerRadius = 5;
    hongBaoTXBtn.layer.masksToBounds = YES;
    [hongBaoTXBtn addTarget:self action:@selector(hongBaoTXBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hongBaoTXBtn];
    
    UIButton *yuEMXBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yuEMXBtn.frame = CGRectMake(10, 315, ScreenWidth-20, 45);
    [yuEMXBtn setTitle:@"余额明细" forState:UIControlStateNormal];
    [yuEMXBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    yuEMXBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [yuEMXBtn setBackgroundColor:ZSColor(19, 143, 253)];
    yuEMXBtn.layer.cornerRadius = 5;
    yuEMXBtn.layer.masksToBounds = YES;
    [yuEMXBtn addTarget:self action:@selector(yuEMXBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yuEMXBtn];
    
}
//红包体现的点击事件
- (void)hongBaoTXBtnClick
{
    ZSLog(@"hongBaoTXBtnClick");
    HongBaoTiXianViewController *hongBaoTiXianVC = [[HongBaoTiXianViewController alloc] init];
    if (self.editPIDataModel.oldMoneyString) {
        hongBaoTiXianVC.yuEString = self.editPIDataModel.oldMoneyString;
    } else {
        hongBaoTiXianVC.yuEString = self.moneyLabel.text;
    }
    [self presentViewController:hongBaoTiXianVC animated:YES completion:nil];
}
//余额明细的点击事件
- (void)yuEMXBtnClick
{
    ZSLog(@"yuEMXBtnClick");
    [self.view addSubview:self.YuEMXTableView];
}

#pragma mark -
#pragma mark - tableView的代理数据源方法  UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    MoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier cellWidth:ScreenWidth];
    }
    cell.timeLabel.text = @"2016-06-09";
    cell.taskMoneyLabel.text = @"任务获取0.1";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//头标题
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"已加载全部"];
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
//点击事件的响应方法
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

#pragma mark -
#pragma mark - 懒加载
- (UITableView *)YuEMXTableView
{
    if (!_YuEMXTableView) {
        _YuEMXTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 370, ScreenWidth - 10, ScreenHeight - 370)];
        _YuEMXTableView.delegate = self;
        _YuEMXTableView.dataSource = self;
        _YuEMXTableView.backgroundColor = [UIColor clearColor];
    }
    return _YuEMXTableView;
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
