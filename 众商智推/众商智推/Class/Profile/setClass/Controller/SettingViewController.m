//
//  SettingViewController.m
//  众商智推
//
//  Created by 杨 on 16/7/14.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "GeneralSettingViewController.h"
#import "AboutUsViewController.h"
#import "MoreItem.h"

@interface SettingViewController ()

@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createHeadUI];
    
}

#pragma mark -
#pragma mark - 数据加载
- (NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
        MoreItem *item00 = [MoreItem itemWithIcon:nil title:nil vcClass:nil];
        MoreItem *item0 = [MoreItem itemWithIcon:@"通知设置" title:@"通知设置" vcClass:[GeneralSettingViewController class]];
        MoreItem *item1 = [MoreItem itemWithIcon:@"通用设置" title:@"通用设置" vcClass:[LoginViewController class]];
        MoreItem *item2 = [MoreItem itemWithIcon:@"隐私与安全" title:@"隐私与安全" vcClass:[LoginViewController class]];
        MoreItem *item3 = [MoreItem itemWithIcon:@"意见反馈" title:@"意见反馈" vcClass:[LoginViewController class]];
        MoreItem *item4 = [MoreItem itemWithIcon:@"关于众商" title:@"关于众商" vcClass:[AboutUsViewController class]];
        MoreItem *item5 = [MoreItem itemWithIcon:@"联系我们" title:@"联系我们" vcClass:nil];
        MoreItem *item6 = [MoreItem itemWithIcon:@"检查更新" title:@"检查更新" vcClass:nil];
        MoreItem *item7 = [MoreItem itemWithIcon:@"其他" title:@"其他" vcClass:[LoginViewController class]];
        
        _data = [NSMutableArray arrayWithObjects:item00,item0,item1,item2,item3,item4,item5,item6,item7, nil];
        
    }
    return _data;
}

#pragma mark - 创建顶部View
- (void)createHeadUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headView.backgroundColor = ZSColor(19, 143, 253);
    [self.view addSubview:headView];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //标题Label
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, 25, 80, 40)];
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    MoreItem *item = self.data[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:item.icon];
    cell.textLabel.text = item.title;
    
    if (indexPath.row == 6) {
        cell.detailTextLabel.text = @"400-636-1533";
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 6) {
        //创建面板
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"用户您好" message:[NSString stringWithFormat:@"是否拨打：400-636-1533"] preferredStyle:UIAlertControllerStyleAlert];
        //创建事件
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //当取消事件被触发后执行的回调操作
            ZSLog(@"取消事件被触发");
        }];
        UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //当确定事件被触发后执行的回调操作
            ZSLog(@"确定事件被触发");
            
            //拨打电话的功能
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"4006361533"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }];
        //把事件加载到面板上
        [alertView addAction:cancel];
        [alertView addAction:okBtn];
        [self presentViewController:alertView animated:YES completion:nil];
    } else if (indexPath.row == 7) {
        [MBProgressHUD showSuccess:@"已是最新版本"];
    } else {
        MoreItem *item = self.data[indexPath.row];
        UIViewController *vc = [[item.vcClass alloc] init];
        [self presentViewController:vc animated:YES completion:nil];

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



@end
