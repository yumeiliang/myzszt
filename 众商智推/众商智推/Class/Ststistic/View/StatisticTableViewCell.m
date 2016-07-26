//
//  StatisticTableViewCell.m
//  众商智推
//
//  Created by 杨 on 16/7/20.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "StatisticTableViewCell.h"

@implementation StatisticTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifie cellWidth:(NSUInteger)cellWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifie];
    if (self) {
        CGRect rect = self.frame;
        rect.size.width = cellWidth;
        self.frame = rect;
        [self.contentView addSubview:self.allImageView];
        [self.contentView addSubview:self.allRankLabel];
        [self.contentView addSubview:self.allContentLabel];
        [self.contentView addSubview:self.allNotesLabel];
    }
    return self;
}
#pragma mark -
#pragma mark - 调用方法
-(void)jiaZaiDataWithModel:(ArticleListModel *)model
{
    self.allRankLabel.text = model.rankNum;
    self.allContentLabel.text = model.title;
    [self.allImageView sd_setImageWithURL:[NSURL URLWithString:model.titleimage] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.allNotesLabel.text = [NSString stringWithFormat:@"浏览量%@",model.clicknum];
}
#pragma mark -
#pragma mark - 懒加载
- (UILabel *)allRankLabel
{
    if (!_allRankLabel) {
        _allRankLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 30, 30)];
        _allRankLabel.text = @"1";
        _allRankLabel.font = [UIFont systemFontOfSize:18];
        _allRankLabel.textColor = [UIColor blackColor];
    }
    return _allRankLabel;
}
- (UIImageView *)allImageView
{
    if (!_allImageView) {
        _allImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 10, 80, 80)];
        _allImageView.image = [UIImage imageNamed:@"placeholder.png"];
        _allImageView.layer.cornerRadius = 40;
        _allImageView.layer.masksToBounds = YES;
    }
    return _allImageView;
}
- (UILabel *)allContentLabel
{
    if (!_allContentLabel) {
        _allContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 40, self.frame.size.width - 145, 30)];
        //        _allContent.backgroundColor = [UIColor yellowColor];
        _allContentLabel.text = @"众商智推众商智推众商智推众商智推众商智推众商智推";
        _allContentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _allContentLabel;
}
- (UILabel *)allNotesLabel
{
    if (!_allNotesLabel) {
        _allNotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-105, 75, 90, 30)];
        //        _allNotes.backgroundColor = [UIColor orangeColor];
        _allNotesLabel.text = @"浏览量8764";
        _allNotesLabel.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        _allNotesLabel.font = [UIFont systemFontOfSize:13];
    }
    return _allNotesLabel;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
