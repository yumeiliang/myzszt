//
//  TaskViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/8.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskTableViewCell.h"
#import "ZSZTWebViewController.h"
#import "SDCycleScrollView.h"

#import "AFNetworkUtil.h"
#import "DIYMJRefresh.h"
#import "LiangView.h"
#import "MBProgressHUD+MJ.h"
#import "TaskAllModel.h"
#import "WebViewController.h"

@interface TaskViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SDCycleScrollViewDelegate>

@property (strong, nonatomic) UITableView *taskTableView;
////图片轮播器
//@property (strong, nonatomic) UIScrollView *taskScrollView;
////分页控制器
//@property (strong, nonatomic) UIPageControl *pageControl;
////图片轮播器定时器
//@property (strong, nonatomic) NSTimer *timer;

//所有数据的数组
@property (strong, nonatomic) NSMutableArray *allArray;
// 用于临时保存解析的字符数据
@property (nonatomic, strong) NSMutableArray *tempArray;
//轮播数组
@property (strong, nonatomic) NSMutableArray *scrollViewArray;
//轮播的点击事件
@property (strong, nonatomic) NSMutableArray *scrollViewClickUrl;


@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.allArray = [[NSMutableArray alloc] init];
    self.scrollViewArray = [NSMutableArray array];
    self.scrollViewClickUrl = [NSMutableArray array];
    
    [self.view addSubview:self.taskTableView];
    //刷新
//    [self createRefreshControl];
    //加载图片轮播器
    [self createScrollView];
    //添加刷新
    [self addRrefreshController];
    [self sendRequest];
    
}
#pragma mark -
#pragma mark - 添加下拉刷新和下拉提取
-(void)addRrefreshController
{
    //添加下拉刷新和上拉提取
    //下拉刷新
    DIYMJRefreshGifHeader *gifHeader = [DIYMJRefreshGifHeader headerWithRefreshingBlock:^{   
        [self.taskTableView.header endRefreshing];
        [MBProgressHUD showSuccess:@"已是最新数据"];
    }];
    self.taskTableView.header = gifHeader;
    //上拉提取
    DIYMJRefreshBackGifFooter *gifFooter = [DIYMJRefreshBackGifFooter footerWithRefreshingBlock:^{
//        self.startNum += 1;
//        [self sendRequest];
        [MBProgressHUD showSuccess:@"已是最新数据"];
        [self.taskTableView.footer endRefreshing];
    }];
    self.taskTableView.footer = gifFooter;
}
#pragma mark -
#pragma mark -网络请求数据
- (void)sendRequest
{
    [AFNetworkUtil postDictWithUrl:TASK_STRURL parameters:nil success:^(id responseObject) {
        ZSLog(@"%@",responseObject);
        
        for (NSDictionary *itemDic in responseObject[@"list"]) {
            self.tempArray = [[NSMutableArray alloc] init];
            
            TaskAllModel *listModel = [[TaskAllModel alloc] initWithDictionary:itemDic];
            //把listmodel模型存放到一个数组当中
            [self.tempArray addObject:listModel];
//            [self.allArray insertObjects:self.tempArray atIndexes:0];
            
            [self.allArray addObjectsFromArray:self.tempArray];
        }
        
        ZSLog(@"%ld",(long)self.allArray.count);
        
        //请求成功以后刷新表格
        [self.taskTableView reloadData];
        //请求成功，loading界面消失
        [LiangView removeLiangViewFromSuperView:self.view];
        
        //刷新操作
        if ([self.taskTableView.header isRefreshing]) {
            [self.taskTableView.header endRefreshing];
        }
        if ([self.taskTableView.footer isRefreshing]) {
            [self.taskTableView.footer endRefreshing];
        }
        
    } fail:^{
        NSError *error;
        if (error) {
            ZSLog(@"%@",error);
        }
        [MBProgressHUD showError:@"请求超时！"];
        //请求失败，loading界面消失
        [LiangView removeLiangViewFromSuperView:self.view];
        //刷新操作
        if ([self.taskTableView.header isRefreshing]) {
            [self.taskTableView.header endRefreshing];
        }
        if ([self.taskTableView.footer isRefreshing]) {
            [self.taskTableView.footer endRefreshing];
        }

    }];
    
}
#pragma mark -
#pragma mark - 图片轮播器
- (void)createScrollView
{
    [AFNetworkUtil postDictWithUrl:LUNBO2_STRURL parameters:nil successBackData:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        ZSLog(@"------------------\n%@",dict);
        for (NSDictionary *itemDic in dict[@"list2"]) {
            ArticleListModel *listModel = [[ArticleListModel alloc] initWithDictionary:itemDic];
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            NSMutableArray *tempArr1 = [[NSMutableArray alloc] init];
            [tempArr addObject:listModel.scrollerImage2];
            [tempArr1 addObject:listModel.scrollerClickUrl2];
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
    self.taskTableView.tableHeaderView  = cycleScrollView;
    
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
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TaskTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier cellWidth:ScreenWidth];
    }
    //表格加载数据
    [cell jiaZaiDataWithModel:[self.allArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //加载webView
    WebViewController *webVC = [[WebViewController alloc] init];
    [webVC jiaZaiDataWithTaskModel:[self.allArray objectAtIndex:indexPath.row]];
    [self presentViewController:webVC animated:YES completion:nil];
}

#pragma 懒加载
- (UITableView *)taskTableView
{
    if (!_taskTableView) {
        _taskTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 24, ScreenWidth, ScreenHeight-70) style:UITableViewStylePlain];
        _taskTableView.delegate = self;
        _taskTableView.dataSource = self;
        _taskTableView.rowHeight = 120;
    }
    return _taskTableView;
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

/*
 
 #define WIDTH self.view.frame.size.width
 #define HEIGHT self.view.frame.size.height
 #define ZSScrollImageCount 6

 
#pragma mark -
#pragma mark - 图片轮播器
- (void)createScrollView
{
    self.taskScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    self.taskScrollView.backgroundColor = [UIColor brownColor];
    self.taskScrollView.delegate = self;
    self.taskTableView.tableHeaderView  = self.taskScrollView;
    //添加图片到scrollview上
    CGFloat scrollW = self.taskScrollView.frame.size.width;
    CGFloat scrollH = self.taskScrollView.frame.size.height;
    for (int i =0; i < ZSScrollImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * scrollW, 0, scrollW, scrollH)];
        //添加图片
        NSString *name = [NSString stringWithFormat:@"众商智推总体简介%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        [self.taskScrollView addSubview:imageView];
    }

    //设置scrollview的其他属性
    self.taskScrollView.contentSize = CGSizeMake(ZSScrollImageCount * scrollW, 0);
    //        self.reDianScrollView.userInteractionEnabled = NO;
    self.taskScrollView.showsHorizontalScrollIndicator = NO;
    self.taskScrollView.bounces = NO;  // 去除弹簧效果
    self.taskScrollView.pagingEnabled = YES;
    self.taskScrollView.scrollEnabled = YES;

    //添加轮播器的点击事件
    UIButton *tMBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tMBtn.frame = CGRectMake(0, 0, ZSScrollImageCount * scrollW, self.taskScrollView.frame.size.height);
    //    tMBtn.backgroundColor = [UIColor brownColor];
    [tMBtn addTarget:self action:@selector(goToScrollVC) forControlEvents:UIControlEventTouchUpInside];
    [self.taskScrollView addSubview:tMBtn];

    //添加分页控制器
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = ZSScrollImageCount;
    CGRect frame = self.pageControl.frame;
    frame.size.width = 100;
    self.pageControl.frame = frame;
    CGPoint center = self.pageControl.center;
    center.x = scrollW * 0.5;
    center.y = scrollH - 20;
    self.pageControl.center = center;

    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1];
    [self.taskTableView addSubview:self.pageControl];
    //图片轮播器定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(pageControlScrollView) userInfo:nil repeats:YES];
}
#pragma mark -
#pragma mark - 定时器的方法实现
- (void)pageControlScrollView
{
    //1.获取当前的页码
    NSInteger currentPage = self.pageControl.currentPage;
    //2.判断当前页码是否到了最后一页，如果到了最后一页，让页码回到第一页；否则，让页码+1
    if (currentPage == self.pageControl.numberOfPages - 1) {
        self.taskScrollView.contentOffset = CGPointMake(0, 0);//到最后一页的时候，直接让它回到第一页
        currentPage = 0;

    }else{
        currentPage ++;
    }
    //3.计算下一页偏移的x值=每页的宽度*（页码+1）
    CGFloat offsetX = self.taskScrollView.frame.size.width *(currentPage);
    //4.设置imgScrollview的偏移值=新的偏移值
    [self.taskScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
}


#pragma mark -
#pragma mark - button的方法实现   刷新
- (void)createRefreshControl
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(gogogo) forControlEvents:UIControlEventTouchUpInside];
    [self.taskTableView addSubview:refreshControl];
}
- (void)gogogo
{
    NSLog(@"刷新事件被执行");
}
//scrollview放入点击事件
- (void)goToScrollVC
{
    ZSZTWebViewController *zsztWebVC = [[ZSZTWebViewController alloc] init];
    [self presentViewController:zsztWebVC animated:YES completion:nil];
}
*/


@end
