//
//  LiangView.m
//  LiangLoading
//
//  Created by ma c on 16/3/2.
//  Copyright © 2016年 sxt. All rights reserved.
//

#import "LiangView.h"

@interface LiangView ()

//动态图
@property (strong, nonatomic) UIImageView *loadingImageView;
//提示文字
@property (strong, nonatomic) UILabel *toastLabel;


@end

@implementation LiangView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.loadingImageView];
        [self addSubview:self.toastLabel];
    }
    return self;
}

#pragma mark - 懒加载

- (UIImageView *)loadingImageView
{
    if (!_loadingImageView) {
        _loadingImageView = [[UIImageView alloc] init];
        _loadingImageView.frame = CGRectMake(0, 0, 80, 80);
        _loadingImageView.backgroundColor = [UIColor clearColor];
        _loadingImageView.animationImages = [self getImageArray];
        _loadingImageView.animationDuration = 2.0;
        _loadingImageView.animationRepeatCount = 0;
    }
    return _loadingImageView;
}
- (NSArray *)getImageArray
{
    //获取图片名称
    
    NSMutableArray *imageNameArr = [NSMutableArray array];
    for (int i = 1; i < 16; i++) {
        NSString *imageName;
        if (i < 10) {
            imageName = [NSString stringWithFormat:@"loading_animate_0%d",i];
        }else{
            imageName = [NSString stringWithFormat:@"loading_animate_%d",i];
        }
//        [imageNameArr addObject:imageName];
        UIImage *image = [UIImage imageNamed:imageName];
        [imageNameArr addObject:image];
        
    }
//    NSLog(@"%@",imageNameArr);
    
//    
//    //获取图片数组
//    NSMutableArray *imageArr = [NSMutableArray array];
//    for (int i =0 ; i < 15; i ++) {
//        NSString *imageName = [imageNameArr objectAtIndex:i];
////        NSLog(@"获取图片名称:%@",imageName);
//        UIImage *image = [UIImage imageNamed:imageName];
//        [imageArr addObject:image];
//    }
//    return imageArr;
    
    return imageNameArr;
    
}

- (UILabel *)toastLabel
{
    if (!_toastLabel) {
        _toastLabel = [[UILabel alloc] init];
        _toastLabel.frame = CGRectMake(0, 90, 80, 30);
        _toastLabel.text = @"正在加载，请稍后!!!";
        _toastLabel.textColor = [UIColor darkGrayColor];
        _toastLabel.font = [UIFont systemFontOfSize:14];
        _toastLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _toastLabel;
}

#pragma mark - 接口方法
//要把loading界面加载到哪个界面之上
+ (void)showLiangViewFromSuperView:(UIView *)superView
{
    //既然调用本接口没有调用扩展接口，就说明用户默认居中显示loadView这个界面
    [self showLiangVIewFromSuperView:superView offsetY:0];
}
//要把loading界面从哪个界面上移除
+ (void)removeLiangViewFromSuperView:(UIView *)superView
{
    //在父视图的【所有子视图数组】当中查找
    for (UIView *itemView in superView.subviews) {
        //将它从父视图当中移除
        if ([itemView isKindOfClass:[LiangView class]]) {
            [itemView removeFromSuperview];
        }
    }
}
//要把loading界面加载到哪个界面之上（具体位置多少）
+ (void)showLiangVIewFromSuperView:(UIView *)superView offsetY:(CGFloat)offsetY
{
    LiangView *loadingView = [[LiangView alloc] init];
    loadingView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, [UIScreen mainScreen].bounds.size.height/2-40+offsetY, 80, 60);
    //判断superView上是否已经存在一个LiangView
    
    //如果已经存在，那么闲删除这个LiangView，再加载新的View
    [self removeLiangViewFromSuperView:superView];
    [superView addSubview:loadingView];
    //让动态图动起来
    [loadingView.loadingImageView startAnimating];
    
}



@end
