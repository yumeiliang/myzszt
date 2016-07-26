//
//  WebViewController.h
//  众商智推
//
//  Created by 杨 on 16/4/15.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleListModel.h"
#import "TaskAllModel.h"

@interface WebViewController : UIViewController

//分享的url
@property (strong, nonatomic) NSString *shareUrl;
//分享按钮
@property (strong, nonatomic) UIButton *shareBtn;

-(void)jiaZaiDataWithModel:(ArticleListModel *)model;
- (void)jiaZaiDataWithTaskModel:(TaskAllModel *)model;

@end
