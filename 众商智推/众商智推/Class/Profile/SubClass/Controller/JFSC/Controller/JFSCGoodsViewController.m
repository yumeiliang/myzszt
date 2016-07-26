//
//  JFSCGoodsViewController.m
//  众商智推
//
//  Created by 杨 on 16/6/7.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "JFSCGoodsViewController.h"
#import "MBProgressHUD+MJ.h"
#import "JFSCSendGoodsViewController.h"
#import "ZSZTWebViewController.h"

#define ZSScrollImageCount 2

@interface JFSCGoodsViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *goodsScrollView;

@property (assign, nonatomic) NSInteger goodsAmount;

@property (strong, nonatomic) UILabel *amountLabel;
//立即兑换button
@property (strong, nonatomic) UIButton *changeBtn;

@end

@implementation JFSCGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZSColor(250, 250, 250);
    self.goodsAmount = 0;
    
    [self createHeadUI];
    [self createWebView];
//    [self createContentControls];
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
    titleLabel.text = self.titleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
    
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark - 创建顶部View
- (void)createWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 65)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.infoUrl]]];
    [webView allowsPictureInPictureMediaPlayback];
    [self.view addSubview:webView];
    
}


#pragma mark -
#pragma mark - 内容
- (void)createContentControls
{
    self.goodsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight)];
    self.goodsScrollView.backgroundColor = ZSColor(250, 250, 250);
    self.goodsScrollView.delegate = self;
    //设置scrollview的其他属性
    self.goodsScrollView.contentSize = CGSizeMake(0, 640);
    self.goodsScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.goodsScrollView];
    
    
    self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth - 10, 300)];
    self.goodsImageView.image = [UIImage imageNamed:self.goodsImageNameStr];
    [self.goodsScrollView addSubview:self.goodsImageView];
    
    UILabel *goodsInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 80, 40)];
    goodsInfoLabel.text = @"商品详情";
    goodsInfoLabel.font = [UIFont systemFontOfSize:18];
    [self.goodsScrollView addSubview:goodsInfoLabel];
    
    UILabel *goodsInfoLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 335, ScreenWidth - 20, 60)];
    goodsInfoLabel2.text = self.goodsInfostr;
    goodsInfoLabel2.numberOfLines = 0;
    goodsInfoLabel2.textColor = [UIColor grayColor];
    goodsInfoLabel2.font = [UIFont systemFontOfSize:16];
    [self.goodsScrollView addSubview:goodsInfoLabel2];
    
    //属性字符串
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    NSString *str = [[NSString alloc] initWithFormat:@"价格: %@",self.goodsIntegralStr];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    //字体颜色
    [attributeString setAttributes:dic range:NSMakeRange(3, attributeString.length - 3)];
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 400, ScreenWidth - 20, 40)];
    priceLabel.attributedText = attributeString;
    priceLabel.font = [UIFont systemFontOfSize:15];
    [self.goodsScrollView addSubview:priceLabel];
    
    //数量
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 455, 40, 40)];
    numberLabel.text = @"数量:";
    numberLabel.font = [UIFont systemFontOfSize:15];
    [self.goodsScrollView addSubview:numberLabel];
    
    self.amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 460, 100, 30)];
    self.amountLabel.text = [NSString stringWithFormat:@"%lu",self.goodsAmount];
    self.amountLabel.font = [UIFont systemFontOfSize:15];
    self.amountLabel.textAlignment = NSTextAlignmentCenter;
    [self.goodsScrollView addSubview:self.amountLabel];
    
    UIButton *jianShaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(55, 460, 30, 30)];
    [jianShaoBtn setTitle:@"➖" forState:UIControlStateNormal];
    [jianShaoBtn setBackgroundColor:ZSColor(230, 230, 230)];
    [jianShaoBtn addTarget:self action:@selector(jianShaoBtnBeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.goodsScrollView addSubview:jianShaoBtn];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(185, 460, 30, 30)];
    [addBtn setTitle:@"➕" forState:UIControlStateNormal];
    [addBtn setBackgroundColor:ZSColor(230, 230, 230)];
    [addBtn addTarget:self action:@selector(addBtnBeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.goodsScrollView addSubview:addBtn];
    
    self.changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 525, ScreenWidth - 20, 40)];
    [self.changeBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [self.changeBtn setBackgroundColor:ZSColor(19, 143, 253)];
    [self.changeBtn.layer setCornerRadius:5];
    [self.changeBtn.layer setMasksToBounds:YES];
    [self.changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.changeBtn addTarget:self action:@selector(changeBtnBeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.goodsScrollView addSubview:self.changeBtn];
    
}

#pragma mark -
#pragma mark - button的点击方法
//减少数量的按钮实现方法
- (void)jianShaoBtnBeClick
{
    if (self.goodsAmount > 0) {
        self.goodsAmount -= 1;
        self.amountLabel.text = [NSString stringWithFormat:@"%lu",self.goodsAmount];
    }else{
        self.goodsAmount = 0;
        self.amountLabel.text = [NSString stringWithFormat:@"%lu",self.goodsAmount];
    }
}
//增加数量的按钮实现方法
- (void)addBtnBeClick
{
    self.goodsAmount += 1;
    self.amountLabel.text = [NSString stringWithFormat:@"%lu",self.goodsAmount];
}
//立即兑换的按钮实现方法
- (void)changeBtnBeClick
{
    if (self.goodsAmount > 0) {
        JFSCSendGoodsViewController *sendGoodsVC = [[JFSCSendGoodsViewController alloc] init];
        [self presentViewController:sendGoodsVC animated:YES completion:nil];
        
    }else{
        [MBProgressHUD showError:@"请选择兑换商品的数量"];
    }
    
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
