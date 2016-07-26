//
//  BaGuaViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/8.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "BaGuaViewController.h"

#import "AllTableViewCell.h"
#import "WebViewController.h"
#import "ZSZTWebViewController.h"
#import "ArticleListModel.h"

@interface BaGuaViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate>
@property (strong, nonatomic) UITableView *baGuaTableView;
//开始请求的个数
@property (assign, nonatomic) NSInteger startNum;
//数据数组
@property (strong, nonatomic) NSMutableArray *allArray;
// 用于临时保存解析的字符数据
@property (nonatomic, strong) NSMutableArray *tempArray;
//轮播数组
@property (strong, nonatomic) NSMutableArray *scrollViewArray;
//轮播的点击事件
@property (strong, nonatomic) NSMutableArray *scrollViewClickUrl;

@end

@implementation BaGuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景色
    [self.view setBackgroundColor:ZSRandomColor];
    
    
    self.startNum = 1;
    self.allArray = [[NSMutableArray alloc] init];
    self.scrollViewArray = [NSMutableArray array];
    self.scrollViewClickUrl = [NSMutableArray array];
    
    [self.view addSubview:self.baGuaTableView];
    //加载轮播图
    [self createScrollView];
    //网络请求
    [self sendRequest];
    //刷新
    [self addRrefreshController];
    
    
}
#pragma mark -
#pragma mark - 添加下拉刷新和下拉提取
-(void)addRrefreshController
{
    //添加下拉刷新和上拉提取
    //下拉刷新
    DIYMJRefreshGifHeader *gifHeader = [DIYMJRefreshGifHeader headerWithRefreshingBlock:^{
        //        self.allArray = [NSMutableArray array];
        //        [self.allArray removeAllObjects];
//        self.startNum = 1;
//        [self sendRequest];
        
        [self.baGuaTableView.header endRefreshing];
        [MBProgressHUD showSuccess:@"刷新成功"];
    }];
    self.baGuaTableView.header = gifHeader;
    //上拉提取
    DIYMJRefreshBackGifFooter *gifFooter = [DIYMJRefreshBackGifFooter footerWithRefreshingBlock:^{
        self.startNum += 1;
        [self sendRequest];
        [MBProgressHUD showSuccess:@"加载成功"];
    }];
    self.baGuaTableView.footer = gifFooter;
}
#pragma mark -
#pragma mark -网络请求数据
- (void)sendRequest
{
    NSDictionary *parametDic = @{@"type":@(72),@"PageNo":@(self.startNum)};

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
        
        ZSLog(@"%ld",self.allArray.count);
        
        //请求成功以后刷新表格
        [self.baGuaTableView reloadData];
        //请求成功，loading界面消失
        [LiangView removeLiangViewFromSuperView:self.view];
        
        //刷新操作
        if ([self.baGuaTableView.header isRefreshing]) {
            [self.baGuaTableView.header endRefreshing];
        }
        if ([self.baGuaTableView.footer isRefreshing]) {
            [self.baGuaTableView.footer endRefreshing];
        }
        
    } fail:^{
        NSError *error;
        if (error) {
            ZSLog(@"%@",error);
        }
        [MBProgressHUD showError:@"请求超时！"];
        //请求失败，loading界面消失
        [LiangView removeLiangViewFromSuperView:self.view];
        
    }];
    
}
#pragma mark -
#pragma mark - 图片轮播器
- (void)createScrollView
{
    [AFNetworkUtil postDictWithUrl:LUNBO1_STRURL parameters:nil successBackData:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        ZSLog(@"------------------\n%@",dict);
        for (NSDictionary *itemDic in dict[@"list1"]) {
            ArticleListModel *listModel = [[ArticleListModel alloc] initWithDictionary:itemDic];
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            NSMutableArray *tempArr1 = [[NSMutableArray alloc] init];
            [tempArr addObject:listModel.scrollerImage];
            [tempArr1 addObject:listModel.scrollerClickUrl];
            [self.scrollViewArray addObjectsFromArray:tempArr];
            [self.scrollViewClickUrl addObjectsFromArray:tempArr1];
        }
        ZSLog(@"%@",self.scrollViewArray);
        ZSLog(@"%@",self.scrollViewClickUrl);
    } fail:^{
        NSError *error;
        if (error) {
            ZSLog(@"%@",error);
        }
    }];
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 250) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    //    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //    cycleScrollView.titlesGroup = titles;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.baGuaTableView.tableHeaderView  = cycleScrollView;
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //广告的数组
        cycleScrollView.imageURLStringsGroup = self.scrollViewArray;
    });
}
#pragma mark -
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    ZSZTWebViewController *zsztWebVC = [[ZSZTWebViewController alloc] init];
    zsztWebVC.adUrl = [self.scrollViewClickUrl objectAtIndex:index];
    [self presentViewController:zsztWebVC animated:YES completion:nil];
}

#pragma -UITableViewDataSource,UITableViewDelegate的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    AllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[AllTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier cellWidth:ScreenWidth];
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
#pragma 懒加载
- (UITableView *)baGuaTableView
{
    if (!_baGuaTableView) {
        _baGuaTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- 120) style:UITableViewStylePlain];
        _baGuaTableView.delegate = self;
        _baGuaTableView.dataSource = self;
        _baGuaTableView.rowHeight = 110;
    }
    return _baGuaTableView;
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
