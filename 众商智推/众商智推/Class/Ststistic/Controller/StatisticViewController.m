//
//  StatisticViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/8.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "StatisticViewController.h"
#import "StatisticPopularizeViewController.h"
#import "StatisticArticleListViewController.h"


@interface StatisticViewController ()

@end

@implementation StatisticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"profileBackImage.png"]]];
    
    //加载顶部返回的view
    [self createHeadUI];
    
    //创建二个View
    [self createViewHeight:75 andImage:[UIImage imageNamed:@"推广"] andTitle:@"推广记录" andButtonClickEventName:@selector(weiNameButtonClickEvent)];
    [self createViewHeight:142 andImage:[UIImage imageNamed:@"排行"] andTitle:@"文章排行" andButtonClickEventName:@selector(ADsButtonClickEvent)];
    
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
    titleLabel.text = @"统计数据";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark - 二个view
- (void)createViewHeight:(NSUInteger)height andImage:(UIImage*)image andTitle:(NSString*)title andButtonClickEventName:(SEL)buttonClickEventName
{
    UIView *ADView = [[UIView alloc] initWithFrame:CGRectMake(0, height, ScreenWidth, 55)];
    ADView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ADView];
    
    UIButton *ADBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ADBtn.frame = CGRectMake(10, 8, 120, 40);
    [ADBtn setImage:image forState:UIControlStateNormal];
    [ADBtn setTitle:title forState:UIControlStateNormal];
    [ADBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ADBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    ADBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [ADView addSubview:ADBtn];
    
    UIButton *ADRightExtenionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ADRightExtenionBtn.frame = CGRectMake(ScreenWidth - 40, 12, 30, 30);
    [ADRightExtenionBtn setImage:[UIImage imageNamed:@"rightExtension.png"] forState:UIControlStateNormal];
    [ADView addSubview:ADRightExtenionBtn];
    
    UIButton *btnclickEvent = [UIButton buttonWithType:UIButtonTypeCustom];
    btnclickEvent.frame = CGRectMake(0, 0, ScreenWidth, 55);
    btnclickEvent.backgroundColor = [UIColor clearColor];
    [btnclickEvent addTarget:self action:buttonClickEventName forControlEvents:UIControlEventTouchUpInside];
    [ADView addSubview:btnclickEvent];
}
#pragma mark -
#pragma mark - 按钮的点击事件
- (void)weiNameButtonClickEvent
{
    StatisticPopularizeViewController *popularizeVC = [[StatisticPopularizeViewController alloc] init];
    [self presentViewController:popularizeVC animated:YES completion:nil];
    
}
- (void)ADsButtonClickEvent
{
    StatisticArticleListViewController *articleListVC = [[StatisticArticleListViewController alloc] init];
    [self presentViewController:articleListVC animated:YES completion:nil];
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
