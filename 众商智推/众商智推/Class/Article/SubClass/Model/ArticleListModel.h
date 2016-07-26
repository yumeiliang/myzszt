//
//  ArticleListModel.h
//  众商智推
//
//  Created by 杨 on 16/5/26.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleListModel : NSObject
//有多少人看过（点击量）
@property (copy, nonatomic) NSString *clicknum;
//标题
@property (copy, nonatomic) NSString *source;
//时间
@property (copy, nonatomic) NSString *time;
//内容
@property (copy, nonatomic) NSString *title;
//图片
@property (copy, nonatomic) NSString *titleimage;
//文章接口
@property (copy, nonatomic) NSString *url;
//排行榜
@property (copy, nonatomic) NSString *rankNum;


//轮播图片
@property (copy, nonatomic) NSString *scrollerImage;
//轮播点击事件
@property (copy, nonatomic) NSString *scrollerClickUrl;
//轮播图片
@property (copy, nonatomic) NSString *scrollerImage2;
//轮播点击事件
@property (copy, nonatomic) NSString *scrollerClickUrl2;


-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
