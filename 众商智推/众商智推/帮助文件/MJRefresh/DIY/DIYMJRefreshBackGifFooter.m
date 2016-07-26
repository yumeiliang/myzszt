//
//  DIYMJRefreshBackGifFooter.m
//  PianKe
//
//  Created by ma c on 15/10/14.
//  Copyright (c) 2015年 DaWei. All rights reserved.
//

#import "DIYMJRefreshBackGifFooter.h"

@implementation DIYMJRefreshBackGifFooter

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    [self setImages:[self refreshIamgesArray] forState:MJRefreshStateRefreshing];
}

//得到刷新图片数组
- (NSArray *)refreshIamgesArray {
    
    NSMutableArray *marr = [NSMutableArray array];
    for (int i = 0; i <= 28; i++) {
        NSString *name = [NSString stringWithFormat:@"refresh%i",i];
        [marr addObject:name];
    }
    NSMutableArray *marrImages = [NSMutableArray array];
    for (NSString *str in marr) {
        
        CGSize size = CGSizeMake(30, 30);
        UIImage *image = [self reSizeImage:[UIImage imageNamed:str] newSize:size];
        [marrImages addObject:image];
    }
    return marrImages;
}

//改变图片的大小
- (UIImage *)reSizeImage:(UIImage *)image newSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    CGRect rect;
    rect.origin = CGPointMake(0, 0);
    rect.size = newSize;
    [image drawInRect:rect];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
