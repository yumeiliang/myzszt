//
//  MoreViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/8.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "MoreViewController.h"
#import "ArticleViewController.h"

@interface MoreViewController ()

@property (strong, nonatomic) NSMutableArray *titleArray;

@property (strong, nonatomic) UIButton *tempButton;

@end

@implementation MoreViewController

//？？？？
//+(MoreViewController*)share
//{
//    static MoreViewController *tempcontroller =nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        tempcontroller = [[MoreViewController alloc] init];
//    });
//    return tempcontroller;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景颜色
    [self.view setBackgroundColor:ZSColor(232, 232, 232)];
    
    //创建UI
    [self createUI];
    
}
//创建UI
- (void)createUI
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel *allLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 120, 47)];
    allLabel.text = @"全部频道";
    allLabel.textColor = ZSColor(60, 183, 240);
    allLabel.font = [UIFont systemFontOfSize:25];
    [headerView addSubview:allLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 48, 120, 3)];
    lineLabel.backgroundColor = ZSColor(60, 183, 240);
    [headerView addSubview:lineLabel];
    
    //选择按钮
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(ScreenWidth-70, 0, 55, 50);
//        selectBtn.backgroundColor = [UIColor brownColor];
//    [selectBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setImage:[UIImage imageNamed:@"selectBtnImage"] forState:UIControlStateNormal];
    selectBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 0);
    selectBtn.enabled = NO;
    [headerView addSubview:selectBtn];
   
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 250, 40)];
    textLabel.text = @"点击即可进入当前分类频道";
    textLabel.textColor = ZSColor(150, 150, 150);
    textLabel.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:textLabel];
    
    self.titleArray = [NSMutableArray arrayWithObjects:@"热点", @"段子", @"养生", @"私房", @"点赞", @"生活", @"财经", @"汽车", @"科技", @"潮人", @"辣妈",  @"八卦", @"旅行", @"职场", @"美食", @"古今", @"学霸", @"星座", @"体育", @"添加"  , nil];
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 300)];
    //    buttonView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:buttonView];
    
    int n = 0,m = -1;
    for (int j = 0; j < 5; j ++) {
        
        for (int i = 0; i < 4; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:[self.titleArray objectAtIndex:n++] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:20];
            button.backgroundColor = [UIColor whiteColor];
            button.tag = ++m;
            [button addTarget:self action:@selector(buttonBeClickedMethod:) forControlEvents:UIControlEventTouchUpInside];
            
            // 计算button的frame值
            CGFloat margin = 10;
            CGFloat buttonW = (self.view.frame.size.width-50)/4;
            CGFloat buttonH = 50;
            CGFloat buttonY = j * (buttonH + margin) + 10;
            CGFloat buttonX = i * (buttonW + margin) + margin;
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            [buttonView addSubview:button];
            self.tempButton = button;
            
            //隐藏第二十个按钮
            if (m == 19) {
                button.hidden = YES;
            }
        }
    }
    
//    退出按钮
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeBtn.frame = CGRectMake(self.view.frame.size.width/2- 30, 390, 60, 60);
//    removeBtn.backgroundColor = [UIColor brownColor];
    [removeBtn addTarget:self action:@selector(removeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [removeBtn setImage:[UIImage imageNamed:@"removeBtnImage"] forState:UIControlStateNormal];
    removeBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.view addSubview:removeBtn];
}


#pragma 按钮的点击事件
- (void)buttonBeClickedMethod:(UIButton *)tempButton
{
    [self removeBtnClick];
    //根据点击的按钮  返回到对应的viewcontroller
    ArticleViewController *articleVC = [[ArticleViewController alloc] init];
    articleVC.moreBtn.enabled = YES;
    [articleVC jumpViewController:tempButton];
}
- (void)removeBtnClick
{
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
