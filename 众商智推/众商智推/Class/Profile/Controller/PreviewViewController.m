//
//  PreviewViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/25.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "PreviewViewController.h"
#import "EditPIDataModel.h"
#import "ProfileViewController.h"
//#import "UMSocial.h"
//#import "UMSocialWechatHandler.h"
//#import "UMSocialQQHandler.h"

@interface PreviewViewController ()//<UMSocialUIDelegate>

//存取的数据模型
@property (strong, nonatomic) EditPIDataModel *editPIDataModel;

//contentView
@property (strong, nonatomic) UIView *contentView;
//一键拨号
@property (strong, nonatomic) UIButton *callBtn;
//头像
@property (strong, nonatomic) UIButton *iconBtn;
//昵称
@property (strong, nonatomic) UILabel *nameLabel;
//公司
@property (strong, nonatomic) UILabel *companyLabel;
//职务
@property (strong, nonatomic) UILabel *jobLabel;
//TA专注Label
@property (nonatomic, strong) UILabel *focusLabel;
//中间的横线
@property (strong, nonatomic) UIView *lineView;
//TA在找Label
@property (nonatomic, strong) UILabel *findLabel;
//QQBtn
@property (strong, nonatomic) UIButton *qqBtn;
//收藏Btn
@property (strong, nonatomic) UIButton *collectionBtn;
//我的微名片Btn
@property (strong, nonatomic) UIButton *myWeiNameBtn;
//更多Btn
@property (strong, nonatomic) UIButton *moreBtn;
//电话label
@property (nonatomic, strong) UILabel *telephoneLabel;
//电子信箱Label
@property (nonatomic, strong) UILabel *emailLabel;
//微信账号Label
@property (nonatomic, strong) UILabel *WXAccountLabel;
//详细地址label
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    //获取沙盒中存取的数据信息
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"regist.txt"];//当前应用的沙盒路径
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    self.editPIDataModel = [array objectAtIndex:0];
    
    //加载头部的view
    [self createHeadUI];
    
    //加载内容view
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.callBtn];
    [self.contentView addSubview:self.iconBtn];
    [self.contentView addSubview:self.qqBtn];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.companyLabel];
    [self.contentView addSubview:self.jobLabel];
    [self.contentView addSubview:self.telephoneLabel];
    [self.contentView addSubview:self.emailLabel];
    [self.contentView addSubview:self.WXAccountLabel];
    [self.contentView addSubview:self.addressLabel];

    //专注&在找
    [self.view addSubview:self.focusLabel];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.findLabel];
    
    //加载底部的button
    [self.view addSubview:self.collectionBtn];
    [self.view addSubview:self.myWeiNameBtn];
    [self.view addSubview:self.moreBtn];
    
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://travel.sohu.com/20150419/n411508946.shtml"];
    
}

#pragma mark -
#pragma mark - 创建顶部View
- (void)createHeadUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headView.backgroundColor = ZSColor(19, 143, 253);
    [self.view addSubview:headView];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - 懒加载
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 350)];
        _contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"contntViewBackGround"]];
        
    }
    return _contentView;
}
- (UIButton *)callBtn
{
    if (!_callBtn) {
        _callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _callBtn.frame = CGRectMake(10, 10, 80, 80);
        [_callBtn setImage:[UIImage imageNamed:@"callBtnImage"] forState:UIControlStateNormal];
        [_callBtn setTitle:@"一键拨号" forState:UIControlStateNormal];
        [_callBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _callBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _callBtn.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 40, 3);
        _callBtn.titleEdgeInsets = UIEdgeInsetsMake(35, -90, 0, 1);
        _callBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_callBtn addTarget:self action:@selector(callTelephoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        _callBtn.backgroundColor = [UIColor cyanColor];
    }
    return _callBtn;
}
//头像
- (UIButton *)iconBtn
{
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconBtn.frame = CGRectMake(ScreenWidth/2 - 40 , 10, 75, 75);
//        _iconBtn.backgroundColor = [UIColor clearColor];
        _iconBtn.layer.cornerRadius = 35;
        _iconBtn.layer.masksToBounds = YES;
        _iconBtn.layer.borderWidth = 5;
        _iconBtn.layer.borderColor = [UIColor grayColor].CGColor;
        //加载首先访问本地沙盒是否存在相关图片
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];
        if (!savedImage)
        {
            //默认头像
            [_iconBtn setImage:[UIImage imageNamed:@"head_default.png"] forState:UIControlStateNormal];
        }
        else
        {
            [_iconBtn setImage:savedImage forState:UIControlStateNormal];
        }
    }
    return _iconBtn;
}
//昵称
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 100 , 88, 200, 40)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont boldSystemFontOfSize:30];
        _nameLabel.textColor = [UIColor whiteColor];
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.nameString.length) {
            _nameLabel.text = self.editPIDataModel.nameString;
        }else
        {
            _nameLabel.text = @" ";
        }
    }
    return _nameLabel;
}
- (UILabel *)jobLabel
{
    if (!_jobLabel) {
        _jobLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 100 , 128, 200, 35)];
        _jobLabel.backgroundColor = [UIColor clearColor];
        _jobLabel.font = [UIFont systemFontOfSize:22];
        _jobLabel.textAlignment = NSTextAlignmentCenter;
        _jobLabel.textColor = [UIColor whiteColor];
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.jobString.length) {
            _jobLabel.text = self.editPIDataModel.jobString;
        }else
        {
            _jobLabel.text = @" ";
        }
    }
    return _jobLabel;
}
- (UILabel *)companyLabel
{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 100 , 163, 200, 35)];
        _companyLabel.backgroundColor = [UIColor clearColor];
        _companyLabel.font = [UIFont systemFontOfSize:22];
        _companyLabel.textAlignment = NSTextAlignmentCenter;
        _companyLabel.textColor = [UIColor whiteColor];
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.companyString.length) {
            _companyLabel.text = self.editPIDataModel.companyString;
        }else
        {
            _companyLabel.text = @" ";
        }
    }
    return _companyLabel;
}
//电话label
- (UILabel *)telephoneLabel
{
    if (!_telephoneLabel) {
        _telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 210, ScreenWidth - 50, 30)];
        _telephoneLabel.textColor = [UIColor whiteColor];
        _telephoneLabel.textAlignment = NSTextAlignmentLeft;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.telephoneString.length) {
            _telephoneLabel.text =  [NSString stringWithFormat:@"电话:  %@",self.editPIDataModel.telephoneString];
        }else
        {
            _telephoneLabel.text = @"电话:";
        }

    }
    return _telephoneLabel;
}
//电子邮箱label
- (UILabel *)emailLabel
{
    if (!_emailLabel) {
        _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 240, ScreenWidth - 50, 30)];
        _emailLabel.text = @"";
        _emailLabel.textColor = [UIColor whiteColor];
        _emailLabel.textAlignment = NSTextAlignmentLeft;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.emailString.length) {
            _emailLabel.text =  [NSString stringWithFormat:@"邮箱:  %@",self.editPIDataModel.emailString];
        }else
        {
            _emailLabel.text = @"邮箱:";
        }

    }
    return _emailLabel;
}
//微信账号label
- (UILabel *)WXAccountLabel
{
    if (!_WXAccountLabel) {
        _WXAccountLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 270, ScreenWidth - 50, 30)];
        _WXAccountLabel.text = @"微信账号";
        _WXAccountLabel.textColor = [UIColor whiteColor];
        _WXAccountLabel.textAlignment = NSTextAlignmentLeft;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.WXAccountString.length) {
            _WXAccountLabel.text =  [NSString stringWithFormat:@"账号:  %@",self.editPIDataModel.WXAccountString];
        }else
        {
            _WXAccountLabel.text = @"账号:";
        }

    }
    return _WXAccountLabel;
}
//详细地址label
- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 300, ScreenWidth - 50, 30)];
        _addressLabel.text = @"详细地址";
        _addressLabel.textColor = [UIColor whiteColor];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        if (self.editPIDataModel.addressString.length) {
            _addressLabel.text =  [NSString stringWithFormat:@"地址:  %@",self.editPIDataModel.addressString];
        }else
        {
            _addressLabel.text = @"地址:";
        }
    }
    return _addressLabel;
}


//TA专注label
- (UILabel *)focusLabel
{
    if (!_focusLabel) {
        _focusLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 424, ScreenWidth - 30, 40)];
        if (self.editPIDataModel.focusString.length) {
            _focusLabel.text = [NSString stringWithFormat:@"TA专注:  %@",self.editPIDataModel.focusString];
        }else{
           _focusLabel.text = @"TA专注:";
        }
        _focusLabel.backgroundColor = [UIColor whiteColor];
        _focusLabel.textColor = [UIColor grayColor];
        _focusLabel.font = [UIFont systemFontOfSize:20];
        _focusLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _focusLabel;
}
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 464, ScreenWidth - 40, 1)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}
//TA在找label
- (UILabel *)findLabel
{
    if (!_findLabel) {
        _findLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 465, ScreenWidth - 30, 40)];
        if (self.editPIDataModel.findString.length) {
            _findLabel.text = [NSString stringWithFormat:@"TA专注:  %@",self.editPIDataModel.findString];
        }else{
            _findLabel.text = @"TA在找:";
        }
        _findLabel.backgroundColor = [UIColor whiteColor];
        _findLabel.textColor = [UIColor grayColor];
        _findLabel.font = [UIFont systemFontOfSize:20];
        _findLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _findLabel;
}

- (UIButton *)qqBtn
{
    if (!_qqBtn) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _qqBtn.frame = CGRectMake(ScreenWidth- 70, 10, 60, 65);
        _qqBtn.backgroundColor = [UIColor clearColor];
        [_qqBtn addTarget:self action:@selector(goToQQ) forControlEvents:UIControlEventTouchUpInside];
        [_qqBtn setBackgroundImage:[UIImage imageNamed:@"QQImage"] forState:UIControlStateNormal];
    }
    return _qqBtn;
}
//收藏Btn
- (UIButton *)collectionBtn
{
    if (!_collectionBtn) {
        _collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectionBtn.frame = CGRectMake(0, ScreenHeight- 50, ScreenWidth/3, 50);
        _collectionBtn.backgroundColor = [UIColor whiteColor];
        [_collectionBtn setTitle:@"收藏TA" forState:UIControlStateNormal];
        [_collectionBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [_collectionBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        _collectionBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _collectionBtn;
}
//我的微名片Btn
- (UIButton *)myWeiNameBtn
{
    if (!_myWeiNameBtn) {
        _myWeiNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _myWeiNameBtn.frame = CGRectMake(CGRectGetMaxX(self.collectionBtn.frame), ScreenHeight - 50, ScreenWidth/3, 50);
        _myWeiNameBtn.backgroundColor = [UIColor whiteColor];
        [_myWeiNameBtn setTitle:@"我的微名片" forState:UIControlStateNormal];
        [_myWeiNameBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
         [_myWeiNameBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        _myWeiNameBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        _myWeiNameBtn.selected = YES;
    }
    return _myWeiNameBtn;
}
//更多Btn
- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.frame = CGRectMake(CGRectGetMaxX(self.myWeiNameBtn.frame), ScreenHeight- 50, ScreenWidth/3, 50);
        _moreBtn.backgroundColor = [UIColor whiteColor];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _moreBtn;
}
#pragma mark -
#pragma mark - button的点击方法
//QQ的点击事件
- (void)goToQQ
{
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56a7007c67e58ebe480014d4" shareText:@"1" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ, nil] delegate:self];
    
    //创建面板
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示框" message:[NSString stringWithFormat:@"是否登陆QQ：%@",self.editPIDataModel.qqString] preferredStyle:UIAlertControllerStyleAlert];
    //创建事件
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //当取消事件被触发后执行的回调操作
        NSLog(@"取消事件被触发");
    }];
    UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //当取消事件被触发后执行的回调操作
        NSLog(@"确定事件被触发");
    }];
    //把事件加载到面板上
    [alertView addAction:cancel];
    [alertView addAction:okBtn];
    [self presentViewController:alertView animated:YES completion:nil];

}
//电话的点击事件
- (void)callTelephoneBtnClick
{
    if (self.editPIDataModel.qqString.length) {
        
        //创建面板
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示框" message:[NSString stringWithFormat:@"是否拨打：%@",self.editPIDataModel.telephoneString] preferredStyle:UIAlertControllerStyleAlert];
        //创建事件
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //当取消事件被触发后执行的回调操作
            ZSLog(@"取消事件被触发");
        }];
        UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //当确定事件被触发后执行的回调操作
            ZSLog(@"确定事件被触发");
            
            //拨打电话的功能
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.editPIDataModel.telephoneString];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }];
        //把事件加载到面板上
        [alertView addAction:cancel];
        [alertView addAction:okBtn];
        [self presentViewController:alertView animated:YES completion:nil];

    }else{
        //创建面板
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示框" message:@"请注册登录" preferredStyle:UIAlertControllerStyleAlert];
        //创建事件
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //当取消事件被触发后执行的回调操作
            ZSLog(@"取消事件被触发");
        }];
        UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //当取消事件被触发后执行的回调操作
            ZSLog(@"确定事件被触发");
            //点击确定  会到EditPersonalinformationViewController注册用户的信息
            ProfileViewController *profileVC = [[ProfileViewController alloc] init];
            [self presentViewController:profileVC animated:YES completion:nil];
        }];
        //把事件加载到面板上
        [alertView addAction:cancel];
        [alertView addAction:okBtn];
        [self presentViewController:alertView animated:YES completion:nil];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
