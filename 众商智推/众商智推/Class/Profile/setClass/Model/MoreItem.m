//
//  MoreItem.m
//  有道词典
//
//  Created by ma c on 16/3/11.
//  Copyright © 2016年 梁玉梅. All rights reserved.
//

#import "MoreItem.h"

@implementation MoreItem

+(instancetype)itemWithIcon:(NSString*)icon title:(NSString*)title vcClass:(Class)vcClass
{
    MoreItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.vcClass = vcClass;
    return item;
}

@end
