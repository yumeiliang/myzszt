//
//  JFSCCollectionViewCell.m
//  众商智推
//
//  Created by 杨 on 16/5/5.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "JFSCCollectionViewCell.h"

@interface JFSCCollectionViewCell ()

///// 图片
//@property (strong, nonatomic) UIImageView *imageView;
///// goodsName
//@property (strong, nonatomic) UILabel *goodsNameLabel;
///// 积分
//@property (strong, nonatomic) UILabel *integralLabel;

@end

@implementation JFSCCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.goodsNameLabel];
        [self.contentView addSubview:self.integralLabel];
    }
    return self;
}
#pragma mark -
#pragma mark - 调用方法
-(void)jiaZaiDataWithModel:(JFSCListModel *)model
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.goodPic] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.goodsNameLabel.text = model.goodName;
    self.integralLabel.text = model.goodPrice;
}

#pragma mark ----------------------- 懒加载
// 图片
- (UIImageView *)imageView
{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth *0.397, 170)];
//        _imageView.backgroundColor = [UIColor cyanColor];
//        _imageView.image = [UIImage imageNamed:@"wine"];
    }
    return _imageView;
}
//goodsNameLabel
- (UILabel *)goodsNameLabel
{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 182,ScreenWidth *0.397, 40)];
//        _goodsNameLabel.backgroundColor = [UIColor redColor];
        _goodsNameLabel.textColor = [UIColor grayColor];
        //自动换行
        _goodsNameLabel.numberOfLines = 0;
        // 大小
        _goodsNameLabel.font = [UIFont systemFontOfSize:15];
        // 对齐方式
        _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsNameLabel;
}
//积分
- (UILabel *)integralLabel
{
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, ScreenWidth *0.397, 40)];
//        _integralLabel.backgroundColor = [UIColor brownColor];
        _integralLabel.textColor = ZSColor(173, 209, 62);
        // 字体大小
        _integralLabel.font = [UIFont systemFontOfSize:20];
        _integralLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _integralLabel;
}




@end
