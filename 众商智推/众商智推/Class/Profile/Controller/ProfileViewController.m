//
//  ProfileViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/8.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ProfileViewController.h"
//编辑个人信息
#import "EditPersonalinformationViewController.h"
#import "PreviewViewController.h"
#import "EditPIDataModel.h"
#import "LoginViewController.h"
#import "SettingViewController.h"
//编辑AD
#import "EditADViewController.h"

#import "MoneyViewController.h"
#import "SelectViewController.h"
#import "ContentViewController.h"
#import "TaskMyViewController.h"
//#import "ListViewController.h"
//排行榜换成任务的文章排行榜
#import "StatisticArticleListViewController.h"
#import "ActionVIPViewController.h"
#import "StatisticViewController.h"
//第三方登陆的头像和昵称
#import "UserInfoModel.h"
#import "UIImageView+WebCache.h"

#import "MoreItem.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource,DeleteUserInfoPathDelegate>

//微明片
@property (strong, nonatomic) UILabel *weiNameLabel;

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

//登录之前的提示语
@property (strong, nonatomic) UILabel *tipLabel;

//接收value
//@property (strong, nonatomic) EditDataModel *editDataModelValue;

//表格
@property (strong, nonatomic) UITableView *profileTableView;

//数据数组
@property (strong, nonatomic) NSMutableArray *dataSourceArray;

@property (strong, nonatomic) LoginViewController *loginVC;

//阴影按钮
@property (strong, nonatomic) UIButton *coverBtn;


@end

@implementation ProfileViewController

+ (ProfileViewController *)share
{
    static ProfileViewController *tempcontroller =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tempcontroller = [[ProfileViewController alloc] init];
    });
    return tempcontroller;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //背景图片
    [self.view setBackgroundColor:ZSColor(239, 239, 244)];
    //    创建UI
    [self createUI];
//    self.coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.coverBtn.frame = [UIScreen mainScreen].bounds;
//    self.coverBtn.backgroundColor = [UIColor blackColor];
//    //        self.coverBtn.alpha = 0.6;
//    [self.coverBtn addTarget:self action:@selector(removeSelfAndLoginVC) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.coverBtn];
//    [self.view bringSubviewToFront:self.coverBtn];
    
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    lab.text = @"11111111111111111111111111";
//    [self.view addSubview:lab];
    
    
}
#pragma mark - 创建UI
- (void)createUI
{
    //整体滑动的scrollView
    //    [self.view addSubview:self.allScrollView];
    //微名片
    [self.view addSubview:self.weiNameLabel];
    //headView
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.iconBtn];
    [self.headView addSubview:self.nameLabel];
    [self.headView addSubview:self.companyLabel];
    [self.headView addSubview:self.jobLabel];
    [self.headView addSubview:self.concernBtn];
    [self.headView addSubview:self.tipLabel];
    
    //加载表格视图
    [self.view addSubview:self.profileTableView];
    
    [self getEditChangeValue];
    
    //通知传值 改变用户编辑的信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue:) name:@"passValue1" object:nil];
    
}
#pragma mark -
#pragma mark - 取出沙盒中存取的数据
- (void)getEditChangeValue
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"regist.txt"];//当前应用的沙盒路径
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    EditPIDataModel *model = [array objectAtIndex:0];
    
    //    for (EditDataModel *model in array) {
    
    //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
    if (model.nameString.length && model.jobString.length && model.companyString.length) {
        //        self.nameLabel.text = model.nameString;
        self.jobLabel.text = [NSString stringWithFormat:@"职务:%@",model.jobString];
        self.companyLabel.text = [NSString stringWithFormat:@"公司:%@",model.companyString];
        
        //打印输入的所有信息
        ZSLog(@"用户输入的所有信息ProFileViewController.m\n姓名：%@\n移动电话：%@\n职位：%@\n单位名称：%@\nQQ：%@\n电子邮箱：%@\n微信账号：%@\n详细地址：%@\n我专注：%@\n我在找：%@\n所剩金额：%@",model.nameString,model.telephoneString,model.jobString,model.companyString,model.qqString,model.emailString,model.WXAccountString,model.addressString,model.focusString,model.findString,model.oldMoneyString);
        
        //保存路径
        ZSLog(@"%@",path);
    }
    //    }
    
    //三方登录的头像和昵称
    NSString *userInfoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.txt"];//当前应用的沙盒路径
    NSMutableArray *userInfoArray = [NSKeyedUnarchiver unarchiveObjectWithFile:userInfoPath];
    UserInfoModel *userInfoModel = [userInfoArray objectAtIndex:0];
    if (!userInfoModel.iconUrlStr) {
        [_iconBtn setImage:[UIImage imageNamed:@"head_default.png"] forState:UIControlStateNormal];
//        self.iconBtn.hidden = YES;
        self.nameLabel.hidden = YES;
        self.companyLabel.hidden = YES;
        self.jobLabel.hidden = YES;
        self.concernBtn.hidden = YES;
        self.tipLabel.hidden = NO;
        
    } else {
        [_iconBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userInfoModel.iconUrlStr]]] forState:UIControlStateNormal];
        _nameLabel.text = userInfoModel.userNameStr;
        self.nameLabel.hidden = NO;
        self.companyLabel.hidden = NO;
        self.jobLabel.hidden = NO;
        self.concernBtn.hidden = NO;
        self.tipLabel.hidden = YES;
        
        [self.coverBtn removeFromSuperview];
        [self.loginVC removeFromParentViewController];
        
        //改完头像和昵称之后移除登录的按钮
        //        [self.loginButton removeFromSuperview];
    }
    
    /*
     //用户自己修改头像以后保存的
     [_iconBtn sd_setImageWithURL:[NSURL URLWithString:userInfoModel.iconUrlStr] placeholderImage:[UIImage imageNamed:@"1"]];
     
     加载首先访问本地沙盒是否存在相关图片
     NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
     UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];
     
     if (!savedImage)
     {
     //默认头像
     [_iconBtn setImage:[UIImage imageNamed:@"head_default.png"] forState:UIControlStateNormal];
     }
     else
     {
     [_iconBtn setImage:savedImage forState:UIControlStateNormal];
     }
     */
    
    
    //    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"allImage.txt"];//当前应用的沙盒路径
    //    NSMutableArray *imageArray = [NSKeyedUnarchiver unarchiveObjectWithFile:imagePath];
    //    [self.iconBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[imageArray objectAtIndex:0]]] forState:UIControlStateNormal];
    
    
    
}

#pragma -UITableViewDataSource,UITableViewDelegate的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSourceArray objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    MoreItem *item = [[self.dataSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:item.icon];
    cell.textLabel.text = item.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //表格加载数据
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MoreItem *item = [[self.dataSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UIViewController *vc = [[item.vcClass alloc] init];
    [self presentViewController:vc animated:YES completion:nil];

}
//标题高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
//题尾高
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

#pragma mark -
#pragma mark - 通知的方法
-(void)changeValue:(NSNotification*)notification
{
    //1
    if ([notification.object isKindOfClass:[NSNumber class]]) {
        
        [self getEditChangeValue];
    }
    
}
#pragma mark -
#pragma mark - 懒加载
//微明片的label
- (UILabel *)weiNameLabel
{
    if (!_weiNameLabel) {
        _weiNameLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth/2)-60, 25, 120, 50)];
        //    label.backgroundColor = [UIColor orangeColor];
        _weiNameLabel.text = @"微名片";
        _weiNameLabel.textColor = [UIColor blackColor];
        _weiNameLabel.font = [UIFont boldSystemFontOfSize:20];
        _weiNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _weiNameLabel;
}
//头部的view
- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, ScreenWidth, 90)];
        _headView.backgroundColor = [UIColor whiteColor];
//        _headView.layer.cornerRadius = 10;
//        _headView.layer.masksToBounds = YES;
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
        [_iconBtn addTarget:self action:@selector(iconBtnBeClick) forControlEvents:UIControlEventTouchUpInside];
        
        //        //加载首先访问本地沙盒是否存在相关图片
        //        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        //        UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];
        //        if (!savedImage)
        //        {
        //            //默认头像
        //            [_iconBtn setImage:[UIImage imageNamed:@"head_default.png"] forState:UIControlStateNormal];
        //        }
        //        else
        //        {
        //            [_iconBtn setImage:savedImage forState:UIControlStateNormal];
        //        }
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
        [_concernBtn setTitle:@"关注9" forState:UIControlStateNormal];
        [_concernBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _concernBtn;
}
//表格
- (UITableView *)profileTableView
{
    if (!_profileTableView) {
        _profileTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 175, ScreenWidth, ScreenHeight-225) style:UITableViewStyleGrouped];
        _profileTableView.delegate = self;
        _profileTableView.dataSource = self;
        _profileTableView.rowHeight = 60;
    }
    return _profileTableView;
}
//昵称Label
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 200, 30)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.text = @"亲，请点击头像进行登录";
        _tipLabel.textAlignment = NSTextAlignmentLeft;
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}


- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
        
        MoreItem *item0 = [MoreItem itemWithIcon:@"setting" title:@"设置" vcClass:[SettingViewController class]];
        MoreItem *item1 = [MoreItem itemWithIcon:@"vv" title:@"预览" vcClass:[PreviewViewController class]];
        MoreItem *item2 = [MoreItem itemWithIcon:@"vv" title:@"广告编辑" vcClass:[EditADViewController class]];
        
        MoreItem *item3 = [MoreItem itemWithIcon:@"moneyImage" title:@"余额明细" vcClass:[MoneyViewController class]];
        MoreItem *item4 = [MoreItem itemWithIcon:@"selectImage" title:@"精选内容" vcClass:[SelectViewController class]];
        MoreItem *item5 = [MoreItem itemWithIcon:@"contentImage" title:@"内容提取" vcClass:[ContentViewController class]];
        MoreItem *item6 = [MoreItem itemWithIcon:@"taskImage" title:@"我的任务" vcClass:[TaskMyViewController class]];
        MoreItem *item7 = [MoreItem itemWithIcon:@"listImage" title:@"排行榜" vcClass:[StatisticArticleListViewController class]];
        MoreItem *item8 = [MoreItem itemWithIcon:@"actionVIPImage" title:@"激活VIP" vcClass:[ActionVIPViewController class]];
        MoreItem *item9 = [MoreItem itemWithIcon:@"tongji" title:@"流量统计" vcClass:[StatisticViewController class]];
        MoreItem *item10 = [MoreItem itemWithIcon:@"vv" title:@"我的订单" vcClass:[StatisticViewController class]];
        MoreItem *item11 = [MoreItem itemWithIcon:@"vv" title:@"敬请期待" vcClass:[StatisticViewController class]];
        
        NSMutableArray *arr1 = [[NSMutableArray alloc] initWithObjects:item0,item1,item2, nil];
        NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:item3,item4,item5,item6,item7,item8,item9,item10,item11, nil];
        
        _dataSourceArray = [NSMutableArray arrayWithObjects:arr1,arr2, nil];
        
    }
    return _dataSourceArray;
}
//--------------------------------------------------------------------------------------------------------------
#pragma mark - btn的方法实现
//头像按钮的实现方法
- (void)iconBtnBeClick
{
    //三方登录的头像和昵称
    NSString *userInfoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.txt"];//当前应用的沙盒路径
    NSMutableArray *userInfoArray = [NSKeyedUnarchiver unarchiveObjectWithFile:userInfoPath];
    if (userInfoArray) {
        EditPersonalinformationViewController *editPersonalInfoVC = [[EditPersonalinformationViewController alloc] init];
        editPersonalInfoVC.delegate = self;
        [self presentViewController:editPersonalInfoVC animated:YES completion:nil];
    } else {
        self.coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.coverBtn.frame = [UIScreen mainScreen].bounds;
        self.coverBtn.backgroundColor = [UIColor blackColor];
        self.coverBtn.alpha = 0.6;
        [self.coverBtn addTarget:self action:@selector(removeSelfAndLoginVC) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.coverBtn];
//        [self.view bringSubviewToFront:self.coverBtn];
        
        
        self.loginVC = [[LoginViewController alloc] init];
        self.loginVC.view.x = 30;
        self.loginVC.view.y = 150;
        self.loginVC.view.height = 250;
        self.loginVC.view.width = ScreenWidth - 60;
        self.loginVC.view.layer.cornerRadius = 5;
        self.loginVC.view.layer.masksToBounds = YES;
        [self.view addSubview:self.loginVC.view];
//        [self addChildViewController:self.loginVC];
         [self.view bringSubviewToFront:self.loginVC.view];
        
    }
    
}

- (void)removeSelfAndLoginVC
{
//    //1.删除loginVC
    [self.loginVC.view removeFromSuperview];
//
//    //2.让阴影按钮的透明度变为0
////    self.coverBtn.alpha = 0.0;
//    //3.移除阴影按钮
    [self.coverBtn removeFromSuperview];
//    //当头像图片变成小图时候，再把self.cover设置成nil
    self.coverBtn = nil;
}

-(void)deleteUserInfoPathMethod
{
    //删除三方登录的数组里的信息
    NSString *userInfoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.txt"];//当前应用的沙盒路径
    //删除文件路径
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    [fileManager removeItemAtPath:userInfoPath error:nil];
    [self getEditChangeValue];

    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.loginVC.view removeFromSuperview];
//}

#pragma mark -
#pragma mark - 内存警告
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
