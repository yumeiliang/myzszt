//
//  UtilsHeader.h
//  DSIosFramework
//
//  Created by dingshuai on 16/1/8.
//  Copyright © 2016年 ahjz. All rights reserved.
//

#ifndef UtilsHeader_h
#define UtilsHeader_h

/********************************************************/
//导入的包
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

//打印日志
#ifdef DEBUG // 调试状态, 打开LOG功能
#define DSLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define DSLog(...)
#endif

//数据加载失败
#define DSHudError [MBProgressHUD hideHUD];\
[MBProgressHUD animateWithDuration:0.5 animations:^{\
[MBProgressHUD showError:@"数据加载失败"];}];\

//弹出对话框
#define SHOW_ALERT(_message_) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:_message_ delegate:nil cancelButtonTitle:@"我知道啦！" otherButtonTitles: nil]; \
[alert show]; \

/********************************************************/
#endif /* UtilsHeader_h */
