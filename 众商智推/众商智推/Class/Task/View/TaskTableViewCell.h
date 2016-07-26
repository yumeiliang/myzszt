//
//  TaskTableViewCell.h
//  众商智推
//
//  Created by 杨 on 16/5/5.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskAllModel.h"
#import "UIImageView+WebCache.h"

@interface TaskTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *taskImageView;
@property (strong, nonatomic) UILabel *taskTitle;
@property (strong, nonatomic) UILabel *taskContent;
@property (strong, nonatomic) UILabel *taskMoney;
@property (strong, nonatomic) UILabel *taskAllMoney;
@property (strong, nonatomic) UILabel *taskTime;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie cellWidth:(NSUInteger)cellWidth;
#pragma mark- 调用方法
//给表格cell加载数据
-(void)jiaZaiDataWithModel:(TaskAllModel *)model;



@end
