//
//  LaunchingViewController.m
//  众商智推
//
//  Created by 杨 on 16/6/27.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "LaunchingViewController.h"
#import "ZSTabBarViewController.h"

@interface LaunchingViewController ()

//欢迎界面的背景图
@property (nonatomic, strong) UIImageView *launchingBackgroundImageView;

@end

@implementation LaunchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载背景（默认系统的图片）
    [self.view addSubview:self.launchingBackgroundImageView];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    //有动画效果的欢迎界面
    [UIView animateWithDuration:2 animations:^{
        CGRect rect = _launchingBackgroundImageView.frame;
        rect.origin = CGPointMake(-100, -100);
        rect.size = CGSizeMake(rect.size.width + 200, rect.size.height + 200);
        _launchingBackgroundImageView.frame = rect;
    } completion:^(BOOL finished) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = [[ZSTabBarViewController alloc] init];
    }];
    
    //无动画效果的欢迎界面
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        window.rootViewController = [[ZSTabBarViewController alloc] init];
//    });
    
    
}

#pragma mark - 懒加载
//背景图
- (UIImageView *)launchingBackgroundImageView
{
    if (!_launchingBackgroundImageView) {
        _launchingBackgroundImageView = [[UIImageView alloc] init];
        _launchingBackgroundImageView.frame = self.view.bounds;
        _launchingBackgroundImageView.backgroundColor = [UIColor darkGrayColor];
        _launchingBackgroundImageView.image = [UIImage imageNamed:@"defaultCOver"];
    }
    return _launchingBackgroundImageView;
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
