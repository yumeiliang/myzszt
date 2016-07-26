//
//  JFSCListModel.m
//  众商智推
//
//  Created by 杨 on 16/7/19.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "JFSCListModel.h"

@implementation JFSCListModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        if (![dic[@"id"] isKindOfClass:[NSNull class]]) {
            self.goodID = dic[@"id"];
        }
        if (![dic[@"name"] isKindOfClass:[NSNull class]]) {
            self.goodName = dic[@"name"];
        }
        if (![dic[@"pic"] isKindOfClass:[NSNull class]]) {
            self.goodPic = dic[@"pic"];
        }
        if (![dic[@"price"] isKindOfClass:[NSNull class]]) {
            self.goodPrice = dic[@"price"];
        }
        if (![dic[@"url"] isKindOfClass:[NSNull class]]) {
            self.goodInfoUrl = dic[@"url"];
        }
    }
    return self;
}



@end
