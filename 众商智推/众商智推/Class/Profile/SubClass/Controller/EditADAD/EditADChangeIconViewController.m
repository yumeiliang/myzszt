//
//  EditADChangeIconViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/11.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "EditADChangeIconViewController.h"

@interface EditADChangeIconViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//开关
@property (strong, nonatomic) UISwitch *eventSwitch;

//添加Btn
@property (strong, nonatomic) UIButton *addBtn;
//减少Btn
@property (strong, nonatomic) UIButton *lessBtn;
//存放图片的按钮
@property (strong, nonatomic) UIButton *addPicBtn;

@end

@implementation EditADChangeIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"profileBackImage.png"]]];
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

- (void)createContentControls
{
    //开关的view
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(5, 70, ScreenWidth - 10, 50)];
    headView.backgroundColor = [UIColor whiteColor];
    headView.layer.cornerRadius = 5;
    headView.layer.masksToBounds = YES;
    [self.view addSubview:headView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 220, 40)];
    textLabel.text = @"分享文章图标开关";
    [headView addSubview:textLabel];
    
    self.eventSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(headView.frame.size.width-60, 10, 51, 31)];
    [self.eventSwitch addTarget:self action:@selector(switchIsOnOrOff) forControlEvents:UIControlEventValueChanged];
    //    [self.swtch setOn:YES];  //开关默认状态
    [headView addSubview:self.eventSwitch];
    
    //添加照片的View
    UIView *addView = [[UIView alloc] initWithFrame:CGRectMake(5, 130, ScreenWidth - 10, 80)];
    addView.backgroundColor = [UIColor whiteColor];
    addView.layer.cornerRadius = 5;
    addView.layer.masksToBounds = YES;
    [self.view addSubview:addView];
    
    //添加图片的按钮
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(15, 8, 65, 65);
    self.addBtn.layer.cornerRadius = 5;
    self.addBtn.layer.masksToBounds = YES;
    self.addBtn.layer.borderWidth = 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.5, 0.5, 0.5, 0.4});
    self.addBtn.layer.borderColor = colorref;
    [self.addBtn setImage:[UIImage imageNamed:@"addBtn.png"] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addBtnBeClick) forControlEvents:UIControlEventTouchUpInside];
    [addView addSubview:self.addBtn];
    
    //减少图片的按钮
    self.lessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lessBtn.frame = CGRectMake(95, 8, 65, 65);
    self.lessBtn.layer.cornerRadius = 5;
    self.lessBtn.layer.masksToBounds = YES;
    self.lessBtn.layer.borderWidth = 1;
    self.lessBtn.layer.borderColor = colorref;
    [self.lessBtn setImage:[UIImage imageNamed:@"lessBtn.png"] forState:UIControlStateNormal];
    [self.lessBtn addTarget:self action:@selector(removePicEvent) forControlEvents:UIControlEventTouchUpInside];
    [addView addSubview:self.lessBtn];
    
    //添加的图片
    self.addPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addPicBtn.frame = CGRectMake(170, 10, 60, 60);
    self.addPicBtn.backgroundColor = [UIColor clearColor];
    self.addPicBtn.layer.cornerRadius = 30;
    self.addPicBtn.layer.masksToBounds = YES;
    //加载首先访问本地沙盒是否存在相关图片
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"addPicImage.png"];
    UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];
    if (savedImage) {
        [self.addPicBtn setImage:savedImage forState:UIControlStateNormal];
    }
    [addView addSubview:self.addPicBtn];
    
    UILabel *shareArticleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, ScreenWidth - 10, 40)];
    shareArticleLabel.text = @"-------------分享文章图标效果-------------";
    shareArticleLabel.textColor = [UIColor whiteColor];
    shareArticleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:shareArticleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 270, 50, 50)];
    imageView.layer.cornerRadius = 25;
    imageView.layer.masksToBounds = YES;
    imageView.image = [UIImage imageNamed:@"cloud.png"];
    [self.view addSubview:imageView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 270, 200, 40)];
    label1.text = @"depeng分享了一个链接";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:label1];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 320, 50, 50)];
    imageView1.image = [UIImage imageNamed:@"cloud.png"];
    [self.view addSubview:imageView1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(140, 320, ScreenWidth - 185, 60)];
    label2.text = @"您认得车够吗。来试试看。您能得几分？我得90分。";
    label2.font = [UIFont systemFontOfSize:15];
    label2.numberOfLines = 2;
    [self.view addSubview:label2];

    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 380, ScreenWidth - 10, 40)];
    label3.text = @"---------------------------------------------";
    label3.textColor = [UIColor whiteColor];
    label3.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:label3];
    
}
-(void)switchIsOnOrOff
{
    ZSLog(@"EditADChangeIconViewController.h---------->开关被点击");
}
#pragma mark -
#pragma mark - 添加图片的点击方法
- (void)addBtnBeClick
{
    UIAlertController *alertController;
    
    __block NSUInteger blockSourceType = 0;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //支持访问相机与相册情况
        alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //相册
            blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相机
            blockSourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            // 取消
            return;
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        //只支持访问相册情况
        alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相册
            blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:^{
                
            }];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // 取消
            return;
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }

}
#pragma mark - 选择图片后,回调选择

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [_addPicBtn setImage:image forState:UIControlStateNormal];
    [self saveImage:image withName:@"addPicImage.png"];
}

#pragma mark - 保存图片至本地沙盒

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.8);
    
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
#pragma mark -
#pragma mark - 移除添加的图片
- (void)removePicEvent
{
    [self.addPicBtn setImage:nil forState:UIControlStateNormal];
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
