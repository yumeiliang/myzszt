//
//  MoreItem.h
//  有道词典
//
//  Created by ma c on 16/3/11.
//  Copyright © 2016年 梁玉梅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;

@property (assign, nonatomic) Class vcClass;

+(instancetype)itemWithIcon:(NSString*)icon title:(NSString*)title vcClass:(Class)vcClass;

@end
