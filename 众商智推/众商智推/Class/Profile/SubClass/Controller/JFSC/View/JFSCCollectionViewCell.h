//
//  JFSCCollectionViewCell.h
//  众商智推
//
//  Created by 杨 on 16/5/5.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFSCListModel.h"
#import "UIImageView+WebCache.h"

@interface JFSCCollectionViewCell : UICollectionViewCell

/// 图片
@property (strong, nonatomic) UIImageView *imageView;
/// goodsName
@property (strong, nonatomic) UILabel *goodsNameLabel;
/// 积分
@property (strong, nonatomic) UILabel *integralLabel;

#pragma mark- 调用方法
//给表格cell加载数据
-(void)jiaZaiDataWithModel:(JFSCListModel *)model;

@end
