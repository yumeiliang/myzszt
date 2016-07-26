//
//  ZSZTWebViewController.m
//  众商智推
//
//  Created by 杨 on 16/6/14.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ZSZTWebViewController.h"

@interface ZSZTWebViewController ()

@property (strong, nonatomic) UIWebView *myWebView;

@end

@implementation ZSZTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createHeadUI];
    [self createWebView];
}
#pragma mark -
#pragma mark - 创建顶部View
- (void)createHeadUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 65)];
    headView.backgroundColor = ZSColor(19, 143, 253);
    [self.view addSubview:headView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    //标题Label
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 240, 40)];
    titleLabel.text = @"众商智推--您身边的营销专家！";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark - 创建webview
- (void)createWebView
{
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 65)];
    self.myWebView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.adUrl]]];
    [self.view addSubview:self.myWebView];//http://www.xingyun.cn
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
