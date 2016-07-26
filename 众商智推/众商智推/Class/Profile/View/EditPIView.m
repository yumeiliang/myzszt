//
//  EditPIView.m
//  众商智推
//
//  Created by 杨 on 16/4/28.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "EditPIView.h"
#import "Masonry.h"
#import "EditPIDataModel.h"

@interface EditPIView ()

//存取的数据模型
@property (strong, nonatomic) EditPIDataModel *editPIDataModel;


@end

@implementation EditPIView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //获取沙盒中存取的数据信息
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"regist.txt"];//当前应用的沙盒路径
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        self.editPIDataModel = [array objectAtIndex:0];

        
        [self addSubview:self.nameLabel];
        [self addSubview:self.telephoneLabel];
        [self addSubview:self.jobLabel];
        [self addSubview:self.companyLabel];
        [self addSubview:self.qqLabel];
        
        [self addSubview:self.nameTextField];
        [self addSubview:self.telephoneTextField];
        [self addSubview:self.jobTextField];
        [self addSubview:self.companyTextField];
        [self addSubview:self.qqTextField];
        [self addAutoLayout];
    }
    return self;
    
}

#pragma mark - 自动布局
#pragma mark - 自动适配

-(void)addAutoLayout
{
    WS(weakSelf);
    
    //昵称
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.top.equalTo(weakSelf.mas_top).offset(25);
        //        make.centerY.equalTo(weakSelf.mas_centerY).offset([UIScreen mainScreen].bounds.size.height*0.15);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
    //电话
    [_telephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel.mas_left);
        make.top.equalTo(weakSelf.nameLabel.mas_top).offset(55);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
    //职位
    [_jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.telephoneLabel.mas_left);
        make.top.equalTo(weakSelf.telephoneLabel.mas_top).offset(55);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
    //单位名称
    [_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.jobLabel.mas_left);
        make.top.equalTo(weakSelf.jobLabel.mas_top).offset(55);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
    //qq
    [_qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.companyLabel.mas_left);
        make.top.equalTo(weakSelf.companyLabel.mas_top).offset(55);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
    //昵称文本框
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.mas_top).offset(25);
    }];
    //电话文本框
    [_telephoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.telephoneLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.nameLabel.mas_top).offset(55);
    }];
    //职位文本框
    [_jobTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.jobLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.telephoneLabel.mas_top).offset(55);
    }];
    //单位名称文本框
    [_companyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.companyLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.jobLabel.mas_top).offset(55);
    }];
    //qq文本框
    [_qqTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.qqLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.companyLabel.mas_top).offset(55);
    }];

    
}
#pragma mark - 懒加载
//昵称label
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"姓       名*";
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
//电话label
- (UILabel *)telephoneLabel
{
    if (!_telephoneLabel) {
        _telephoneLabel = [[UILabel alloc] init];
        _telephoneLabel.text = @"移动电话*";
        _telephoneLabel.textColor = [UIColor blackColor];
        _telephoneLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _telephoneLabel;
}
//职位label
- (UILabel *)jobLabel
{
    if (!_jobLabel) {
        _jobLabel = [[UILabel alloc] init];
        _jobLabel.text = @"职       位*";
        _jobLabel.textColor = [UIColor blackColor];
        _jobLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _jobLabel;
}
//公司label
- (UILabel *)companyLabel
{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.text = @"单位名称*";
        _companyLabel.textColor = [UIColor blackColor];
        _companyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _companyLabel;
}
//QQLabel
- (UILabel *)qqLabel
{
    if (!_qqLabel) {
        _qqLabel = [[UILabel alloc] init];
        _qqLabel.text = @"   QQ";
        _qqLabel.textColor = [UIColor blackColor];
        _qqLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _qqLabel;
}
//昵称textfield
-(UITextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
        _nameTextField.delegate = self;
        
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.nameString.length) {
            _nameTextField.text = self.editPIDataModel.nameString;
        }else
        {
            _nameTextField.placeholder = @"请输入昵称";
        }
    }
    return _nameTextField;
}

//移动电话textfield
-(UITextField *)telephoneTextField
{
    if (!_telephoneTextField) {
        _telephoneTextField = [[UITextField alloc] init];
        _telephoneTextField.borderStyle = UITextBorderStyleRoundedRect;
        _telephoneTextField.delegate = self;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.telephoneString.length) {
            _telephoneTextField.text = self.editPIDataModel.telephoneString;
        }else
        {
            _telephoneTextField.placeholder = @"请输入手机号";
        }
        //        _telephoneTextField.text.length = 11;
        _telephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _telephoneTextField;
}

//职位textfield
- (UITextField *)jobTextField
{
    if (!_jobTextField) {
        _jobTextField = [[UITextField alloc] init];
        _jobTextField.borderStyle = UITextBorderStyleRoundedRect;
        _jobTextField.delegate = self;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.jobString.length) {
            _jobTextField.text = self.editPIDataModel.jobString;
        }else
        {
        _jobTextField.placeholder = @"请输入职位";
        }
    }
    return _jobTextField;
}
//单位名称textfield
- (UITextField *)companyTextField
{
    if (!_companyTextField) {
        _companyTextField = [[UITextField alloc] init];
        _companyTextField.borderStyle = UITextBorderStyleRoundedRect;
        _companyTextField.delegate = self;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.companyString.length) {
            _companyTextField.text = self.editPIDataModel.companyString;
        }else
        {
        _companyTextField.placeholder = @"请输入公司";
        }
    }
    return _companyTextField;
}
//qqtextfield
- (UITextField *)qqTextField
{
    if (!_qqTextField) {
        _qqTextField = [[UITextField alloc] init];
        _qqTextField.borderStyle = UITextBorderStyleRoundedRect;
        _qqTextField.delegate = self;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.qqString.length) {
            _qqTextField.text = self.editPIDataModel.qqString;
        }else
        {
        _qqTextField.placeholder = @"请输入QQ";
        }
    }
    return _qqTextField;
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
