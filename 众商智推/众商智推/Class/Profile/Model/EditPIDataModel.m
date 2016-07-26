//
//  EditPIDataModel.m
//  众商智推
//
//  Created by 杨 on 16/4/28.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "EditPIDataModel.h"

@implementation EditPIDataModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //用户基本信息
    [aCoder encodeObject:self.nameString forKey:@"nameString"];
    [aCoder encodeObject:self.telephoneString forKey:@"telephoneString"];
    [aCoder encodeObject:self.jobString forKey:@"jobString"];
    [aCoder encodeObject:self.companyString forKey:@"companyString"];
    [aCoder encodeObject:self.qqString forKey:@"qqString"];
    //用户扩展信息
    [aCoder encodeObject:self.emailString forKey:@"emailString"];
    [aCoder encodeObject:self.WXAccountString forKey:@"WXAccountString"];
    [aCoder encodeObject:self.addressString forKey:@"addressString"];
    [aCoder encodeObject:self.focusString forKey:@"focusString"];
    [aCoder encodeObject:self.findString forKey:@"findString"];
    
    //余额体现
    [aCoder encodeObject:self.oldMoneyString forKey:@"oldMoneyString"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        //用户基本信息
        self.nameString = [aDecoder decodeObjectForKey:@"nameString"];
        self.telephoneString = [aDecoder decodeObjectForKey:@"telephoneString"];
        self.jobString = [aDecoder decodeObjectForKey:@"jobString"];
        self.companyString = [aDecoder decodeObjectForKey:@"companyString"];
        self.qqString = [aDecoder decodeObjectForKey:@"qqString"];
        //用户扩展信息
        self.emailString = [aDecoder decodeObjectForKey:@"emailString"];
        self.WXAccountString = [aDecoder decodeObjectForKey:@"WXAccountString"];
        self.addressString = [aDecoder decodeObjectForKey:@"addressString"];
        self.focusString = [aDecoder decodeObjectForKey:@"focusString"];
        self.findString = [aDecoder decodeObjectForKey:@"findString"];
        self.oldMoneyString = [aDecoder decodeObjectForKey:@"oldMoneyString"];
        
    }
    return self;
}

@end
