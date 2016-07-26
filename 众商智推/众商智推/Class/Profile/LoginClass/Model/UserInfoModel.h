//
//  UserInfoModel.h
//  众商智推
//
//  Created by 杨 on 16/6/29.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject<NSCoding>
//用户的昵称
@property (copy, nonatomic) NSString *userNameStr;
//用户的头像
@property (copy, nonatomic) NSString *iconUrlStr;
//用户的id
@property (copy, nonatomic) NSString *userIdStr;


@end
