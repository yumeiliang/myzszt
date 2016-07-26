//
//  EditADViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/28.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "EditADViewController.h"
#import "EditADWeiNameViewController.h"
#import "EditADADsViewController.h"
#import "EditADChangeIconViewController.h"

@interface EditADViewController ()

@end

@implementation EditADViewController

////改变状态栏颜色为白色
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

#pragma mark -
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"profileBackImage.png"]]];
    //加载顶部返回的view
    [self createHeadUI];
    
    //创建三个View
    [self createViewHeight:75 andImage:[UIImage imageNamed:@"微名片"] andTitle:@"微名片" andButtonClickEventName:@selector(weiNameButtonClickEvent)];
    [self createViewHeight:142 andImage:[UIImage imageNamed:@"广告条"] andTitle:@"广告条" andButtonClickEventName:@selector(ADsButtonClickEvent)];
    [self createViewHeight:210 andImage:[UIImage imageNamed:@"换图标"] andTitle:@"换图标" andButtonClickEventName:@selector(changeIconButtonClickEvent)];
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
    titleLabel.text = @"微名片 广告条 换图标";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];

    
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark - 三个view
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
    EditADWeiNameViewController *weiNameVC = [[EditADWeiNameViewController alloc] init];
    [self presentViewController:weiNameVC animated:YES completion:nil];
    
}
- (void)ADsButtonClickEvent
{
    EditADADsViewController *ADsVC = [[EditADADsViewController alloc] init];
    [self presentViewController:ADsVC animated:YES completion:nil];
}
- (void)changeIconButtonClickEvent
{
    EditADChangeIconViewController *changeIconVC = [[EditADChangeIconViewController alloc] init];
    [self presentViewController:changeIconVC animated:YES completion:nil];
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
