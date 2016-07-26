//
//  AboutUsViewController.m
//  有道词典
//
//  Created by 杨 on 16/7/5.
//  Copyright © 2016年 梁玉梅. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UIScrollViewDelegate>

//整体的scrollView
@property (strong, nonatomic) UIScrollView *allScrollView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self createHeadUI];
    
    [self createContentControls];
    
}

#pragma mark - 创建顶部View
- (void)createHeadUI
{
    //整体滑动的scrollView
    [self.view addSubview:self.allScrollView];
    
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
    titleLabel.text = @"关于我们";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    [headView addSubview:titleLabel];
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createContentControls
{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 26, 140, 50)];
    label1.text = @"众商智推";
    label1.font = [UIFont boldSystemFontOfSize:30];
    [self.allScrollView addSubview:label1];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(80, 66, 200, 40)];
    label3.text = @"http://zt.wzswx.com";
    label3.font = [UIFont systemFontOfSize:20];
    [self.allScrollView addSubview:label3];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 106, self.view.frame.size.width - 30, 280)];
    label2.text = @"    众商科技是一家专注互联网产业链综合应用商业化运作的公司。总部位于首都北京亦庄国家级经济开发区，旗下拥有多款掀起行业改革浪潮的全新力作 。公司主要团队来自于百度/腾讯/谷歌/新浪等知名企业的资深互联网实力务实派80后。历经多年精耕细作，结合我国当前商业经济的发展，推出了前瞻性的互联网与自媒体商业化运作解决方案，让每一个人轻松进入自媒体与电商营销行业，让更多的人拥有属于自己的广告位，让做广告不再求人！  旗下拥有微众商、微众商企业版、众商智推、众商智推商户版等！";
    label2.numberOfLines = 0;
//    label2.backgroundColor = [UIColor cyanColor];
    [self.allScrollView addSubview:label2];
    
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 396, 140, 50)];
    label4.text = @"版权信息";
    label4.font = [UIFont systemFontOfSize:20];
    [self.allScrollView addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, 476, 300, 40)];
    label5.textColor = [UIColor grayColor];
    label5.text = @"Copyright©2006-2016";
    label5.textAlignment = NSTextAlignmentCenter;
    label5.font = [UIFont systemFontOfSize:20];
    [self.allScrollView addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, 506, 300, 40)];
    label6.text = @"北京众商科技有限公司";
    label6.textColor = [UIColor grayColor];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.font = [UIFont systemFontOfSize:20];
    [self.allScrollView addSubview:label6];
    
}

#pragma mark -
#pragma mark - 懒加载
//背景轮播图
- (UIScrollView *)allScrollView
{
    if (!_allScrollView) {
        _allScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
        _allScrollView.delegate = self;
        _allScrollView.showsVerticalScrollIndicator = NO;
        _allScrollView.contentSize = CGSizeMake(0, 620);
    }
    return _allScrollView;
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
