//
//  StatisticTableViewCell.h
//  众商智推
//
//  Created by 杨 on 16/7/20.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleListModel.h"
#import "UIImageView+WebCache.h"

@interface StatisticTableViewCell : UITableViewCell


//图片
@property (strong, nonatomic) UIImageView *allImageView;
//标题
@property (strong, nonatomic) UILabel *allRankLabel;
//内容
@property (strong, nonatomic) UILabel *allContentLabel;
//有多少人看过
@property (strong, nonatomic) UILabel *allNotesLabel;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie cellWidth:(NSUInteger)cellWidth;

#pragma mark- 调用方法
//给表格cell加载数据
-(void)jiaZaiDataWithModel:(ArticleListModel *)model;


@end
