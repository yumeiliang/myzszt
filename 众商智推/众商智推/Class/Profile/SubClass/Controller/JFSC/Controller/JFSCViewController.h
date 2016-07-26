//
//  JFSCViewController.h
//  众商智推
//
//  Created by 杨 on 16/5/5.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFSCViewController : UIViewController
/// 集合视图
@property (strong, nonatomic) UICollectionView *collectionView;
/// 上部分的图片
@property (strong, nonatomic) UIImageView *topImageView;
//搜索商品的Btn
@property (strong, nonatomic) UIButton *searchGoodsBtn;

@end
