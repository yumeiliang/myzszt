//·
//  WebViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/15.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "WebViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialSnsData.h"
#import "UIImageView+WebCache.h"

#import "ZhuanFaJiaADViewController.h"


@interface WebViewController ()<UMSocialUIDelegate>

//分享的标题
@property (strong, nonatomic) NSString *shareTitle;
//分享的图片
@property (strong, nonatomic) UIImage *shareImage;
//立即转换的view
@property (strong, nonatomic) UIView *changeView;
//立即转换按钮
@property (strong, nonatomic) UIButton *changeBtn;

@end

@implementation WebViewController

#pragma mark -
#pragma mark - 获得上一个控制器传过来的url
//从任务界面传过来的模型
- (void)jiaZaiDataWithTaskModel:(TaskAllModel *)model
{
    self.shareUrl = model.urlStr;
    self.shareTitle = model.titleStr;
    if (model.ImageViewStr) {
        NSData *urlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.ImageViewStr]];
        self.shareImage = [UIImage imageWithData:urlData];
    }else{
        self.shareImage = [UIImage imageNamed:@"flower.png"];
    }
    
}
//从19个按钮的界面传过来的模型
-(void)jiaZaiDataWithModel:(ArticleListModel *)model
{
    self.shareUrl = model.url;
    self.shareTitle = model.title;
    if (model.titleimage) {
        NSData *urlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.titleimage]];
        self.shareImage = [UIImage imageWithData:urlData];
    }else{
        self.shareImage = [UIImage imageNamed:@"flower.png"];
    }
}
#pragma mark -
#pragma mark - 生命周期
- (void)viewDidLoad {
    
    //郁金香
//    http://travel.sohu.com/20150419/n411508946.shtml
    //有道词典网址
//    http://xue.youdao.com/bbs/post_detail?id=67957
    
    [super viewDidLoad];
    [self createHeadUI];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    //加载web视图
    [self createWebView];
    //设置微信分享Appkey  微信开放平台注册的应用的AppId和appSecret
    [UMSocialWechatHandler setWXAppId:@"wx9c560386596469e2" appSecret:@"a9d1210a2f185bb77e3b1c49c6de5731" url:self.shareUrl];
    //设置QQ分享的appkey
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:self.shareUrl];
    //分享音乐或者视屏的url--------无效果
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeDefault url:self.shareUrl];
    
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
//    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //分享按钮
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame = CGRectMake(ScreenWidth-80, 25, 80, 40);
    [self.shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.shareBtn.backgroundColor = [UIColor redColor];
    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(shareToFriend) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.shareBtn];
    
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - 分享
- (void)shareToFriend
{
    //分享的链接
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:self.shareUrl];
    [UMSocialData defaultData].extConfig.title = self.shareTitle;
    //朋友圈的title
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.shareTitle;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;//分享到微信朋友圈的内容
   //分享到朋友圈的url
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx0e611015de998d2b&redirect_uri=http%3A%2F%2Fbj.wzswx.com%2Fweika%2Farticle_fenxiang.action%3fuid%3doJ_pht3dB9LYRz04HbjmwD5nv8RI%26articleid%3df5c0a7037c9f47d186ea86276c4e88ec&response_type=code&scope=snsapi_base&state=STATE&from=timeline&isappinstalled=0";//带广告的url
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.shareUrl;//wechatSessionData,sinaData wechatTimelineData
    //分享到QQ空间的url
    [UMSocialData defaultData].extConfig.qqData.url = self.shareUrl;
    //    注意当URL图片和UIImage同时存在时，只有URL图片生效
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5770d3e6e0f55ab09e00079c"
                                      shareText:self.shareTitle
                                     shareImage:[UIImage imageNamed:@"flower.png"]
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ]
                                       delegate:self];
     //友盟的key和secret
    //8a653f9fa318f2ce7b76f22d85c4370e
    //56a7007c67e58ebe480014d4
  
//    用下面的代码打开我们SDK在控制台的输出后能看到相应的错误码
    [UMSocialData openLog:YES];
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

+(BOOL)handleOpenURL:(NSURL *)url wxApiDelegate:(id<WXApiDelegate>)wxApiDelegate
{
    return YES;
}

/**
 Deprecated APIs
 发送微博内容到多个微博平台
 
 @param platformTypes       分享到的平台，数组的元素是`UMSocialSnsPlatformManager.h`定义的平台名的常量字符串，例如`UMShareToSina`，`UMShareToTencent`等。
 @param content             分享的文字内容
 @param image               分享的图片
 @param location            分享的地理位置信息
 @param urlResource         图片、音乐、视频等url资源
 @param completion          发送完成执行的block对象
 
 */

//- (void)postSNSWithTypes:(NSArray *)platformTypes
//                 content:(NSString *)content
//                   image:(id)image
//                location:(CLLocation *)location
//             urlResource:(UMSocialUrlResource *)urlResource
//              completion:(UMSocialDataServiceCompletion)completion
//{
//    
//}

#pragma mark -
#pragma mark - 创建webview
- (void)createWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 65)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.shareUrl]]];
    [webView allowsPictureInPictureMediaPlayback];
    [self.view addSubview:webView];
    
    self.changeView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 40, ScreenWidth, 40)];
    self.changeView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.changeView];
    
    self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeBtn.frame = CGRectMake(self.changeView.frame.size.width/2 - 65, 2 , 130, 36);
    self.changeBtn.backgroundColor = [UIColor clearColor];
//    self.changeBtn.layer.cornerRadius = 5;
//    self.changeBtn.layer.masksToBounds = YES;
//    [self.changeBtn setTitle:@"立即转换" forState:UIControlStateNormal];
//    [self.changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.changeBtn addTarget:self action:@selector(changeBtnBeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.changeView addSubview:self.changeBtn];
}

#warning -----------------------------------------------------------------------------------------
- (void)changeBtnBeClick
{
    [MBProgressHUD showMessage:@"正在转换"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ZhuanFaJiaADViewController *zhuanFaVC = [[ZhuanFaJiaADViewController alloc] init];
        [self presentViewController:zhuanFaVC animated:YES completion:nil];
        [MBProgressHUD hideHUD];
    });
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
