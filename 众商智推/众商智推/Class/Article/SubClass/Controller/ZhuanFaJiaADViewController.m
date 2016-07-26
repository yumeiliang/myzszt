//
//  ZhuanFaJiaADViewController.m
//  众商智推
//
//  Created by 杨 on 16/6/23.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ZhuanFaJiaADViewController.h"
#import "UMSocial.h"

@interface ZhuanFaJiaADViewController ()<UIScrollViewDelegate,UMSocialUIDelegate>

//分享按钮
@property (strong, nonatomic) UIButton *shareBtn;

@end

@implementation ZhuanFaJiaADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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

- (void)shareToFriend
{
    ZSLog(@"ZhuanFaJiaADViewController.m----->分享按钮没有做处理！！");
    //分享内容
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56a7007c67e58ebe480014d4" shareText:@"众商智推" shareImage:[UIImage imageNamed:@"flower.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ, nil] delegate:self];
    

}


-(void)createContentControls
{
    //背景scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
//    [scrollView setBackgroundColor:ZSColor(244, 244, 244)];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(0, 1750);
    [self.view addSubview:scrollView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, ScreenWidth - 20, 80)];
    titleLabel.text = @"假如你现在是老板，愿意聘用现在的自己吗？";
    titleLabel.numberOfLines = 2;
    titleLabel.font = [UIFont systemFontOfSize:25];
    [scrollView addSubview:titleLabel];
    
    //属性字符串
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:ZSColor(99, 132, 172),NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
    NSString *str = [[NSString alloc] initWithFormat:@"2016-06-22 博思嘉业"];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    //字体颜色
    [attributeString setAttributes:dic range:NSMakeRange(11, attributeString.length - 11)];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 105, ScreenWidth - 20, 40)];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.attributedText = attributeString;
    timeLabel.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:timeLabel];
    
    UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 145, ScreenWidth - 20, 120)];
    adImageView.image = [UIImage imageNamed:@"adIamge"];
    [scrollView addSubview:adImageView];
    
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 295, ScreenWidth - 20, 120)];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.text = @"线上HR微课堂说当一个顾客，进店时看到店里的员工低头玩手机，会有什么感觉？当你老婆总抱怨嫁给你没有过好日子的时候？当你抱怨自己买不起房子的时候？当你抱怨别人对你不够好的时候.......请先想想你又是什么样子......想想自己这一天都做了什么?                                           换位思考";
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.numberOfLines = 0;
    [scrollView addSubview:contentLabel];
    
    UILabel *contentLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 415, ScreenWidth - 20, 70)];
    contentLabel2.textColor = [UIColor blackColor];
    contentLabel2.text = @"这是一个很有意思的问题，从不同的角度，有不同的解答。";
    contentLabel2.font = [UIFont systemFontOfSize:16];
    contentLabel2.numberOfLines = 0;
    [scrollView addSubview:contentLabel2];
    
    UILabel *contentLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 495, ScreenWidth - 20, 110)];
    contentLabel3.textColor = [UIColor blackColor];
    contentLabel3.text = @"对于老板而言，这句话，更像是对员工发自内心的肺腑之言，是的，哪个老板不希望自己的员工热爱自己的企业呢？哪个老板不希望自己的员工将100%的精力都贡献给企业呢？";
    contentLabel3.font = [UIFont systemFontOfSize:16];
    contentLabel3.numberOfLines = 0;
    [scrollView addSubview:contentLabel3];
    
    UILabel *contentLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 605, ScreenWidth - 20, 110)];
    contentLabel4.textColor = [UIColor blackColor];
    contentLabel4.text = @"从这个角度来说，这句话就像是一句冲锋号，被触及的，不仅是员工的内心，更重要的是，通过换位的思考，让员工理解老板的苦衷，毕竟，做企业不容易，在经济下行的通道中，做企业，更难。";
    contentLabel4.font = [UIFont systemFontOfSize:16];
    contentLabel4.numberOfLines = 0;
    [scrollView addSubview:contentLabel4];
    
    //图1
    UIImageView *adImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 715, ScreenWidth - 100, 160)];
    adImageView3.image = [UIImage imageNamed:@"image1"];
    [scrollView addSubview:adImageView3];
    
    UILabel *contentLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 875, ScreenWidth - 20, 110)];
    contentLabel5.textColor = [UIColor blackColor];
    contentLabel5.text = @"当老板赋予员工展翅高飞的舞台的时候，也对结果提出了更高的要求，有追求的员工，一定会置身其中，因为他明白：只有在这个舞台上做得足够精彩，他的未来才能足够好。";
    contentLabel5.font = [UIFont systemFontOfSize:16];
    contentLabel5.numberOfLines = 0;
    [scrollView addSubview:contentLabel5];

    UILabel *contentLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 985, ScreenWidth - 20, 110)];
    contentLabel6.textColor = [UIColor blackColor];
    contentLabel6.text = @"当然，从员工的角度来说，尤其是对于有追求的员工来说，这句话，更是一种自省：每个人，都希望自己的价值能够最大化，而企业能够提供长袖善舞的平台，就是自己能力发挥的最佳台阶，毕竟，每个人都去创业，也不现实。";
    contentLabel6.font = [UIFont systemFontOfSize:16];
    contentLabel6.numberOfLines = 0;
    [scrollView addSubview:contentLabel6];
    
    //图2
    UIImageView *adImageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 1095, ScreenWidth - 100, 160)];
    adImageView4.image = [UIImage imageNamed:@"image2"];
    [scrollView addSubview:adImageView4];

    
    UILabel *contentLabel7 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1255, ScreenWidth - 20, 100)];
    contentLabel7.textColor = [UIColor blackColor];
    contentLabel7.text = @"每个人，都会经历自己不同的职业阶段，在每个阶段，做什么事，要有清晰的目标，这是压力，也是动力，我们唯有将发条拧得足够的紧，向前的推动力才会更加的强劲和持久。";
    contentLabel7.font = [UIFont systemFontOfSize:16];
    contentLabel7.numberOfLines = 0;
    [scrollView addSubview:contentLabel7];
    
    UILabel *contentLabel8 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1345, ScreenWidth - 20, 60)];
    contentLabel8.textColor = [UIColor blackColor];
    contentLabel8.text = @"如果你是老板，你会聘用现在的自己吗？";
    contentLabel8.font = [UIFont systemFontOfSize:16];
    contentLabel8.numberOfLines = 0;
    [scrollView addSubview:contentLabel8];

    UILabel *contentLabel9 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1365, ScreenWidth - 20, 60)];
    contentLabel9.textColor = [UIColor blackColor];
    contentLabel9.text = @"如果非常乐意，那就继续这样做下去；";
    contentLabel9.font = [UIFont systemFontOfSize:16];
    contentLabel9.numberOfLines = 0;
    [scrollView addSubview:contentLabel9];

    UILabel *contentLabel10 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1425, ScreenWidth - 20, 60)];
    contentLabel10.textColor = [UIColor blackColor];
    contentLabel10.text = @"如果相反你不愿意聘用自己，那就应该去反思你自己当下的行为！";
    contentLabel10.font = [UIFont systemFontOfSize:16];
    contentLabel10.numberOfLines = 0;
    [scrollView addSubview:contentLabel10];
    
    UILabel *contentLabel11 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1485, ScreenWidth - 20, 60)];
    contentLabel11.textColor = [UIColor blackColor];
    contentLabel11.text = @"不怕聘用没有工作经验的人，但最终放弃的是没有工作态度的人，无论你是谁！";
    contentLabel11.font = [UIFont systemFontOfSize:16];
    contentLabel11.numberOfLines = 0;
    [scrollView addSubview:contentLabel11];
    
    UILabel *contentLabel12 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1545, ScreenWidth - 20, 60)];
    contentLabel12.textColor = [UIColor blackColor];
    contentLabel12.text = @"———致所有努力的人，自省！";
    contentLabel12.font = [UIFont systemFontOfSize:16];
    contentLabel12.numberOfLines = 0;
    [scrollView addSubview:contentLabel12];
    
    UIImageView *adImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 1605, ScreenWidth - 20, 120)];
    adImageView2.image = [UIImage imageNamed:@"adIamge"];
    [scrollView addSubview:adImageView2];

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
