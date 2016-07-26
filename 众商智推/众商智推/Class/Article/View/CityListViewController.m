//
//  CityListViewController.m
//  众商智推
//
//  Created by 杨 on 16/7/1.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "CityListViewController.h"

@interface CityListViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

//输入文字的文本框
@property (strong, nonatomic) UITextField *inputTextField;
//确定按钮
@property (strong, nonatomic) UIButton *OKBtn;
//城市列表
@property (strong, nonatomic) UITableView *cityListTableView;
//设置分区标题的数组
@property (strong, nonatomic) NSMutableArray *headerSourceArr;
//城市列表的数组
@property (strong, nonatomic) NSMutableArray *cityListArr;

@end

@implementation CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self createHeadUI];
    [self.view addSubview:self.inputTextField];
    [self.view addSubview:self.OKBtn];
    [self.view addSubview:self.cityListTableView];
    
    self.headerSourceArr = [[NSMutableArray alloc] initWithObjects:@"B",@"C",@"H",@"L",@"N",@"T",@"X",@"Z", nil];
    
    NSArray *arr1 = @[@"北京"];
    NSArray *arr2 = @[@"沧州",@"长春",@"成都"];
    NSArray *arr3 = @[@"哈尔滨",@"海口",@"杭州",@"呼和浩特"];
    NSArray *arr4 = @[@"兰州"];
    NSArray *arr5 = @[@"南京"];
    NSArray *arr6 = @[@"唐山",@"天津"];
    NSArray *arr7 = @[@"厦门",@"西安"];
    NSArray *arr8 = @[@"郑州",@"自贡"];
    self.cityListArr = [[NSMutableArray alloc] initWithObjects:arr1,arr2,arr3,arr4,arr5,arr6,arr7,arr8, nil];
    
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
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, 25, 80, 40)];
    titleLabel.text = @"城市列表";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
//退出此控制器返回到上级的控制器
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark - 懒加载
- (UITextField *)inputTextField
{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 70, ScreenWidth- 70, 40)];
        _inputTextField.borderStyle = UITextBorderStyleRoundedRect;
        _inputTextField.delegate = self;
        _inputTextField.placeholder = @"请输入关键字";
    }
    return _inputTextField;
}
- (UIButton *)OKBtn
{
    if (!_OKBtn) {
        _OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _OKBtn.frame = CGRectMake(ScreenWidth- 55, 70, 40, 40);
        [_OKBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_OKBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_OKBtn addTarget:self action:@selector(oKBtnBeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _OKBtn;
}
- (UITableView *)cityListTableView
{
    if (!_cityListTableView) {
        _cityListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 115, ScreenWidth,ScreenHeight - 115) style:UITableViewStyleGrouped];
        _cityListTableView.rowHeight = 40;
        _cityListTableView.dataSource = self;
        _cityListTableView.delegate = self;
//        _cityListTableView.scrollEnabled = NO;
//        _cityListTableView.backgroundColor = ZSColor(232, 232, 232);
    }
    return _cityListTableView;
}
#pragma mark -
#pragma mark - button的点击方法
//确定按钮
- (void)oKBtnBeClick
{
    if (self.inputTextField.text.length) {
        [MBProgressHUD showSuccess:@"没有找到相关内容"];
    }else {
        [MBProgressHUD showError:@"请输入内容"];
    }
}
#pragma mark -UITableViewDataSource,UITableViewDelegate的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cityListArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.cityListArr objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.cityListArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *str = [[self.cityListArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"passCityValue" object:str];
    [self goBack];
}
#pragma mark -设置分区标题
//头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.headerSourceArr objectAtIndex:section];
}
#pragma mark - 设置分区索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
     return @[@"B",@"C",@"H",@"L",@"N",@"T",@"X",@"Z"];
    
}
//点击索引回调方法
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"title:%@  index:%ld",title,index);
    return index;
}
//标题高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
#pragma mark -
#pragma mark - 键盘的协议方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

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
