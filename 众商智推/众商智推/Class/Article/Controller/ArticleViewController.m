//
//  ArticleViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/8.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ArticleViewController.h"
#import "MoreViewController.h"
#import "CityListViewController.h"

#import "ReDianViewController.h"
#import "DuanZiViewController.h"
#import "YangShengViewController.h"
#import "SiFangViewController.h"
#import "DianZanViewController.h"
#import "ShengHuoViewController.h"
#import "CaiJingViewController.h"
#import "QiCheViewController.h"
#import "KeJiViewController.h"
#import "ChaoRenViewController.h"
#import "LaMaViewController.h"
#import "BaGuaViewController.h"
#import "LvXingViewController.h"
#import "ZhiChangViewController.h"
#import "MeiShiViewController.h"
#import "GuJinViewController.h"
#import "XueBaViewController.h"
#import "XingZuoViewController.h"
#import "TiYuViewController.h"

#define SELECTORCITYPATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"selectorCity.txt"]

@interface ArticleViewController ()<UIScrollViewDelegate>
//<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//文字滑动的scrollView
@property (strong, nonatomic) UIScrollView *headerscrollView;
/**标题按钮的文字数组*/
@property (strong, nonatomic) NSMutableArray *titleArray;
/**记录当前选中的按钮*/
@property (strong, nonatomic) UIButton *selectedButton;

//城市列表的按钮
@property (strong, nonatomic) UIButton *cityListBtn;


//顶部使用collectionView的情况
@property (strong, nonatomic) UICollectionView *headTitleCollectView;
@property (strong, nonatomic) UIButton *titleButton;

@end

@implementation ArticleViewController

//顶部使用collectionView的情况
static NSString *reuseID = @"reuseID";
static NSString *cellIdentifier = @"UICollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = [NSMutableArray arrayWithObjects:@"热点", @"段子", @"养生", @"私房", @"点赞", @"生活", @"财经", @"汽车", @"科技", @"潮人", @"辣妈",  @"八卦", @"旅行", @"职场", @"美食", @"古今", @"学霸", @"星座", @"体育", nil];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //创建UI
    [self createUI];
    
    //顶部使用collectionView的情况
//    [self createHeadeCollectView];
    
}

//顶部使用collectionView的情况   没有和页面连接起来
//------------------------------------------------------------------------------------------------
/*
- (void)createHeadeCollectView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 24, ScreenWidth, 60)];
    [self.view addSubview:headerView];
    [headerView addSubview:self.headTitleCollectView];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 1, ScreenWidth, 1)];
    [lineView1 setBackgroundColor:[UIColor lightGrayColor]];
    [headerView addSubview:lineView1];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-105, 1, 1, 59)];
    [lineView setBackgroundColor:[UIColor lightGrayColor]];
    [headerView addSubview:lineView];
    
    //向下扩展按钮
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(ScreenWidth-103, 2, 50, 58);
    //    moreBtn.backgroundColor = [UIColor brownColor];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:[UIImage imageNamed:@"moreBtnImage"] forState:UIControlStateNormal];
    
    moreBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 0);
    [headerView addSubview:moreBtn];
    
    //城市列表按钮
    self.cityListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cityListBtn.frame = CGRectMake(ScreenWidth-55, 2, 55, 58);
    //    searchBtn.backgroundColor = [UIColor cyanColor];
    [self.cityListBtn addTarget:self action:@selector(cityListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:SELECTORCITYPATH];
    NSString *cityStr = [array objectAtIndex:0];
    if (!cityStr) {
        [self.cityListBtn setTitle:@"北京" forState:UIControlStateNormal];
    } else {
        [self.cityListBtn setTitle:cityStr forState:UIControlStateNormal];
    }
    self.cityListBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.cityListBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [headerView addSubview:self.cityListBtn];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 59, ScreenWidth, 1)];
    [lineView2 setBackgroundColor:[UIColor lightGrayColor]];
    [headerView addSubview:lineView2];
    //通知传值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSecrt:) name:@"passValue" object:nil];
}
// 组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 19;
}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 1;
}
// 表格
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
//    cell.contentView.backgroundColor = [UIColor orangeColor];
    self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.titleButton.frame = CGRectMake(0, 0, 50, 50);
    [self.titleButton setTitle:[NSString stringWithFormat:@"%@",[self.titleArray objectAtIndex:indexPath.section]] forState:UIControlStateNormal];
    [self.titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.titleButton setTitleColor:ZSColor(3, 154, 222) forState:UIControlStateSelected];
    self.titleButton.tag = indexPath.section;
    [self.titleButton addTarget:self action:@selector(btnTouched:) forControlEvents:UIControlEventTouchUpInside];
    if (self.titleButton.tag == 0) {
        [self btnTouched:self.titleButton];
    }
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:self.titleButton];
    
    return cell;
}
//返回CollectingviewCell的上下左右偏移
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //顺序依次为上，左，下，右
    return UIEdgeInsetsMake(0, 1, 0, 0);
}
// 单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}
//#warning 选中单元格方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZSLog(@"collectionView被点击了%lu",indexPath.section);
    //         默认第一个被选中
    if (indexPath.section == 0) {
//         self.label.textColor = ZSColor(3, 154, 222);
//        [self buttonBeClicked:button];
    }
//    if (self.label.tag == indexPath.section) {
//        self.label.textColor = ZSColor(3, 154, 222);
//    }
    
//    //19个视图的控制器
//    NSArray *viewControllers = @[@"ReDianViewController", @"DuanZiViewController", @"YangShengViewController", @"SiFangViewController", @"DianZanViewController", @"ShengHuoViewController", @"CaiJingViewController", @"QiCheViewController", @"KeJiViewController", @"ChaoRenViewController", @"LaMaViewController", @"BaGuaViewController", @"LvXingViewController", @"ZhiChangViewController", @"MeiShiViewController", @"GuJinViewController", @"XueBaViewController", @"XingZuoViewController", @"TiYuViewController"];
//    
//    //移除多余的视图
//    if (self.view.subviews.count > 1) {
//        UIView *tempView = (UIView *)self.view.subviews.lastObject;
//        [tempView removeFromSuperview];
//    }
//    //创建新的视图
//    UIViewController *vc = [[NSClassFromString(viewControllers[indexPath.section]) alloc] init];
//    [self addChildViewController:vc];
//    vc.view.frame = CGRectMake(0, 84, ScreenWidth, ScreenHeight-135);
//    [self.view addSubview:vc.view];
    
}

-(void)btnTouched:(UIButton*)sender
{
    // 关于选中的操作
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    //19个视图的控制器
    NSArray *viewControllers = @[@"ReDianViewController", @"DuanZiViewController", @"YangShengViewController", @"SiFangViewController", @"DianZanViewController", @"ShengHuoViewController", @"CaiJingViewController", @"QiCheViewController", @"KeJiViewController", @"ChaoRenViewController", @"LaMaViewController", @"BaGuaViewController", @"LvXingViewController", @"ZhiChangViewController", @"MeiShiViewController", @"GuJinViewController", @"XueBaViewController", @"XingZuoViewController", @"TiYuViewController"];
    
    //移除多余的视图
    if (self.view.subviews.count > 1) {
        UIView *tempView = (UIView *)self.view.subviews.lastObject;
        [tempView removeFromSuperview];
    }
    //创建新的视图
    UIViewController *vc = [[NSClassFromString(viewControllers[sender.tag]) alloc] init];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 84, ScreenWidth, ScreenHeight-135);
    [self.view addSubview:vc.view];

}
 */
//顶部使用collectionView的情况   没有和页面连接起来
//----------------------------------------------------------------------------------------------------

#pragma 创建UI
- (void)createUI
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 24, ScreenWidth, 60)];
//    headerView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [self.view addSubview:headerView];
    [headerView addSubview:self.headerscrollView];
    
    for (int i = 0; i < 19; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:ZSColor(3, 154, 222) forState:UIControlStateNormal];
        [button setTitle:self.titleArray[i] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(buttonBeClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        // 计算button的frame值
        CGFloat margin = 8;
        CGFloat buttonW = 50;
        CGFloat buttonH = 50;
        CGFloat buttonY = 5;
        CGFloat buttonX = i * (buttonW + margin) + margin;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 将button加入到headerView当中
        [self.headerscrollView addSubview:button];
        
//         默认第一个被选中
                if (i == 0) {
                    [self buttonBeClicked:button];
                }
    }
    //横线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 1, ScreenWidth, 1)];
    [lineView1 setBackgroundColor:[UIColor lightGrayColor]];
    [headerView addSubview:lineView1];
    
    //竖线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-110, 1, 1, 59)];
    [lineView setBackgroundColor:[UIColor lightGrayColor]];
    [headerView addSubview:lineView];
    
    //向下扩展按钮
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreBtn.frame = CGRectMake(ScreenWidth-100, 2, 45, 58);
    [self.moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.moreBtn setImage:[UIImage imageNamed:@"moreBtnImage"] forState:UIControlStateNormal];
    self.moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.moreBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 0);
    [headerView addSubview:self.moreBtn];
    
    //城市列表按钮
    self.cityListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cityListBtn.frame = CGRectMake(ScreenWidth-55, 2, 55, 58);
//    searchBtn.backgroundColor = [UIColor cyanColor];
    [self.cityListBtn addTarget:self action:@selector(cityListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:SELECTORCITYPATH];
    NSString *cityStr = [array objectAtIndex:0];
    if (!cityStr) {
        [self.cityListBtn setTitle:@"北京" forState:UIControlStateNormal];
    } else {
    [self.cityListBtn setTitle:cityStr forState:UIControlStateNormal];
    }
    self.cityListBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.cityListBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [cityListBtn setImage:[UIImage imageNamed:@"serachBtnImage"] forState:UIControlStateNormal];
//    cityListBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 5, 10, 10);
    [headerView addSubview:self.cityListBtn];
    
    //横线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 59, ScreenWidth, 1)];
    [lineView2 setBackgroundColor:[UIColor lightGrayColor]];
    [headerView addSubview:lineView2];
    
    //通知传值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getChangeCity:) name:@"passCityValue" object:nil];
    
}
//通知传值的方法
- (void)getChangeCity:(NSNotification*)notification
{
    if ([notification.object isKindOfClass:[NSString class]]) {
        [self.cityListBtn setTitle:notification.object forState:UIControlStateNormal];
        
        //保存用户选择的城市
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:SELECTORCITYPATH];//将沙盒路径下的归档对象解档出来
        if (array == nil) {
            array = [NSMutableArray array];
        }
        [array insertObject:notification.object atIndex:0];
        
        ZSLog(@"%@",array);
        
        //把刚才写的数组存到沙盒当中去
        if ([NSKeyedArchiver archiveRootObject:array toFile:SELECTORCITYPATH]) {
            ZSLog(@"保存成功");
//            [self changeShowCity];
        }else{
            ZSLog(@"保存失败");
        }
        
        ZSLog(@"%@",SELECTORCITYPATH);
        NSArray *list = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:SELECTORCITYPATH];
        ZSLog(@"%@",list);
    }
    
}

- (void)changeShowCity
{
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:SELECTORCITYPATH];
    NSString *cityStr = [array objectAtIndex:0];
    [self.cityListBtn setTitle:cityStr forState:UIControlStateNormal];
}

#pragma BUtton按钮的关联方法
//向下扩展按钮
-(void)moreBtnClick
{
    ZSLog(@"moreBtn按钮被点击了！！！");

    MoreViewController *moreVC = [[MoreViewController alloc] init];
    moreVC.view.frame = CGRectMake(0, 84, ScreenWidth, 500);
    [self addChildViewController:moreVC];
    [self.view addSubview:moreVC.view];
    
    //否则就能连续点击，加载出多个界面
//    if (self.view.subviews.count > 3) {
//        UIView *tempView = (UIView *)self.view.subviews.lastObject;
//        [tempView removeFromSuperview];
//    }
}
//搜索按钮
-(void)cityListBtnClick:(UIButton *)sender
{
//    sender.selected=!sender.selected;
    ZSLog(@"城市列表按钮被点击了！！！");
    CityListViewController *cityListVC = [[CityListViewController alloc] init];
    [self presentViewController:cityListVC animated:YES completion:nil];
}
// headerView中按钮关联的方法
- (void)buttonBeClicked:(UIButton *)sender
{
    // 关于选中的操作
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    //19个视图的控制器
    NSArray *viewControllers = @[@"ReDianViewController", @"DuanZiViewController", @"YangShengViewController", @"SiFangViewController", @"DianZanViewController", @"ShengHuoViewController", @"CaiJingViewController", @"QiCheViewController", @"KeJiViewController", @"ChaoRenViewController", @"LaMaViewController", @"BaGuaViewController", @"LvXingViewController", @"ZhiChangViewController", @"MeiShiViewController", @"GuJinViewController", @"XueBaViewController", @"XingZuoViewController", @"TiYuViewController"];
    
    //移除多余的视图
    if (self.view.subviews.count > 1) {
        UIView *tempView = (UIView *)self.view.subviews.lastObject;
        [tempView removeFromSuperview];
    }
    //创建新的视图
    UIViewController *vc = [[NSClassFromString(viewControllers[sender.tag]) alloc] init];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 84, ScreenWidth, ScreenHeight-135);
    [self.view addSubview:vc.view];
//    [self addChildViewController:vc];
    
//    [self presentViewController:vc animated:YES completion:nil];

}

#warning 跳转-------------------------------------
//--------------------------控制跳转的方法----------------------------
- (void)jumpViewController:(UIButton *)tempButton
{
    // 关于选中的操作
    self.selectedButton.selected = NO;
    tempButton.selected = YES;
    self.selectedButton = tempButton;
    //19个视图的控制器
    NSArray *viewControllers = @[@"ReDianViewController", @"DuanZiViewController", @"YangShengViewController", @"SiFangViewController", @"DianZanViewController", @"ShengHuoViewController", @"CaiJingViewController", @"QiCheViewController", @"KeJiViewController", @"ChaoRenViewController", @"LaMaViewController", @"BaGuaViewController", @"LvXingViewController", @"ZhiChangViewController", @"MeiShiViewController", @"GuJinViewController", @"XueBaViewController", @"XingZuoViewController", @"TiYuViewController"];
    
    //创建新的视图
    UIViewController *vc = [[NSClassFromString(viewControllers[tempButton.tag]) alloc] init];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 84, ScreenWidth, ScreenHeight-135);
    [self.view addSubview:vc.view];
    
}

#pragma 懒加载
//滚动字体的滑动视图
- (UIScrollView *)headerscrollView
{
    if (!_headerscrollView) {
        _headerscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 60)];
        _headerscrollView.backgroundColor = [UIColor whiteColor];
        _headerscrollView.delegate = self;
//        _headerscrollView.pagingEnabled = YES;
//        _headerscrollView.bounces = NO;
        _headerscrollView.showsHorizontalScrollIndicator = NO;
        _headerscrollView.showsVerticalScrollIndicator = NO;
        //偏移量
//        _scrollView.contentOffset = CGPointMake(0, 0);
        _headerscrollView.contentSize = CGSizeMake(1118, 0);
        
    }
    return _headerscrollView;
}

- (UICollectionView *)headTitleCollectView
{
    if (!_headTitleCollectView) {
        
        // 布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        // 初始化
        _headTitleCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 120, 60) collectionViewLayout:layout];
        // 背景颜色
        _headTitleCollectView.backgroundColor = [UIColor whiteColor];
        // _headTitleCollectView移动范围
        _headTitleCollectView.contentSize = CGSizeMake(1118, 0);
        _headTitleCollectView.showsHorizontalScrollIndicator = NO;
        // 设置代理
        _headTitleCollectView.delegate = self;
        _headTitleCollectView.dataSource = self;
        // 注册cell
        [_headTitleCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        // 注册view
        [_headTitleCollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseID];
    }
    return _headTitleCollectView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 //    //模态方法进入       //
 //    secondVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;    //翻页
 //    [self presentViewController:secondVC animated:YES completion:nil];
 
 //方法进入
 [self.view addSubview:secondVC.view];
 [self addChildViewController:secondVC];
 
 //    //模态方法跳出
 //    [self dismissViewControllerAnimated:YES completion:nil];
 
 //方法跳出
 [self.view removeFromSuperview];
 [self removeFromParentViewController];
 
 */


@end
