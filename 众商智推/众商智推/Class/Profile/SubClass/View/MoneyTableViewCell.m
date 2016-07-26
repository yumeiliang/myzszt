//
//  MoneyTableViewCell.m
//  众商智推
//
//  Created by 杨 on 16/5/9.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "MoneyTableViewCell.h"

@implementation MoneyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellWidth:(NSUInteger)cellWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect rect = self.frame;
        rect.size.width = cellWidth;
        self.frame = rect;
        [self addSubview:self.timeLabel];
        [self addSubview:self.taskMoneyLabel];
    }
    return self;
}


#pragma mark -
#pragma mark - 懒加载
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    }
    return _timeLabel;
}
- (UILabel *)taskMoneyLabel
{
    if (!_taskMoneyLabel) {
        _taskMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 120, 0, 100, 30)];
        _taskMoneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _taskMoneyLabel;
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
