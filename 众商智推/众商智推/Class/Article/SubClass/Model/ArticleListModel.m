//
//  ArticleListModel.m
//  众商智推
//
//  Created by 杨 on 16/5/26.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ArticleListModel.h"

@implementation ArticleListModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        if (![dic[@"clicknum"] isKindOfClass:[NSNull class]]) {
            self.clicknum = dic[@"clicknum"];
        }
        if (![dic[@"source"] isKindOfClass:[NSNull class]]) {
            self.source = dic[@"source"];
        }
        if (![dic[@"time"] isKindOfClass:[NSNull class]]) {
            self.time = dic[@"time"];
        }
        if (![dic[@"title"] isKindOfClass:[NSNull class]]) {
            self.title = dic[@"title"];
        }
        if (![dic[@"titleimage"] isKindOfClass:[NSNull class]]) {
            self.titleimage = dic[@"titleimage"];
        }
        if (![dic[@"url"] isKindOfClass:[NSNull class]]) {
            self.url = dic[@"url"];
        }
        if (![dic[@"rankNum"] isKindOfClass:[NSNull class]]) {
            self.rankNum = dic[@"rankNum"];
        }
        if (![dic[@"Carouselpic"] isKindOfClass:[NSNull class]]) {
            self.scrollerImage = dic[@"Carouselpic"];
        }
        if (![dic[@"Carouselurl"] isKindOfClass:[NSNull class]]) {
            self.scrollerClickUrl = dic[@"Carouselurl"];
        }
        if (![dic[@"Carouselpic2"] isKindOfClass:[NSNull class]]) {
            self.scrollerImage2 = dic[@"Carouselpic2"];
        }
        if (![dic[@"Carouselurl2"] isKindOfClass:[NSNull class]]) {
            self.scrollerClickUrl2 = dic[@"Carouselurl2"];
        }
        
    }
    return self;
}


@end
