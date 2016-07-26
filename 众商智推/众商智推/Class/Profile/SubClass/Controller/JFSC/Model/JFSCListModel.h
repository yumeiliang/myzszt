//
//  JFSCListModel.h
//  众商智推
//
//  Created by 杨 on 16/7/19.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFSCListModel : NSObject

//id
@property (copy, nonatomic) NSString *goodID;
//商品名称
@property (copy, nonatomic) NSString *goodName;
//商品的图片接口
@property (copy, nonatomic) NSString *goodPic;
//商品的价格
@property (copy, nonatomic) NSString *goodPrice;
//商品的详情
@property (copy, nonatomic) NSString *goodInfoUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dic;


@end
