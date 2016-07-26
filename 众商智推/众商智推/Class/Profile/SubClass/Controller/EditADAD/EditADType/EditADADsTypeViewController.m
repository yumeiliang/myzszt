//
//  EditADADsTypeViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/11.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "EditADADsTypeViewController.h"
#import "TypeOneViewController.h"
#import "TypeTwoViewController.h"
#import "TypeThreeViewController.h"
#import "TypeFourViewController.h"
#import "TypeFiveViewController.h"

@interface EditADADsTypeViewController ()

@end

@implementation EditADADsTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    [self createHeadUI];
    //搭建UI
    [self createContentUI];
}
#pragma mark - 创建顶部View
- (void)createHeadUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headView.backgroundColor = ZSColor(19, 143, 253);
    [self.view addSubview:headView];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //标题按钮
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-60, 25, 120, 40)];
    titleLabel.text = @"广告类型";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
//退出此控制器返回到上级的控制器
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark - 搭建UI
- (void)createContentUI
{
    //提示语Label
    UILabel *tiShiLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 68, 200, 40)];
    tiShiLabel.text = @"请点击选择广告类型";
    tiShiLabel.textAlignment = NSTextAlignmentLeft;
    tiShiLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:tiShiLabel];
    
    for (int i = 0; i < 5; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat margin = 10;
        CGFloat buttonY = i * (90 + margin) + 108;
        button.tag = i;
        button.frame = CGRectMake(10, buttonY, ScreenWidth - 20, 90);
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"type%d",i+1]] forState:UIControlStateNormal];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonClickedMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    
}
- (void)buttonClickedMethod:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            TypeOneViewController *typeOneVC = [[TypeOneViewController alloc] init];
            [self presentViewController:typeOneVC animated:YES completion:nil];
            
        }
            break;
        case 1:
        {
            TypeTwoViewController *typeTwoVC = [[TypeTwoViewController alloc] init];
            [self presentViewController:typeTwoVC animated:YES completion:nil];
        }
            break;
        case 2:
        {
            TypeThreeViewController *typeThreeVC = [[TypeThreeViewController alloc] init];
            [self presentViewController:typeThreeVC animated:YES completion:nil];
        }
            break;
        case 3:
        {
            TypeFourViewController *typeFourVC = [[TypeFourViewController alloc] init];
            [self presentViewController:typeFourVC animated:YES completion:nil];
        }
            break;
        case 4:
        {
            TypeFiveViewController *typeFiveVC = [[TypeFiveViewController alloc] init];
            [self presentViewController:typeFiveVC animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
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
