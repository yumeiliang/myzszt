//
//  TaskAllModel.h
//  众商智推
//
//  Created by 杨 on 16/6/1.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskAllModel : NSObject

//@property (strong, nonatomic) UIImageView *taskImageView;
//@property (strong, nonatomic) UILabel *taskTitle;
//@property (strong, nonatomic) UILabel *taskContent;
//@property (strong, nonatomic) UILabel *taskMoney;
//@property (strong, nonatomic) UILabel *taskAllMoney;
//@property (strong, nonatomic) UILabel *taskTime
//图片
@property (copy, nonatomic) NSString *ImageViewStr;
//标题
@property (copy, nonatomic) NSString *titleStr;
//内容
@property (copy, nonatomic) NSString *contentStr;
//积分
@property (copy, nonatomic) NSString *integralStr;
//任务金额
@property (copy, nonatomic) NSString *moneyStr;
//总预算
@property (copy, nonatomic) NSString *allMoneyStr;
//时间
@property (copy, nonatomic) NSString *timeStr;
//文章接口
@property (copy, nonatomic) NSString *urlStr;

-(instancetype)initWithDictionary:(NSDictionary *)dic;


@end
