//
//  EditPIExtensionView.m
//  众商智推
//
//  Created by 杨 on 16/4/28.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "EditPIExtensionView.h"
#import "EditPIDataModel.h"

@interface EditPIExtensionView ()

@property (strong, nonatomic) EditPIDataModel *editPIDataModel;

@end

@implementation EditPIExtensionView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //获取沙盒中存取的数据信息
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"regist.txt"];//当前应用的沙盒路径
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        self.editPIDataModel = [array objectAtIndex:0];
        //用户基本信息
        [self addSubview:self.emailLabel];
        [self addSubview:self.WXAccountLabel];
        [self addSubview:self.addressLabel];
        [self addSubview:self.focusLabel];
        [self addSubview:self.findLabel];
        //用户扩展信息
        [self addSubview:self.emailTextField];
        [self addSubview:self.WXAccountTextField];
        [self addSubview:self.addressTextField];
        [self addSubview:self.focusTextField];
        [self addSubview:self.findTextField];
        [self addAutoLayout];
    }
    return self;
    
}

#pragma mark - 自动布局
#pragma mark - 自动适配
-(void)addAutoLayout
{
    WS(weakSelf);
    //电子邮箱
    [_emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.top.equalTo(weakSelf.mas_top).offset(25);
        //        make.centerY.equalTo(weakSelf.mas_centerY).offset([UIScreen mainScreen].bounds.size.height*0.15);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
    //微信账号
    [_WXAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.emailLabel.mas_left);
        make.top.equalTo(weakSelf.emailLabel.mas_top).offset(55);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
    //详细地址
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.WXAccountLabel.mas_left);
        make.top.equalTo(weakSelf.WXAccountLabel.mas_top).offset(55);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
    //我专注
    [_focusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.addressLabel.mas_left);
        make.top.equalTo(weakSelf.addressLabel.mas_top).offset(55);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
    //我在找
    [_findLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.focusLabel.mas_left);
        make.top.equalTo(weakSelf.focusLabel.mas_top).offset(55);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
    //电子邮箱文本框
    [_emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.emailLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.mas_top).offset(25);
    }];
    //微信账号文本框
    [_WXAccountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.WXAccountLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.emailLabel.mas_top).offset(55);
    }];
    //详细地址文本框
    [_addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.addressLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.WXAccountLabel.mas_top).offset(55);
    }];
    //我专注文本框
    [_focusTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.focusLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.addressLabel.mas_top).offset(55);
    }];
    //我在找文本框
    [_findTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.findLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.focusLabel.mas_top).offset(55);
    }];
}
#pragma mark - 懒加载
//电子邮箱label
- (UILabel *)emailLabel
{
    if (!_emailLabel) {
        _emailLabel = [[UILabel alloc] init];
        _emailLabel.text = @"电子邮箱";
        _emailLabel.textColor = [UIColor blackColor];
        _emailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _emailLabel;
}
//微信账号label
- (UILabel *)WXAccountLabel
{
    if (!_WXAccountLabel) {
        _WXAccountLabel = [[UILabel alloc] init];
        _WXAccountLabel.text = @"微信账号";
        _WXAccountLabel.textColor = [UIColor blackColor];
        _WXAccountLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _WXAccountLabel;
}
//详细地址label
- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"详细地址";
        _addressLabel.textColor = [UIColor blackColor];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _addressLabel;
}
//专注label
- (UILabel *)focusLabel
{
    if (!_focusLabel) {
        _focusLabel = [[UILabel alloc] init];
        _focusLabel.text = @"我  专  注";
        _focusLabel.textColor = [UIColor blackColor];
        _focusLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _focusLabel;
}
//在找label
- (UILabel *)findLabel
{
    if (!_findLabel) {
        _findLabel = [[UILabel alloc] init];
        _findLabel.text = @"我  在  找";
        _findLabel.textColor = [UIColor blackColor];
        _findLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _findLabel;
}
//昵称textfield
-(UITextField *)emailTextField
{
    if (!_emailTextField) {
        _emailTextField = [[UITextField alloc] init];
        _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        _emailTextField.delegate = self;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.emailString.length) {
            _emailTextField.text = self.editPIDataModel.emailString;
        }else
        {
        _emailTextField.placeholder = @"填写邮箱地址";
        }
    }
    return _emailTextField;
}

//移动电话textfield
-(UITextField *)WXAccountTextField
{
    if (!_WXAccountTextField) {
        _WXAccountTextField = [[UITextField alloc] init];
        _WXAccountTextField.borderStyle = UITextBorderStyleRoundedRect;
        _WXAccountTextField.delegate = self;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.WXAccountString.length) {
            _WXAccountTextField.text = self.editPIDataModel.WXAccountString;
        }else
        {
        _WXAccountTextField.placeholder = @"填写微信号";
        }
        _WXAccountTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _WXAccountTextField;
}

//职位textfield
- (UITextField *)addressTextField
{
    if (!_addressTextField) {
        _addressTextField = [[UITextField alloc] init];
        _addressTextField.borderStyle = UITextBorderStyleRoundedRect;
        _addressTextField.delegate = self;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.addressString.length) {
            _addressTextField.text = self.editPIDataModel.addressString;
        }else
        {
        _addressTextField.placeholder = @"请输入您的地址";
        }
    }
    return _addressTextField;
}
//单位名称textfield
- (UITextField *)focusTextField
{
    if (!_focusTextField) {
        _focusTextField = [[UITextField alloc] init];
        _focusTextField.borderStyle = UITextBorderStyleRoundedRect;
        _focusTextField.delegate = self;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.focusString.length) {
            _focusTextField.text = self.editPIDataModel.focusString;
        }else
        {
        _focusTextField.placeholder = @"填写专注，比如互联网营销";
        }
    }
    return _focusTextField;
}
//单位名称textfield
- (UITextField *)findTextField
{
    if (!_findTextField) {
        _findTextField = [[UITextField alloc] init];
        _findTextField.borderStyle = UITextBorderStyleRoundedRect;
        _findTextField.delegate = self;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.findString.length) {
            _findTextField.text = self.editPIDataModel.findString;
        }else
        {
        _findTextField.placeholder = @"填写寻求，比如互联网营销";
        }
    }
    return _findTextField;
}
#pragma mark - textfield代理方法实现
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
