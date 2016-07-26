//
//  MoneyTableViewCell.h
//  众商智推
//
//  Created by 杨 on 16/5/9.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyTableViewCell : UITableViewCell

//时间Label
@property (strong, nonatomic) UILabel *timeLabel;
//任务金额Label
@property (strong, nonatomic) UILabel *taskMoneyLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellWidth:(NSUInteger)cellWidth;

@end
