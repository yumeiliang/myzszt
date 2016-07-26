//
//  EditPIExtensionView.h
//  众商智推
//
//  Created by 杨 on 16/4/28.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface EditPIExtensionView : UIView<UITextFieldDelegate>

//电子信箱Label
@property (nonatomic, strong) UILabel *emailLabel;
//微信账号Label
@property (nonatomic, strong) UILabel *WXAccountLabel;
//详细地址label
@property (nonatomic, strong) UILabel *addressLabel;
//我专注Label
@property (nonatomic, strong) UILabel *focusLabel;
//我在找Label
@property (nonatomic, strong) UILabel *findLabel;
//电子信箱文本框
@property (nonatomic, strong) UITextField *emailTextField;
//微信账号文本框
@property (nonatomic, strong) UITextField *WXAccountTextField;
//详细地址文本框
@property (nonatomic, strong) UITextField *addressTextField;
//我专注文本框
@property (nonatomic, strong) UITextField *focusTextField;
//我在找文本框
@property (nonatomic, strong) UITextField *findTextField;




@end
