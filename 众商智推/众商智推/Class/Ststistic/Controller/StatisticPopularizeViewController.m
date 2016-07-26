//
//  StatisticPopularizeViewController.m
//  众商智推
//
//  Created by 杨 on 16/6/10.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "StatisticPopularizeViewController.h"
#import "DIYMJRefresh.h"
#import "LiangView.h"
#import "AFNetworkUtil.h"
#import "MBProgressHUD+MJ.h"
#import "AllTableViewCell.h"
#import "WebViewController.h"

@interface StatisticPopularizeViewController ()<UITableViewDataSource,UITableViewDelegate>

//排行榜的表格
@property (strong, nonatomic) UITableView *STableView;
//所有数据的数组
@property (strong, nonatomic) NSMutableArray *allArray;
// 用于临时保存解析的字符数据
@property (nonatomic, strong) NSMutableArray *tempArray;

@property (assign, nonatomic) NSInteger startNum;

@end

@implementation StatisticPopularizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startNum = 1;
    self.allArray = [NSMutableArray arrayWithCapacity:10];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    [self createHeadUI];
    [self sendRequest];
    [self addRrefreshController];
    [self.view addSubview:self.STableView];
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
    //    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    //    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //标题按钮
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-100, 25, 200, 40)];
    titleLabel.text = @"推广记录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - 添加下拉刷新和下拉提取
-(void)addRrefreshController
{
    //添加下拉刷新和上拉提取
    //下拉刷新
    DIYMJRefreshGifHeader *gifHeader = [DIYMJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.STableView.header endRefreshing];
        self.startNum = 1;
        [self sendRequest];
        [MBProgressHUD showSuccess:@"已是最新数据"];
    }];
    self.STableView.header = gifHeader;
    //上拉提取
    DIYMJRefreshBackGifFooter *gifFooter = [DIYMJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [MBProgressHUD showSuccess:@"已是最新数据"];
        self.startNum += 1;
        [self sendRequest];
        [self.STableView.footer endRefreshing];
    }];
    self.STableView.footer = gifFooter;
}
#pragma mark -
#pragma mark -网络请求数据
- (void)sendRequest
{
    NSDictionary *parametDic = @{@"type":@(51),@"PageNo":@(self.startNum)};
    
    [AFNetworkUtil postDictWithUrl:BASE_STRURL parameters:parametDic successBackData:^(NSData *data) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        ZSLog(@"------------------\n%@",dict);
        
        for (NSDictionary *itemDic in dict[@"list"]) {
            self.tempArray = [[NSMutableArray alloc] init];
            
            ArticleListModel *listModel = [[ArticleListModel alloc] initWithDictionary:itemDic];
            //把listmodel模型存放到一个数组当中
            [self.tempArray addObject:listModel];
            //            [self.allArray insertObjects:self.tempArray atIndexes:0];
            
            [self.allArray addObjectsFromArray:self.tempArray];
        }
        
        ZSLog(@"%ld",(long)self.allArray.count);
        
        //请求成功以后刷新表格
        [self.STableView reloadData];
        //请求成功，loading界面消失
        [LiangView removeLiangViewFromSuperView:self.view];
        
        //刷新操作
        if ([self.STableView.header isRefreshing]) {
            [self.STableView.header endRefreshing];
        }
        if ([self.STableView.footer isRefreshing]) {
            [self.STableView.footer endRefreshing];
        }
    } fail:^{
        NSError *error;
        if (error) {
            ZSLog(@"%@",error);
        }
        
    }];
}
#pragma mark -
#pragma mark - 懒加载
- (UITableView *)STableView
{
    if (!_STableView) {
        _STableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight- 64) style:UITableViewStylePlain];
        _STableView.delegate = self;
        _STableView.dataSource = self;
        _STableView.rowHeight = 100;
    }
    return _STableView;
}
#pragma mark -
#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.allArray) {
        return self.allArray.count;
    }else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    AllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AllTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier cellWidth:ScreenWidth];
    }
    [cell jiaZaiDataWithModel:[self.allArray objectAtIndex:indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WebViewController *webVC = [[WebViewController alloc] init];
    [webVC jiaZaiDataWithModel:[self.allArray objectAtIndex:indexPath.row]];
    [self presentViewController:webVC animated:YES completion:nil];
    

    
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
