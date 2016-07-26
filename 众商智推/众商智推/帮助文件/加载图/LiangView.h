//
//  LiangView.h
//  LiangLoading
//
//  Created by ma c on 16/3/2.
//  Copyright © 2016年 sxt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiangView : UIView

//要把loading界面加载到哪个界面之上
+ (void)showLiangViewFromSuperView:(UIView *)superView;
//要把loading界面从哪个界面上移除
+ (void)removeLiangViewFromSuperView:(UIView *)superView;
//要把loading界面加载到哪个界面之上（具体位置多少）
+ (void)showLiangVIewFromSuperView:(UIView *)superView offsetY:(CGFloat)offsetY;

@end
