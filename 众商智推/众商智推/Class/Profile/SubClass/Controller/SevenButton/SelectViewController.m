//
//  SelectViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/14.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "SelectViewController.h"
#import "AllTableViewCell.h"
#import "WebViewController.h"
//#import "AFHTTPSessionManager.h"
#import "DIYMJRefresh.h"
#import "LiangView.h"
#import "AFNetworkUtil.h"
#import "MBProgressHUD+MJ.h"

@interface SelectViewController ()<UITableViewDataSource,UITableViewDelegate>
//热点表格
@property (strong, nonatomic) UITableView *selectTableView;
//开始请求的个数
@property (assign, nonatomic) NSInteger startNum;
//所有数据的数组
@property (strong, nonatomic) NSMutableArray *allArray;
// 用于临时保存解析的字符数据
@property (nonatomic, strong) NSMutableArray *tempArray;

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startNum = 1;
    self.allArray = [[NSMutableArray alloc] init];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //加载表格
    [self.view addSubview:self.selectTableView];
    [self createHeadUI];
    //网络请求
    [self sendRequest];
    //刷新
    [self addRrefreshController];
    
    //在当前视图上加载loadingView
    [LiangView showLiangViewFromSuperView:self.view];


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
    titleLabel.text = @"精选内容";
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
        //        self.allArray = [NSMutableArray array];
        //        [self.allArray removeAllObjects];
//        self.startNum = 1;
        [self sendRequest];
        
        [self.selectTableView.header endRefreshing];
    }];
    self.selectTableView.header = gifHeader;
    //上拉提取
    DIYMJRefreshBackGifFooter *gifFooter = [DIYMJRefreshBackGifFooter footerWithRefreshingBlock:^{
        self.startNum += 1;
        [self sendRequest];
        
    }];
    self.selectTableView.footer = gifFooter;
}
#pragma mark -
#pragma mark -网络请求数据
- (void)sendRequest
{
    
    NSDictionary *parametDic = @{@"PageNo":@(self.startNum)};
    
    
    [AFNetworkUtil postDictWithUrl:SELECTOR_STRURL parameters:parametDic successBackData:^(NSData *data) {
        
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
        [self.selectTableView reloadData];
        //请求成功，loading界面消失
        [LiangView removeLiangViewFromSuperView:self.view];
        
        //刷新操作
        if ([self.selectTableView.header isRefreshing]) {
            [self.selectTableView.header endRefreshing];
        }
        if ([self.selectTableView.footer isRefreshing]) {
            [self.selectTableView.footer endRefreshing];
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
    
    //郁金香
    //    http://travel.sohu.com/20150419/n411508946.shtml
    //有道词典网址
    //    http://xue.youdao.com/bbs/post_detail?id=67957
}
#pragma 懒加载
- (UITableView *)selectTableView
{
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight-67) style:UITableViewStylePlain];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.rowHeight = 110;
    }
    return _selectTableView;
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
