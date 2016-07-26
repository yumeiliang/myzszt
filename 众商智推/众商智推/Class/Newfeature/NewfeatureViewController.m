//
//  NewfeatureViewController.m
//  众商智推
//
//  Created by 杨 on 16/7/8.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "NewfeatureViewController.h"
#import "ZSTabBarViewController.h"

#define WBNewfeatureCount 4

@interface NewfeatureViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation NewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建一个scrollview：显示所有的新特性图片
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = self.view.bounds;
    [self.view addSubview:self.scrollView];
    
    //2.添加图片到scrollView中
    //减少计算次数
    CGFloat scrollW = self.scrollView.width;
    CGFloat scrollH = self.scrollView.height;
    for (int i = 0; i < WBNewfeatureCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.x = i *scrollW;
        imageView.y = 0;
        //显示图片
        NSString *name =[NSString stringWithFormat:@"pic%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        [self.scrollView addSubview:imageView];
        
        //如果是最后一个imageView，就往那个里面添加其他内容
        if (i == WBNewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    //3.设置scrollview的其他属性
    //如果想要某个方向不能滚动，那么这个方向对应的尺寸数值传0即可
    self.scrollView.contentSize = CGSizeMake(WBNewfeatureCount *scrollW, 0);
    self.scrollView.bounces = NO;//去除弹簧效果
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    //4.添加pageControl：分页，展示目前看的是第几页
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = WBNewfeatureCount;
    self.pageControl.backgroundColor = [UIColor redColor];
    self.pageControl.currentPageIndicatorTintColor = ZSColor(253, 98, 42);
    self.pageControl.pageIndicatorTintColor = ZSColor(189, 189, 189);
    self.pageControl.centerX = scrollW * 0.5;
    self.pageControl.centerY = scrollH - 50;
    [self.view addSubview:self.pageControl];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    //四舍五入计算出页码
    self.pageControl.currentPage = (int)(page +0.5);
}

/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */

- (void)setupLastImageView:(UIImageView *)imageView
{
    //开启交互功能
    imageView.userInteractionEnabled = YES;
    // 1.分享给大家（checkbox）
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    //用比例设置位置 相当于直接做 屏幕适配
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // 2.立即使用
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn setTitle:@"立即使用" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
}

- (void)shareClick:(UIButton *)shareBtn
{
    // 状态取反
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[ZSTabBarViewController alloc] init];
}

- (void)dealloc
{
    //当点击立即使用的事件后，新特性的viewcontroller就会被销毁
    ZSLog(@"HWNewfeatureViewController-dealloc");
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
