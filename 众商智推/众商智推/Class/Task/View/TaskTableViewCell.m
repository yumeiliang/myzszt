//
//  TaskTableViewCell.m
//  众商智推
//
//  Created by 杨 on 16/5/5.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifie cellWidth:(NSUInteger)cellWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifie];
    if (self) {
        CGRect rect = self.frame;
        rect.size.width = cellWidth;
        self.frame = rect;
        [self.contentView addSubview:self.taskImageView];
        [self.contentView addSubview:self.taskTitle];
        [self.contentView addSubview:self.taskContent];
        [self.contentView addSubview:self.taskMoney];
        [self.contentView addSubview:self.taskAllMoney];
        [self.contentView addSubview:self.taskTime];
    }
    return self;
}
#pragma mark -
#pragma mark - 调用方法
-(void)jiaZaiDataWithModel:(TaskAllModel *)model
{
    self.taskTitle.text = model.titleStr;
    self.taskContent.text = model.contentStr;
    [self.taskImageView sd_setImageWithURL:[NSURL URLWithString:model.ImageViewStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    if (![model.integralStr isEqualToString:@"0"]) {
        self.taskMoney.text = [NSString stringWithFormat:@"积分:%@积分",model.integralStr];
    }else{
        self.taskMoney.text = [NSString stringWithFormat:@"任务金额:%@元",model.moneyStr];
    }
    
    self.taskAllMoney.text = [NSString stringWithFormat:@"总预算:%@",model.allMoneyStr];
    self.taskTime.text = [NSString stringWithFormat:@"发布时间:%@",model.timeStr];
}

#pragma 懒加载
- (UIImageView *)taskImageView
{
    if (!_taskImageView) {
        _taskImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 90, 90)];
        //        _taskImageView.backgroundColor = [UIColor brownColor];
        _taskImageView.image = [UIImage imageNamed:@"1.png"];
    }
    return _taskImageView;
}

- (UILabel *)taskTitle
{
    if (!_taskTitle) {
        _taskTitle = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, 200, 30)];
        //        _taskTitle.backgroundColor = [UIColor brownColor];
        _taskTitle.font = [UIFont systemFontOfSize:18];
        _taskTitle.textColor = ZSColor(3, 154, 222);
        _taskTitle.text = @"微信能赚钱了";
    }
    return _taskTitle;
}

- (UILabel *)taskContent
{
    if (!_taskContent) {
        _taskContent = [[UILabel alloc] initWithFrame:CGRectMake(105, 35, self.frame.size.width-110, 20)];
        //        _taskContent.backgroundColor = [UIColor cyanColor];
        _taskContent.font = [UIFont systemFontOfSize:15];
        _taskContent.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        _taskContent.text = @"任务文章--任务文章--任务文章--任务文章--任务文章";
        
    }
    return _taskContent;
}

- (UILabel *)taskMoney
{
    if (!_taskMoney) {
        _taskMoney = [[UILabel alloc] initWithFrame:CGRectMake(105, 60, 105, 20)];
        //        _taskMoney.backgroundColor = [UIColor yellowColor];
        _taskMoney.font = [UIFont systemFontOfSize:13];
        _taskMoney.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        _taskMoney.text = @"任务金额：0.01元";
    }
    return _taskMoney;
}
- (UILabel *)taskAllMoney
{
    if (!_taskAllMoney) {
        _taskAllMoney = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 105, 60, 100, 20)];
        //        _taskAllMoney.backgroundColor = [UIColor brownColor];
        _taskAllMoney.font = [UIFont systemFontOfSize:13];
        _taskAllMoney.textColor = ZSColor(100, 100, 100);
        _taskAllMoney.text = @"总预算：1000元";
        
    }
    return _taskAllMoney;
}
- (UILabel *)taskTime
{
    if (!_taskTime) {
        _taskTime = [[UILabel alloc] initWithFrame:CGRectMake(105, 85, 200, 20)];
        //        _taskTime.backgroundColor = [UIColor redColor];
        _taskTime.font = [UIFont systemFontOfSize:15];
        _taskTime.textColor = ZSColor(100, 100, 100);
        _taskTime.text = @"发布时间：2016年04月11日";
    }
    return _taskTime;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
