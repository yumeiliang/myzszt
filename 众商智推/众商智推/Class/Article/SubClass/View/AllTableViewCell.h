//
//  AllTableViewCell.h
//  众商智推
//
//  Created by 杨 on 16/4/11.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleListModel.h"
#import "UIImageView+WebCache.h"

@interface AllTableViewCell : UITableViewCell

//图片
@property (strong, nonatomic) UIImageView *allImageView;
//标题
@property (strong, nonatomic) UILabel *allTitle;
//内容
@property (strong, nonatomic) UILabel *allContent;
//有多少人看过
@property (strong, nonatomic) UILabel *allNotes;
//时间
@property (strong, nonatomic) UILabel *allTime;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie cellWidth:(NSUInteger)cellWidth;

#pragma mark- 调用方法
//给表格cell加载数据
-(void)jiaZaiDataWithModel:(ArticleListModel *)model;

@end


/*
 #pragma mark - 调用方法
 -(void)jiaZaiDataWithModel:(GoodProductsListModel *)model
 {
 [_goodImageView downloadImage:model.coverimg place:[UIImage imageNamed:@"defaultCover"]];
 
 _goodtitle.text = model.title;
 }

 */