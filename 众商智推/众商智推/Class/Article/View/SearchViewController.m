//
//  SearchViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/19.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "SearchViewController.h"
#import "MBProgressHUD+MJ.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

//文本框的View
@property (strong, nonatomic) UIView *headerView;
//输入文字的文本框
@property (strong, nonatomic) UITextField *inputTextField;
//文本框前的竖线
@property (strong, nonatomic) UIView *lineView;
//确定按钮
@property (strong, nonatomic) UIButton *OKBtn;
//清除历史
@property (strong, nonatomic) UIButton *removeHistoryBtn;
//历史jil的tableview
@property (strong, nonatomic) UITableView *historyTabelView;
//历史记录的数组
@property (strong, nonatomic) NSMutableArray *historyMutArray;

@end

@implementation SearchViewController
#pragma mark -
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(232, 232, 232)];
    
    [self createUI];
}
- (void)createUI
{
//        self.historyMutArray = [NSMutableArray arrayWithObjects:@" ",@" ",@" ",@" ", nil];
    //加载文本框的view
    [self.view addSubview:self.headerView];
    //加载view里的内容
    [self.headerView addSubview:self.lineView];
    [self.headerView addSubview:self.inputTextField];
    [self.view addSubview:self.OKBtn];
    [self.view addSubview:self.removeHistoryBtn];
    [self.view addSubview:self.historyTabelView];
    
}
#pragma mark -
#pragma mark - 懒加载
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10,ScreenWidth-80, 45)];
//        _headerView.
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(26, 13, 2, 25)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}
- (UITextField *)inputTextField
{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 5, self.headerView.frame.size.width- 35, 40)];
        _inputTextField.borderStyle = UITextBorderStyleNone;
        _inputTextField.delegate = self;
        _inputTextField.placeholder = @"请输入关键字";
    }
    return _inputTextField;
}
- (UIButton *)OKBtn
{
    if (!_OKBtn) {
        _OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _OKBtn.frame = CGRectMake(ScreenWidth- 55, 13, 40, 40);
        [_OKBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_OKBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_OKBtn addTarget:self action:@selector(oKBtnBeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _OKBtn;
}
- (UIButton *)removeHistoryBtn
{
    if (!_removeHistoryBtn) {
        _removeHistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _removeHistoryBtn.frame = CGRectMake(ScreenWidth/2-50, 250, 100, 40);
        [_removeHistoryBtn setTitle:@"清除历史" forState:UIControlStateNormal];
        [_removeHistoryBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_removeHistoryBtn addTarget:self action:@selector(removeHistoryBtnBeClick) forControlEvents:UIControlEventTouchUpInside];
        _removeHistoryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _removeHistoryBtn.layer.borderWidth = 1;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 1, 1});
        _removeHistoryBtn.layer.borderColor = colorref;

        
    }
    return _removeHistoryBtn;
}
- (UITableView *)historyTabelView
{
    if (!_historyTabelView) {
        _historyTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth,185) style:UITableViewStylePlain];
        _historyTabelView.rowHeight = 40;
        _historyTabelView.dataSource = self;
        _historyTabelView.delegate = self;
        _historyTabelView.scrollEnabled = NO;
        _historyTabelView.backgroundColor = ZSColor(232, 232, 232);
    }
    return _historyTabelView;
}
- (NSMutableArray *)historyMutArray
{
    if (!_historyMutArray) {
        _historyMutArray = [NSMutableArray array];
    }
    return _historyMutArray;
}

#pragma mark -
#pragma mark - textfield代理方法实现
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -
#pragma mark - button的点击方法
//确定按钮
- (void)oKBtnBeClick
{
    if (self.inputTextField.text.length) {
        [self.historyMutArray insertObject:self.inputTextField.text atIndex:0];
        [self.historyTabelView reloadData];
        [MBProgressHUD showSuccess:@"没有找到相关内容"];
//        两秒以后退出本viewcontroller
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self.view removeFromSuperview];
        });
       
    }else {
        [MBProgressHUD showError:@"请输入内容"];
    }
}
//清除历史记录按钮的点击事件
- (void)removeHistoryBtnBeClick
{
    self.historyMutArray= nil;
    [MBProgressHUD showSuccess:@"清除成功!"];
    [self.view removeFromSuperview];
}
#pragma mark -UITableViewDataSource,UITableViewDelegate的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyMutArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = ZSColor(232, 232, 232);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.historyMutArray objectAtIndex:indexPath.row];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"历史记录";
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
