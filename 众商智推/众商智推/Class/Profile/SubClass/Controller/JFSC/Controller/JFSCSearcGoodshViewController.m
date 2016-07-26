//
//  JFSCSearcGoodshViewController.m
//  众商智推
//
//  Created by 杨 on 16/6/21.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "JFSCSearcGoodshViewController.h"
#import "JFSCGoodsViewController.h"

@interface JFSCSearcGoodshViewController ()<UITextFieldDelegate>

/**
 *商品名称
 */
@property (strong, nonatomic) UITextField *goodsNameTextField;
/**
 *搜索按钮
 */
@property (strong, nonatomic) UIButton *searchGoodsBtn;
/**
 *图片
 */
@property (strong, nonatomic) UIImageView *imageView;

/**
 *goodsName
 */
@property (strong, nonatomic) UILabel *goodsNameLabel;
/**
 *积分
 */
@property (strong, nonatomic) UILabel *integralLabel;
/**
 *蒙板按钮
 */
@property (strong, nonatomic) UIButton *clickBtn;

@end

@implementation JFSCSearcGoodshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    [self createHeadUI];
    [self createContentControls];
    
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
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //标题Label
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(60, 25, ScreenWidth - 110, 40)];
    titleLabel.text = @"搜索商品";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//添加内容控件
- (void)createContentControls
{
    self.goodsNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, ScreenWidth-90, 40)];
    self.goodsNameTextField.placeholder = @"请输入您搜索的商品名称";
    self.goodsNameTextField.delegate = self;
    self.goodsNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.goodsNameTextField];
    
    self.searchGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchGoodsBtn.frame = CGRectMake(ScreenWidth-65, 80, 50, 38);
    self.searchGoodsBtn.backgroundColor = ZSColor(19, 143, 253);
    [self.searchGoodsBtn setTitle:@"搜索" forState:UIControlStateNormal];
    self.searchGoodsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.searchGoodsBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.searchGoodsBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.searchGoodsBtn addTarget:self action:@selector(searchGoodsBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    self.searchGoodsBtn.layer.cornerRadius = 5;
    self.searchGoodsBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.searchGoodsBtn];
}
//搜索按钮的点击方法
- (void)searchGoodsBtnMethod
{
    if (self.goodsNameTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入商品名称！"];
    }else if ([self.goodsNameTextField.text isEqualToString:@"公文包"]||[self.goodsNameTextField.text isEqualToString:@"梦特娇"]||[self.goodsNameTextField.text isEqualToString:@"MONTAGUT"]||[self.goodsNameTextField.text isEqualToString:@"包"]) {
        //移除多余的视图 如果视图上有上次查找的商品  则删除
        if (self.view.subviews.count > 3) {
            UIView *tempView = (UIView *)self.view.subviews.lastObject;
            [tempView removeFromSuperview];
        }
       UIView *goodsView = [[UIView alloc] initWithFrame:CGRectMake(10, 125, [[UIScreen mainScreen] bounds].size.width/2-15, 270)];
        [goodsView addSubview:self.imageView];
        [goodsView addSubview:self.goodsNameLabel];
        [goodsView addSubview:self.integralLabel];
        [goodsView setBackgroundColor:[UIColor whiteColor]];
        [goodsView addSubview:self.clickBtn];
        [self.view addSubview:goodsView];
    }else if ([self.goodsNameTextField.text isEqualToString:@"茅台"]|| [self.goodsNameTextField.text isEqualToString:@"酒"]) {
        [MBProgressHUD showSuccess:@"此商品已售罄！"];
        //移除多余的视图 如果视图上有上次查找的商品  则删除
        if (self.view.subviews.count > 3) {
            UIView *tempView = (UIView *)self.view.subviews.lastObject;
            [tempView removeFromSuperview];
        }
    } else {
        [MBProgressHUD showError:@"此商品不存在！"];
        //移除多余的视图
        if (self.view.subviews.count > 3) {
            UIView *tempView = (UIView *)self.view.subviews.lastObject;
            [tempView removeFromSuperview];
        }
    }
}
#pragma mark ----------------------- 懒加载
// 图片
- (UIImageView *)imageView
{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth *0.397, 170)];
        _imageView.image = [UIImage imageNamed:@"梦特娇"];
    }
    return _imageView;
}
//goodsNameLabel
- (UILabel *)goodsNameLabel
{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 182,ScreenWidth *0.397, 40)];
        //        _goodsNameLabel.backgroundColor = [UIColor redColor];
        _goodsNameLabel.textColor = [UIColor grayColor];
        //自动换行
        _goodsNameLabel.numberOfLines = 0;
        // 大小
        _goodsNameLabel.font = [UIFont systemFontOfSize:15];
        // 对齐方式
        _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        _goodsNameLabel.text = @"梦特娇(MONTAGUT)男士公文包";
    }
    return _goodsNameLabel;
}
//积分
- (UILabel *)integralLabel
{
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, ScreenWidth *0.397, 40)];
        //        _integralLabel.backgroundColor = [UIColor brownColor];
        _integralLabel.textColor = ZSColor(173, 209, 62);
        // 字体大小
        _integralLabel.font = [UIFont systemFontOfSize:20];
        _integralLabel.textAlignment = NSTextAlignmentLeft;
        _integralLabel.text = @"709积分";
    }
    return _integralLabel;
}
- (UIButton *)clickBtn
{
    if (!_clickBtn) {
        _clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width/2-15, 270)];
        _clickBtn.backgroundColor = [UIColor clearColor];
        [_clickBtn addTarget:self action:@selector(clickBtnBeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickBtn;
}

- (void)clickBtnBeClick
{
    JFSCGoodsViewController *goodsVC = [[JFSCGoodsViewController alloc] init];
    goodsVC.titleStr = @"梦特娇(MONTAGUT)男士公文包";;
    goodsVC.goodsImageNameStr = @"梦特娇";
    goodsVC.goodsIntegralStr = @"709积分";
    goodsVC.goodsInfostr = @"梦特娇男士商务公文包 广东省 拉链内部结构：拉链暗袋，手机袋 啡色";
    [self presentViewController:goodsVC animated:YES completion:nil];
}
#pragma mark -
#pragma mark - textField的代理事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
