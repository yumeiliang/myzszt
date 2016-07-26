//
//  UserInfoModel.m
//  众商智推
//
//  Created by 杨 on 16/6/29.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.userNameStr forKey:@"userNameStr"];
    [aCoder encodeObject:self.iconUrlStr forKey:@"iconUrlStr"];
    [aCoder encodeObject:self.userIdStr forKey:@"userIdStr"];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.userNameStr = [aDecoder decodeObjectForKey:@"userNameStr"];
        self.iconUrlStr = [aDecoder decodeObjectForKey:@"iconUrlStr"];
        self.userIdStr = [aDecoder decodeObjectForKey:@"userIdStr"];
    }
    return self;
}


@end
