//
//  JFSCGoodsViewController.h
//  众商智推
//
//  Created by 杨 on 16/6/7.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFSCGoodsViewController : UIViewController
//标题
@property (copy, nonatomic) NSString *titleStr;
//详情的url
@property (strong, nonatomic) NSString *infoUrl;

//图片view
@property (strong, nonatomic) UIImageView *goodsImageView;
//图片的名字
@property (copy, nonatomic) NSString *goodsImageNameStr;
//商品的详情
@property (copy, nonatomic) NSString *goodsInfostr;
//商品的价格
@property (copy, nonatomic) NSString *goodsIntegralStr;

@end
