//
//  ReiDianViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/8.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ReDianViewController.h"
#import "AllTableViewCell.h"
#import "WebViewController.h"
#import "ZSZTWebViewController.h"
//#import "AFHTTPSessionManager.h"
//#import "DIYMJRefresh.h"
//#import "LiangView.h"
//#import "AFNetworkUtil.h"
//#import "MBProgressHUD+MJ.h"
//#import "SDCycleScrollView.h"
#import "ArticleListModel.h"

@interface ReDianViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate>
//热点表格
@property (strong, nonatomic) UITableView *reDiantableView;
//开始请求的个数
@property (assign, nonatomic) NSInteger startNum;
//所有数据的数组
@property (strong, nonatomic) NSMutableArray *allArray;
 // 用于临时保存解析的字符数据
@property (nonatomic, strong) NSMutableArray *tempArray;
//轮播数组
@property (strong, nonatomic) NSMutableArray *scrollViewArray;
//轮播的点击事件
@property (strong, nonatomic) NSMutableArray *scrollViewClickUrl;

@end


/*
 添加蒙板
 [MBProgressHUD showMessage:@"正在拼命登陆中。。。"];
 移除蒙板
 [MBProgressHUD hideHUD];
 
 
 */

@implementation ReDianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startNum = 1;
    [self.view setBackgroundColor:ZSRandomColor];
    self.allArray = [NSMutableArray array];
    self.scrollViewArray = [NSMutableArray array];
    self.scrollViewClickUrl = [NSMutableArray array];
    //加载表格
    [self.view addSubview:self.reDiantableView];

    //加载图片轮播器
    [self createScrollView];
    //网络请求
    [self sendRequest];
    //刷新
    [self addRrefreshController];
    
    //在当前视图上加载loadingView
    [LiangView showLiangViewFromSuperView:self.view];
    
    
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
        
        [self.reDiantableView.header endRefreshing];
        [MBProgressHUD showSuccess:@"刷新成功"];
    }];
    self.reDiantableView.header = gifHeader;
    //上拉提取
    DIYMJRefreshBackGifFooter *gifFooter = [DIYMJRefreshBackGifFooter footerWithRefreshingBlock:^{
        self.startNum += 1;
        [self sendRequest];
        [MBProgressHUD showSuccess:@"加载成功"];
    }];
    self.reDiantableView.footer = gifFooter;
}
#pragma mark -
#pragma mark -网络请求数据
- (void)sendRequest
{
    
//    NSString *strUrl = [NSString stringWithFormat:@"http://192.168.0.112/weika/appArticle_queryAllArticle.action"];
    //    type="+classid+"&PageNo="+pageNo
    NSDictionary *parametDic = @{@"type":@(43),@"PageNo":@(self.startNum)};
    
    
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
        [self.reDiantableView reloadData];
        //请求成功，loading界面消失
        [LiangView removeLiangViewFromSuperView:self.view];
        
        //刷新操作
        if ([self.reDiantableView.header isRefreshing]) {
            [self.reDiantableView.header endRefreshing];
        }
        if ([self.reDiantableView.footer isRefreshing]) {
            [self.reDiantableView.footer endRefreshing];
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
    self.reDiantableView.tableHeaderView  = cycleScrollView;
    
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
    
    
    if (self.allArray) {
        return self.allArray.count;
    }else{
        return 5;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    AllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[AllTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier cellWidth:ScreenWidth];
    }
    
    [cell jiaZaiDataWithModel:[self.allArray objectAtIndex:indexPath.row]];
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //加载webView
    WebViewController *webVC = [[WebViewController alloc] init];
    [webVC jiaZaiDataWithModel:[self.allArray objectAtIndex:indexPath.row]];
    [self presentViewController:webVC animated:YES completion:nil];
    
}
#pragma 懒加载
- (UITableView *)reDiantableView
{
    if (!_reDiantableView) {
        _reDiantableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-120) style:UITableViewStylePlain];
        _reDiantableView.delegate = self;
        _reDiantableView.dataSource = self;
        _reDiantableView.rowHeight = 110;
    }
    return _reDiantableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wangluoqingqiu
{
    //    [self.baseNetWork liangRequestNetWorkWithUrl:@"http://v2.api.dmzj.com/article/list/0/2/0.json" withBackData:^(NSDictionary *dic) {
    //        NSLog(@"%@",dic);
    //    }];
    
    //    NSURL *url = [NSURL URLWithString:@"http://v2.api.dmzj.com/article/list/0/2/0.json"];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //
    //    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //
    //    NSLog(@"%@",arr);
    
    //没封装的网络请求的方法
    //    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    //    NSDate *date = [NSDate date];
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyy-MM-dd"];
    //    NSString *dateString = [formatter stringFromDate:date];
    //    NSString *str = [NSString stringWithFormat:@"http://dict.youdao.com/infoline?mode=publish&uiversion=2&client=mobile&date=%@&keyfrom=mdict.5.3.7.android&model=Lenovo_S850t&mid=4.4.2&imei=864011023860481&vendor=lenovo&screen=720x1280&abtest=0&auto=false&update=pulldown&apiversion=2",dateString];
    //    NSString *strUrl = [NSString stringWithFormat:@"http://bapi.xinli001.com/ceshi/ceshis.json/?category_id=0&rows=10&key=3a4b2a12539a916c040d069ae8ac8310&offset=%lu&rmd=-1",(long)self.startNum];
    
    //    服务器的总地址article_showArticleAll.action?type="+classid+"&PageNo="+pageNo
    //    NSString *strUrl = [NSString stringWithFormat:@"http://bj.zsezs.com/weika/article_showArticleAll.action?type=52&PageNo=1"];
    
    //    NSString *strUrl = [NSString stringWithFormat:@"http://bj.zsezs.com/weika/article_showArticleAll.action"];
    ////    type="+classid+"&PageNo="+pageNo
    //    NSDictionary *parametDic = @{@"type":@(52),@"PageNo":@(1)};
    //
    //    [manager POST:strUrl parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    //        ;
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //
    //        ZSLog(@"%@",responseObject);
    //
    //        //请求成功以后刷新表格
    //        [self.reDiantableView reloadData];
    //        //loading页面消失
    //
    //        //请求成功，loading界面消失
    //        [LiangView removeLiangViewFromSuperView:self.view];
    //
    //        //刷新操作
    //        if ([self.reDiantableView.header isRefreshing]) {
    //            [self.reDiantableView.header endRefreshing];
    //        }
    //        if ([self.reDiantableView.footer isRefreshing]) {
    //            [self.reDiantableView.footer endRefreshing];
    //        }
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        ZSLog(@"%@",error);
    //        [MBProgressHUD showError:@"请求超时！"];
    //        //请求失败，loading界面消失
    //        [LiangView removeLiangViewFromSuperView:self.view];
    //    }];

}

//------------------------------------------------------------------------------------------------
/*
 
 #define WIDTH ScreenWidth
 #define HEIGHT ScreenHeight
 #define ZSScrollImageCount 3
 
 //原生轮播的
 @property (strong, nonatomic) UIScrollView *reDianScrollView;
 @property (strong, nonatomic) UIPageControl *pageControl;
 @property (strong, nonatomic) NSTimer *timer;
 
 #pragma mark -
 #pragma mark - 图片轮播器
 - (void)createScrollView
 {
 self.reDianScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250)];
 self.reDianScrollView.backgroundColor = [UIColor brownColor];
 self.reDianScrollView.delegate = self;
 self.reDiantableView.tableHeaderView  = self.reDianScrollView;
 //添加图片到scrollview上
 CGFloat scrollW = self.reDianScrollView.frame.size.width;
 CGFloat scrollH = self.reDianScrollView.frame.size.height;
 for (int i =0; i < ZSScrollImageCount; i++) {
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * scrollW, 0, scrollW, scrollH)];
 //添加图片
 NSString *name = [NSString stringWithFormat:@"众商智推总体简介%d",i + 1];
 imageView.image = [UIImage imageNamed:name];
 [self.reDianScrollView addSubview:imageView];
 }
 
 //设置scrollview的其他属性
 self.reDianScrollView.contentSize = CGSizeMake(ZSScrollImageCount * scrollW, 0);
 //        self.reDianScrollView.userInteractionEnabled = NO;
 self.reDianScrollView.showsHorizontalScrollIndicator = NO;
 self.reDianScrollView.bounces = NO;  // 去除弹簧效果
 self.reDianScrollView.pagingEnabled = YES;
 self.reDianScrollView.scrollEnabled = YES;
 
 //添加轮播器的点击事件的按钮
 UIButton *tMBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 tMBtn.frame = CGRectMake(0, 0, ZSScrollImageCount * scrollW, self.reDianScrollView.frame.size.height);
 //    tMBtn.backgroundColor = [UIColor brownColor];
 [tMBtn addTarget:self action:@selector(goToScrollVC) forControlEvents:UIControlEventTouchUpInside];
 [self.reDianScrollView addSubview:tMBtn];
 
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
 //
 self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1];
 self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1];
 [self.reDiantableView addSubview:self.pageControl];
 //图片轮播器定时器
 [self addTimer];
 }
 #pragma mark -
 #pragma mark - 添加和移除定时器
 - (void)addTimer
 {
 //图片轮播器定时器
 self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(pageControlScrollView) userInfo:nil repeats:YES];
 //处理定时器的优先级
 [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
 }
 - (void)removeTimer
 {
 //移除定时器 一旦定时器停止就不能再使用
 [self.timer invalidate];
 self.timer = nil;
 }
 #pragma mark -
 #pragma mark - 定时器的方法实现
 - (void)pageControlScrollView
 {
 //1.获取当前的页码
 NSInteger currentPage = self.pageControl.currentPage;
 //2.判断当前页码是否到了最后一页，如果到了最后一页，让页码回到第一页；否则，让页码+1
 if (currentPage == ZSScrollImageCount - 1) {
 self.reDianScrollView.contentOffset = CGPointMake(0, 0);//到最后一页的时候，直接让它回到第一页
 currentPage = 0;
 
 }else{
 currentPage ++;
 }
 //3.计算下一页偏移的x值=每页的宽度*（页码+1）
 CGFloat offsetX = self.reDianScrollView.frame.size.width *(currentPage);
 //4.设置imgScrollview的偏移值=新的偏移值
 [self.reDianScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
 
 
 }
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView
 {
 double page = scrollView.contentOffset.x / scrollView.frame.size.width;
 // 四舍五入计算出页码
 self.pageControl.currentPage = (int)(page + 0.5);
 }
 //开始推拽的时候
 - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
 {
 //移除定时器
 [self removeTimer];
 }
 //停止腿拽的时候
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
 {
 //重新定义定时器
 [self addTimer];
 }
 - (void)goToScrollVC
 {
 ZSZTWebViewController *zsztWebVC = [[ZSZTWebViewController alloc] init];
 [self presentViewController:zsztWebVC animated:YES completion:nil];
 }
 */
//------------------------------------------------------------------------------------------------

@end
