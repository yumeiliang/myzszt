//
//  AppDelegate.m
//  众商智推
//
//  Created by 杨 on 16/4/8.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchingViewController.h"
#import "NewfeatureViewController.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "WXApi.h"
#import "WXApiObject.h"
//#import "WXApiManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //友盟appKey   改了两处5770d3e6e0f55ab09e00079c  原来的为56a7007c67e58ebe480014d4    webViewcontroller
    [UMSocialData setAppKey:@"5770d3e6e0f55ab09e00079c"];
    
//    //设置微信分享Appkey
    [UMSocialWechatHandler setWXAppId:@"wx9c560386596469e2" appSecret:@"a9d1210a2f185bb77e3b1c49c6de5731" url:@"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf0e81c3bee622d60&redirect_uri=http%3A%2F%2Fnba.bluewebgame.com%2Foauth_response.php&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"];
    //设置QQ分享的appkey
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"b65df68fd13efe2842da5e141bc8d8a9" url:nil];
    //向微信注册wxd930ea5d5a258f4f
    [WXApi registerApp:@"wx9c560386596469e2" withDescription:@"demo 2.0"];
    
    //返回的Url网址   微信消息url地址
//    http://www.umeng.com/social
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置跟控制器
    NSString *key = @"CFBundleVersion";
    //上一次使用的版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //当前软件的版本号（从Info.plist中获取）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        LaunchingViewController *launchVC = [[LaunchingViewController alloc] init];
        self.window.rootViewController = launchVC;
    }else {
        //这次打开的版本和上次不一样，显示新特性
        self.window.rootViewController = [[NewfeatureViewController alloc] init];
        //将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}


//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //调用其他SDK，例如支付宝SDK等
//    }
//    return result;
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
