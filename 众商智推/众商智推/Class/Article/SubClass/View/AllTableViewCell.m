//
//  AllTableViewCell.m
//  众商智推
//
//  Created by 杨 on 16/4/11.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "AllTableViewCell.h"

@implementation AllTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifie cellWidth:(NSUInteger)cellWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifie];
    if (self) {
        CGRect rect = self.frame;
        rect.size.width = cellWidth;
        self.frame = rect;
        [self.contentView addSubview:self.allImageView];
        [self.contentView addSubview:self.allTitle];
        [self.contentView addSubview:self.allContent];
        [self.contentView addSubview:self.allNotes];
        [self.contentView addSubview:self.allTime];
    }
    return self;
}
#pragma mark -
#pragma mark - 调用方法
-(void)jiaZaiDataWithModel:(ArticleListModel *)model
{
    self.allTitle.text = model.source;
    self.allContent.text = model.title;
    [self.allImageView sd_setImageWithURL:[NSURL URLWithString:model.titleimage] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.allTime.text = model.time;
    self.allNotes.text = [NSString stringWithFormat:@"%@人看过",model.clicknum];
}
#pragma mark -
#pragma mark - 懒加载
- (UIImageView *)allImageView
{
    if (!_allImageView) {
        _allImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 90, 90)];
//        _allImageView.backgroundColor = [UIColor brownColor];
        _allImageView.image = [UIImage imageNamed:@"placeholder.png"];
    }
    return _allImageView;
}
- (UILabel *)allTitle
{
    if (!_allTitle) {
        _allTitle = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, 200, 30)];
//        _allTitle.backgroundColor = [UIColor cyanColor];
        _allTitle.text = @"众商智推";
        _allTitle.font = [UIFont systemFontOfSize:18];
        _allTitle.textColor = ZSColor(3, 154, 222);
    }
    return _allTitle;
}
- (UILabel *)allContent
{
    if (!_allContent) {
        _allContent = [[UILabel alloc] initWithFrame:CGRectMake(105, 40, self.frame.size.width - 120, 30)];
//        _allContent.backgroundColor = [UIColor yellowColor];
        _allContent.text = @"众商智推众商智推众商智推众商智推众商智推众商智推";
        _allContent.font = [UIFont systemFontOfSize:15];
    }
    return _allContent;
}
- (UILabel *)allNotes
{
    if (!_allNotes) {
        _allNotes = [[UILabel alloc] initWithFrame:CGRectMake(105, 75, 120, 30)];
//        _allNotes.backgroundColor = [UIColor orangeColor];
        _allNotes.text = @"8764人看过";
        _allNotes.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        _allNotes.font = [UIFont systemFontOfSize:13];
    }
    return _allNotes;
}
- (UILabel *)allTime
{
    if (!_allTime) {
        _allTime = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-105, 75, 90, 30)];
//        _allTime.backgroundColor = [UIColor grayColor];
        _allTime.text = @"2016-04-11";
        _allTime.textAlignment = NSTextAlignmentRight;
        _allTime.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        _allTime.font = [UIFont systemFontOfSize:13];
    }
    return _allTime;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
