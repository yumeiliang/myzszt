//
//  TaskAllModel.m
//  众商智推
//
//  Created by 杨 on 16/6/1.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "TaskAllModel.h"

@implementation TaskAllModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        if (![dic[@"titleimage"] isKindOfClass:[NSNull class]]) {
            self.ImageViewStr = dic[@"titleimage"];
        }
        if (![dic[@"source"] isKindOfClass:[NSNull class]]) {
            self.titleStr = dic[@"source"];
        }
        if (![dic[@"title"] isKindOfClass:[NSNull class]]) {
            self.contentStr = dic[@"title"];
        }
        if (![dic[@"integral"] isKindOfClass:[NSNull class]]) {
            self.integralStr = dic[@"integral"];
        }
        if (![dic[@"money"] isKindOfClass:[NSNull class]]) {
            self.moneyStr = dic[@"money"];
        }
        if (![dic[@"num"] isKindOfClass:[NSNull class]]) {
            self.allMoneyStr = dic[@"num"];
        }
        if (![dic[@"time"] isKindOfClass:[NSNull class]]) {
            self.timeStr = dic[@"time"];
        }
        if (![dic[@"url"] isKindOfClass:[NSNull class]]) {
            self.urlStr = dic[@"url"];
        }
    }
    return self;
}

@end
