//
//  GeneralSettingViewController.m
//  众商智推
//
//  Created by 杨 on 16/7/14.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "GeneralSettingViewController.h"

@interface GeneralSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *setTableView;
//头部标题
@property (strong, nonatomic) NSArray *headArr;
//content
@property (strong, nonatomic) NSMutableArray *contentArr;
//detail
@property (strong, nonatomic) NSMutableArray *detailArr;

@end

@implementation GeneralSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHeadUI];
    
    
}

#pragma mark - 创建顶部View
- (void)createHeadUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    headView.backgroundColor = ZSColor(19, 143, 253);
    [self.view addSubview:headView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //标题Label
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(60, 25, self.view.frame.size.width - 110, 40)];
    titleLabel.text = @"通用设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    [headView addSubview:titleLabel];
    
    self.setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 65) style:UITableViewStylePlain];
    self.setTableView.dataSource = self;
    self.setTableView.delegate = self;
    [self.view addSubview: self.setTableView];
    
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 懒加载
- (NSArray *)headArr
{
    if (!_headArr) {
        _headArr = [[NSArray alloc] initWithObjects:@"基本设置",@"推送设置",@"其它", nil];
    }
    return _headArr;
}
- (NSMutableArray *)contentArr
{
    if (!_contentArr) {
        NSArray *arr1 = [[NSArray alloc] initWithObjects:@"图片质量设置",@"视屏播放设置",@"消息提醒设置",@"文章采集设置",@"允许横屏",@"设置下载内容存储路径", nil];
        NSArray *arr2 = [[NSArray alloc] initWithObjects:@"系统推荐",@"夜间接收消息", nil];
        NSArray *arr3 = [[NSArray alloc] initWithObjects:@"满意度调查", nil];
        _contentArr = [NSMutableArray arrayWithObjects:arr1,arr2,arr3, nil];
    }
    return _contentArr;
}
- (NSMutableArray *)detailArr
{
    if (!_detailArr) {
        NSArray *arr1 = [[NSArray alloc] initWithObjects:@"有WLAN自动从云端获取全部解释",@"仅在WLAN时更新首页内容",@"在顶部通知栏启用快速查询",@"请输入以http://mp.weixin.qq.com开始的新闻链接",@"已禁止界面横屏",@"sdcard0(剩余2.45G/12.27G)", nil];
        NSArray *arr2 = [[NSArray alloc] initWithObjects:@"贴心为你推荐最近最实用的优质内容",@"指晚上22:00-早晨8:00接收消息", nil];
        NSArray *arr3 = [[NSArray alloc] initWithObjects:@" ", nil];
        _detailArr = [NSMutableArray arrayWithObjects:arr1,arr2,arr3, nil];
    }
    return _detailArr;
}

#pragma mark - UITableView -----> UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.contentArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.contentArr objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [[self.contentArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [[self.detailArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //    _cellSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(300, 10, 30, 30)];
    //    [_cellSwitch setOn:YES];
    //    [cell.contentView addSubview:_cellSwitch];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    return [self.headArr objectAtIndex:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    //创建面板
    //    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"请您先登录" message:@"操作提示" preferredStyle:UIAlertControllerStyleAlert];
    //    //创建事件
    //    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //        //当取消事件被触发后执行的回调操作
    //        NSLog(@"取消事件被触发");
    //    }];
    //    UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        //当取消事件被触发后执行的回调操作
    //        NSLog(@"确定事件被触发");
    //    }];
    //    //把事件加载到面板上
    //    [alertView addAction:cancel];
    //    [alertView addAction:okBtn];
    //    //加载alertView
    //    [self presentViewController:alertView animated:YES completion:nil];
    
    
}




@end
