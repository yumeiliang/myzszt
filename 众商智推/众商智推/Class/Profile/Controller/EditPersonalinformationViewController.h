//
//  EditPersonalinformationViewController.h
//  众商智推
//
//  Created by 杨 on 16/4/28.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
//传值的协议
@protocol DeleteUserInfoPathDelegate <NSObject>

-(void)deleteUserInfoPathMethod;


@end

@interface EditPersonalinformationViewController : UIViewController

//实现协议的代理
@property (strong, nonatomic) id<DeleteUserInfoPathDelegate> delegate;


@end
