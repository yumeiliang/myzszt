//
//  ZSTabBarViewController.m
//  众商智推
//
//  Created by 杨 on 16/6/27.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ZSTabBarViewController.h"
#import "ArticleViewController.h"
#import "TaskViewController.h"
#import "ProfileViewController.h"
#import "JFSCViewController.h"


@interface ZSTabBarViewController ()

@end

@implementation ZSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    b.创建子控制器
    ArticleViewController *c1=[[ArticleViewController alloc]init];
    c1.tabBarItem.title=@"文章";
//    c1.tabBarItem.badgeValue = @"123";
    c1.tabBarItem.image=[UIImage imageNamed:@"footer_icon1.png"];
    
    JFSCViewController *c2 = [[JFSCViewController alloc] init];
    c2.tabBarItem.title=@"商城";
    c2.tabBarItem.image=[UIImage imageNamed:@"footer_icon2.png"];
    
    TaskViewController *c3=[[TaskViewController alloc]init];
    c3.tabBarItem.title=@"任务";
    c3.tabBarItem.image=[UIImage imageNamed:@"footer_icon3.png"];
    
    ProfileViewController *c4=[[ProfileViewController alloc]init];
    c4.tabBarItem.title=@"我的";
    c4.tabBarItem.image=[UIImage imageNamed:@"footer_icon4.png"];

    //添加为子控制器
    [self addChildViewController:c1];
    [self addChildViewController:c2];
    [self addChildViewController:c3];
    [self addChildViewController:c4];
    
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
