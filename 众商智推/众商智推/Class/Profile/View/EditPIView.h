//
//  EditPIView.h
//  众商智推
//
//  Created by 杨 on 16/4/28.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditPIDataModel.h"

@interface EditPIView : UIView<UITextFieldDelegate>

//昵称
@property (nonatomic, strong) UILabel *nameLabel;
//电话label
@property (nonatomic, strong) UILabel *telephoneLabel;
//职务label
@property (nonatomic, strong) UILabel *jobLabel;
//公司Label
@property (nonatomic, strong) UILabel *companyLabel;
//QQ
@property (strong, nonatomic) UILabel *qqLabel;
//昵称文本框
@property (nonatomic, strong) UITextField *nameTextField;
//电话文本框
@property (nonatomic, strong) UITextField *telephoneTextField;
//职务文本框
@property (nonatomic, strong) UITextField *jobTextField;
//公司文本框
@property (nonatomic, strong) UITextField *companyTextField;
//QQ文本框
@property (strong, nonatomic) UITextField *qqTextField;

@end
