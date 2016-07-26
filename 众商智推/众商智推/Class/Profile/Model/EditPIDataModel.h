//
//  EditPIDataModel.h
//  众商智推
//
//  Created by 杨 on 16/4/28.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditPIDataModel : NSObject<NSCoding>
//用户名String
@property (copy, nonatomic) NSString *nameString;
//用户电话String
@property (copy, nonatomic) NSString *telephoneString;
//用户职务String
@property (copy, nonatomic) NSString *jobString;
//用户公司String
@property (copy, nonatomic) NSString *companyString;
//用户QQ
@property (copy, nonatomic) NSString *qqString;

//电子信箱String
@property (copy, nonatomic) NSString *emailString;
//微信账号String
@property (copy, nonatomic) NSString *WXAccountString;
//详细地址String
@property (copy, nonatomic) NSString *addressString;
//我专注String
@property (copy, nonatomic) NSString *focusString;
//我在找String
@property (copy, nonatomic) NSString *findString;
//余额体现的钱
@property (copy, nonatomic) NSString *oldMoneyString;


@end
