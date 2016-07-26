//
//  EditADADsViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/11.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "EditADADsViewController.h"
#import "EditADADsTypeViewController.h"
#import "TypeOneViewController.h"

@interface EditADADsViewController ()<UITableViewDelegate,UITableViewDataSource>

//显示用户编辑的广告
@property (strong, nonatomic) UIButton *showBtn;
//编辑
@property (strong, nonatomic) UIButton *editADTypeBtn;
//删除
@property (strong, nonatomic) UIButton *removeADTypeBtn;
//沙盒中存储的用户输入的广告语
@property (strong, nonatomic) NSString *adContent;
//显示用户编辑的广告
@property (strong, nonatomic) UITableView *userADTableView;


@end

@implementation EditADADsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"profileBackImage.png"]]];
    //顶部view
    [self createHeadUI];
    //创建内容的控件
    [self createContentUI];
    //用来显示用户的广告类型
//    [self showAddADType];

    //创建通知者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSecret:) name:@"passValue" object:nil];
    
    //获取沙盒中存取的数据信息
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"adType.txt"];//当前应用的沙盒路径
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    self.adContent = [array objectAtIndex:0];
    
    if (self.adContent.length != 0) {
        [self.view addSubview:self.showBtn];
        [self.showBtn setTitle:self.adContent forState:UIControlStateNormal];
        [self.view addSubview:self.editADTypeBtn];
        [self.view addSubview:self.removeADTypeBtn];
    }else {
        [self.showBtn removeFromSuperview];
        [self.editADTypeBtn removeFromSuperview];
        [self.removeADTypeBtn removeFromSuperview];
    }
    
}
#pragma mark - 创建顶部View
- (void)createHeadUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headView.backgroundColor = ZSColor(19, 143, 253);
    [self.view addSubview:headView];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //标题按钮
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-60, 25, 120, 40)];
    titleLabel.text = @"我的广告列表";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
//退出此控制器返回到上级的控制器
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createContentUI
{
    //提示语Label
    UILabel *tiShiLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 80, 40)];
    tiShiLabel1.text = @"个人广告";
    tiShiLabel1.textAlignment = NSTextAlignmentLeft;
    tiShiLabel1.textColor = [UIColor whiteColor];
    tiShiLabel1.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:tiShiLabel1];
    //提示语Label
    UILabel *tiShiLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(90, 70, 150, 40)];
    tiShiLabel2.text = @"（个人推广用户创建）";
    tiShiLabel2.textAlignment = NSTextAlignmentLeft;
    tiShiLabel2.textColor = [UIColor whiteColor];
    tiShiLabel2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:tiShiLabel2];
    
    UIButton *addPIADBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addPIADBtn.frame = CGRectMake(10, ScreenHeight - 60, ScreenWidth - 20, 40);
    addPIADBtn.backgroundColor = ZSColor(19, 143, 253);
    [addPIADBtn setImage:[UIImage imageNamed:@"addPIAD"] forState:UIControlStateNormal];
    [addPIADBtn setTitle:@"添加个人广告" forState:UIControlStateNormal];
    [addPIADBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addPIADBtn addTarget:self action:@selector(addPIADBtnClick) forControlEvents:UIControlEventTouchUpInside];
    addPIADBtn.layer.cornerRadius = 5;
    addPIADBtn.layer.masksToBounds = YES;
    [self.view addSubview:addPIADBtn];
    
    
}
//通知回调
-(void)getSecret:(NSNotification*)notification
{
    
    //把传回来的值显示在label上
    if ([notification.object isKindOfClass:[NSString class]]) {
//        self.notifiyLabel.text = notification.object;
        [self.showBtn setTitle:notification.object forState:UIControlStateNormal];
        [self showAddADType];
    }
    
}

- (void)showAddADType
{
    
    if (self.adContent.length != 0) {
        [self.view addSubview:self.showBtn];
//        [self.showBtn setTitle:self.adContent forState:UIControlStateNormal];
        [self.view addSubview:self.editADTypeBtn];
        [self.view addSubview:self.removeADTypeBtn];
    }else {
        [self.showBtn removeFromSuperview];
        [self.editADTypeBtn removeFromSuperview];
        [self.removeADTypeBtn removeFromSuperview];
    }
    
}

- (void)addPIADBtnClick
{
    EditADADsTypeViewController *ADsTypeVC = [[EditADADsTypeViewController alloc] init];
    [self presentViewController:ADsTypeVC animated:YES completion:nil];
}

//显示广告的类型
- (UIButton *)showBtn
{
    
    if (!_showBtn) {
        _showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showBtn.frame = CGRectMake(10, 120, ScreenWidth-20, 90);
        [_showBtn setBackgroundImage:[UIImage imageNamed:@"adBackgroundNormal1.png"] forState:UIControlStateNormal];
        [_showBtn setBackgroundImage:[UIImage imageNamed:@"adBackgroundNormal1.png"] forState:UIControlStateHighlighted];
        if (self.adContent) {
             [self.showBtn setTitle:self.adContent forState:UIControlStateNormal];
        }else {
             [self.showBtn setTitle:nil forState:UIControlStateNormal];
        }
        [_showBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _showBtn;
}
//编辑个人信息的按钮Btn
- (UIButton *)editADTypeBtn
{
    if (!_editADTypeBtn) {
        _editADTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editADTypeBtn.frame = CGRectMake(10, 220, (ScreenWidth-30)/2, 50);
        _editADTypeBtn.backgroundColor = [UIColor whiteColor];
        [_editADTypeBtn setImage:[UIImage imageNamed:@"editImage.png"] forState:UIControlStateNormal];
        [_editADTypeBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editADTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_editADTypeBtn addTarget:self action:@selector(editADTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _editADTypeBtn.layer.cornerRadius = 10;
        _editADTypeBtn.layer.masksToBounds = YES;
        
    }
    return _editADTypeBtn;
}
//编辑个人信息的按钮Btn
- (UIButton *)removeADTypeBtn
{
    if (!_removeADTypeBtn) {
        _removeADTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _removeADTypeBtn.frame = CGRectMake((ScreenWidth-30)/2 + 20, 220, (ScreenWidth-30)/2, 50);;
        _removeADTypeBtn.backgroundColor = [UIColor whiteColor];
        [_removeADTypeBtn setImage:[UIImage imageNamed:@"removeImage.png"] forState:UIControlStateNormal];
        [_removeADTypeBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_removeADTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_removeADTypeBtn addTarget:self action:@selector(removeADTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _removeADTypeBtn.layer.cornerRadius = 10;
        _removeADTypeBtn.layer.masksToBounds = YES;
        
    }
    return _removeADTypeBtn;
}

//编辑广告按钮的实现方法
- (void)editADTypeBtnClick
{
    TypeOneViewController *TypeOneVC = [[TypeOneViewController alloc] init];
    [self presentViewController:TypeOneVC animated:YES completion:nil];
}

- (void)removeADTypeBtnClick
{
    [self.showBtn removeFromSuperview];
    [self.editADTypeBtn removeFromSuperview];
    [self.removeADTypeBtn removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
