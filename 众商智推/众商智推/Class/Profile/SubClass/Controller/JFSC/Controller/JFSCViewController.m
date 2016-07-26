//
//  JFSCViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/5.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "JFSCViewController.h"
#import "JFSCCollectionViewCell.h"
#import "JFSCSearcGoodshViewController.h"
#import "JFSCGoodsViewController.h"

#import "JFSCListModel.h"

@interface JFSCViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//图片数组
@property (strong, nonatomic) NSArray *imageArr;
//名称数组
@property (strong, nonatomic) NSArray *goodsNameArr;
//积分数组
@property (strong, nonatomic) NSArray *integralArr;
//商品的网址
@property (strong, nonatomic) NSArray *goodsUrl;
//商品的详细信息
@property (strong, nonatomic) NSArray *goodsInfoArr;

//所有数据的数组
@property (strong, nonatomic) NSMutableArray *allArray;
// 用于临时保存解析的字符数据
@property (nonatomic, strong) NSMutableArray *tempArray;



@end

static NSString *cellId = @"cell";
static NSString *reuseID = @"reuseID";
@implementation JFSCViewController

//#pragma mark ------------------ 隐藏状态栏
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor cyanColor]];
    self.allArray = [[NSMutableArray alloc] init];
    
    self.imageArr = @[@"酒",@"澳乐儿童玩具",@"利马赫",@"梦特娇",@"MacBookPro",@"澳乐儿童玩具",@"梦特娇",@"华为"];
    self.goodsNameArr = @[@"贵州茅台君匠坊",@"澳乐儿童玩具",@"利马赫/LIEMOCH",@"梦特娇(MONTAGUT)男士公文包",@"梦特娇(MONTAGUT)男士公文包",@"MacBook Pro",@"澳乐儿童玩具",@"华为 Mate 8"];
    self.integralArr = @[@"929积分",@"88元",@"14288积分",@"709积分",@"88元",@"13800积分",@"709积分",@"4399积分"];
    
    self.goodsInfoArr = @[@"飞天茅台 53度 500ml 白酒 酱香型 1919酒类直供",@"澳乐儿童玩具宝宝海洋球波波球池帐篷游戏屋小孩早教益智户外玩具游戏池0-3岁 超大号+约100个球 适合1-3岁",@"利马赫20寸 5.5kg 中国大陆 银色 有锁",@"梦特娇男士商务公文包 广东省 拉链内部结构：拉链暗袋，手机袋 啡色",@"AppleMacBook Pro 3.96kg 超高清屏（2K/3k/4K) 9小时以上 校园学生，商务办公，高清影音",@"澳乐儿童玩具宝宝海洋球波波球池帐篷游戏屋小孩早教益智户外玩具游戏池0-3岁 超大号+约100个球 适合1-3岁",@"梦特娇男士商务公文包 广东省 拉链内部结构：拉链暗袋，手机袋 啡色",@"华为Mate8 双卡双待，指纹识别，金属机身，拍照神器 128GB内存 1000-1600万像素"];
    
     [self sendRequest];
    // 添加集合视图
    [self.view addSubview:self.collectionView];
    
    [self createHeadUI];
    
   
    
}
#pragma mark - 创建顶部View
- (void)createHeadUI
{
    //标题Label
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, 10, 80, 40)];
    titleLabel.text = @"积分商城";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
}

#pragma mark -
#pragma mark -网络请求数据
- (void)sendRequest
{
    
    //    NSString *strUrl = [NSString stringWithFormat:@"http://192.168.0.112/weika/appArticle_queryAllArticle.action"];
    //    type="+classid+"&PageNo="+pageNo
//    NSDictionary *parametDic = @{@"type":@(43),@"PageNo":@(self.startNum)};
    
    
    [AFNetworkUtil postDictWithUrl:JFSC_STRURL parameters:nil successBackData:^(NSData *data) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        ZSLog(@"------------------\n%@",dict);
        
        for (NSDictionary *itemDic in dict[@"list"]) {
            self.tempArray = [[NSMutableArray alloc] init];
            JFSCListModel *listModel = [[JFSCListModel alloc] initWithDictionary:itemDic];
            //把listmodel模型存放到一个数组当中
            [self.tempArray addObject:listModel];
            
            [self.allArray addObjectsFromArray:self.tempArray];
        }
        
        ZSLog(@"%ld",(long)self.allArray.count);
        
        //请求成功以后刷新表格
        [self.collectionView reloadData];
        //请求成功，loading界面消失
        [LiangView removeLiangViewFromSuperView:self.view];
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



#pragma mark ------------------ 集合视图的代理和协议方法
//// 组数
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
//    return 8;
    if (self.allArray.count % 2 == 0) {
        return self.allArray.count ;
    }else
    {
        return self.allArray.count+1;
    }
}
// 头视图
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseID forIndexPath:indexPath];
    if (!view) {
        view = [[UICollectionReusableView alloc] init];
        view.frame = CGRectMake(0, 45, ScreenWidth-20, 70);
    }else
    {
        view.frame = CGRectMake(0, 45, ScreenWidth-20, 70);
//        view.backgroundColor = ZSColor(173, 209, 62);
//        [view addSubview:self.topImageView];
        [view addSubview:self.searchGoodsBtn];
    }
    return view;
}
// 表格
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JFSCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[JFSCCollectionViewCell alloc] init];
    }
    
    
    [cell jiaZaiDataWithModel:[self.allArray objectAtIndex:indexPath.row]];
    
//    cell.imageView.image = [UIImage imageNamed:[self.imageArr objectAtIndex:indexPath.row]];
//    cell.goodsNameLabel.text = [self.goodsNameArr objectAtIndex:indexPath.row];
//    cell.integralLabel.text = [self.integralArr objectAtIndex:indexPath.row];
    return cell;
}

//返回CollectingviewCell的上下左右偏移
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //顺序依次为上，左，下，右
    return UIEdgeInsetsMake(10, 0, 0, 0);
}
//设置topImage X    Y 坐标
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(365, 110);
}
// 单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width/2-15, 270);
}
// 行与行的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 7;
}

#warning 选中单元格方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZSLog(@"collectionView被点击了%lu",indexPath.row);
    
//    NSString *strUrl = [self.goodsUrl objectAtIndex:indexPath.row];
    
    JFSCGoodsViewController *goodsVC = [[JFSCGoodsViewController alloc] init];
    JFSCListModel *model = [self.allArray objectAtIndex:indexPath.row];
    goodsVC.titleStr = model.goodName;
    goodsVC.infoUrl = model.goodInfoUrl;
    [self presentViewController:goodsVC animated:YES completion:nil];
    
//    JFSCGoodsViewController *goodsVC = [[JFSCGoodsViewController alloc] init];
//    goodsVC.titleStr = [self.goodsNameArr objectAtIndex:indexPath.row];
//    goodsVC.goodsImageNameStr = [self.imageArr objectAtIndex:indexPath.row];
//    goodsVC.goodsIntegralStr = [self.integralArr objectAtIndex:indexPath.row];
//    goodsVC.goodsInfostr = [self.goodsInfoArr objectAtIndex:indexPath.row];
//    [self presentViewController:goodsVC animated:YES completion:nil];
    
//    JFSCCollectionViewCell *cell = (JFSCCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    ZTDetailViewController *detailVC = [[ZTDetailViewController alloc] init];
//    detailVC.c1SysNoStr = cell.idStr;
//    [self presentViewController:detailVC animated:YES completion:nil];
    
}

#pragma mark ------------------ 懒加载
// 滑动视图
// 集合视图
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        // 布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        // 初始化
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        // 内边距
        _collectionView.contentInset = UIEdgeInsetsMake(5, 10, 60, 10);
        //去除滑动竖线
        _collectionView.showsVerticalScrollIndicator = NO;
        // 背景颜色
        _collectionView.backgroundColor = ZSColor(234, 234, 234);//ZSColor(255, 255, 204);//[UIColor colorWithHexString:@"#FFFFCC"];
        // 可移动范围
        _collectionView.contentSize = CGSizeMake(0, self.collectionView.frame.size.height +50);
        _collectionView.bounces = NO;
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 注册cell
        [_collectionView registerClass:[JFSCCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        // 注册view
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseID];
        
    }
    return _collectionView;
}

- (UIButton *)searchGoodsBtn
{
    if (!_searchGoodsBtn) {
        _searchGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchGoodsBtn.frame = CGRectMake(5, 15, ScreenWidth-30, 40);
        [_searchGoodsBtn setBackgroundImage:[UIImage imageNamed:@"searchImage"] forState:UIControlStateNormal];
        [_searchGoodsBtn setBackgroundImage:[UIImage imageNamed:@"searchImage"] forState:UIControlStateHighlighted];
        _searchGoodsBtn.layer.borderWidth = 1;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.5, 0.5, 0.5, 0.4});
        _searchGoodsBtn.layer.borderColor = colorref;
        [_searchGoodsBtn addTarget:self action:@selector(searchGoodsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchGoodsBtn;
}

#pragma mark -
#pragma mark - 搜索按钮的点击事件
- (void)searchGoodsBtnClick
{
    ZSLog(@"搜索商品的按钮被点击");
    JFSCSearcGoodshViewController *searchGoodsVC = [[JFSCSearcGoodshViewController alloc] init];
    [self presentViewController:searchGoodsVC animated:YES completion:nil];
}

////图片数组
//- (NSArray *)imageArr
//{
//    if (!_imageArr) {
//        _imageArr = @[@"wine",@"iphone6",@"ipad3",@"U盘",@"相机",@"蛋白粉",@"紫砂壶",@"书"];
//    }
//    return _imageArr;
//}



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
