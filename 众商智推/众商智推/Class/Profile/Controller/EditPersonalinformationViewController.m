//
//  EditPersonalinformationViewController.m
//  众商智推
//
//  Created by 杨 on 16/4/28.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "EditPersonalinformationViewController.h"
#import "EditPIView.h"
#import "EditPIDataModel.h"
#import "EditPIExtensionView.h"
#import "UserInfoModel.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"

@interface EditPersonalinformationViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
//整体的scrollView
@property (strong, nonatomic) UIScrollView *allScrollView;
//头像View
@property (strong, nonatomic) UIView *iconView;
//头像Btn
@property (strong, nonatomic) UIButton *iconBtn;
//上传头像Btn
@property (strong, nonatomic) UIButton *iconUploadBtn;
//上传头像点击Button
@property (strong, nonatomic) UIButton *iconClickButton;
//图片的保存路径
@property (strong, nonatomic) NSString *imagePath;
//informationView
@property (strong, nonatomic) EditPIView *editPIView;
//保存Button
@property (strong, nonatomic) UIButton *saveBtn;
//保存数据
@property (strong, nonatomic) EditPIDataModel *editPIDataModel;
//扩展信息View
@property (strong, nonatomic) UIView *extensionView;
//扩展信息Label
@property (strong, nonatomic) UILabel *extensionLabel;
//扩展信息Button
@property (strong, nonatomic) UIButton *extensionButton;
//扩展信息点击Button
@property (strong, nonatomic) UIButton *extensionClickButton;
//点击扩展按钮弹出的view
//@property (strong, nonatomic) ExtensionView *extensionInfoView;
@property (strong, nonatomic) EditPIExtensionView *editPIExtensionView;
//退出登录Button
@property (strong, nonatomic) UIButton *exitBtn;

@end

@implementation EditPersonalinformationViewController
#pragma mark -
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:ZSColor(230, 230, 230)];
    [self createHeadUI];
    [self createcontentUI];
    
    
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
    
    //标题按钮
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, 25, 80, 40)];
    titleLabel.text = @"个人信息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
    
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark - 创建头像UI&信息UI
- (void)createcontentUI
{
    [self.view addSubview:self.allScrollView];
    //头像view
    [self.allScrollView addSubview:self.iconView];
    [self.iconView addSubview:self.iconBtn];
    [self.iconView addSubview:self.iconUploadBtn];
    [self.iconView addSubview:self.iconClickButton];
    //编辑view
    [self.allScrollView addSubview:self.editPIView];
    //扩展view
    [self.allScrollView addSubview:self.extensionView];
    [self.extensionView addSubview:self.extensionLabel];
    [self.extensionView addSubview:self.extensionButton];
    [self.extensionView addSubview:self.extensionClickButton];
    //加载扩展按钮的点击view
    [self.allScrollView addSubview:self.editPIExtensionView];
    
    [self.allScrollView addSubview:self.saveBtn];
    [self.allScrollView addSubview:self.exitBtn];
}
#pragma mark -
#pragma mark - 懒加载
//背景轮播图
- (UIScrollView *)allScrollView
{
    if (!_allScrollView) {
        _allScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight + 100)];
        _allScrollView.delegate = self;
        //        _allScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"profileBackImage.png"]];
        _allScrollView.backgroundColor = [UIColor clearColor];
//        _allScrollView.pagingEnabled = YES;
//        _allScrollView.scrollEnabled = YES;
        //        _allScrollView.bounces = NO; // 弹簧效果
        _allScrollView.showsVerticalScrollIndicator = NO;
        _allScrollView.contentSize = CGSizeMake(0, 1200);
    }
    return _allScrollView;
}
- (UIView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth-20, 80)];
        _iconView.backgroundColor = [UIColor whiteColor];
        _iconView.layer.cornerRadius = 4;
        _iconView.layer.masksToBounds = YES;
        
    }
    return _iconView;
}
- (UIButton *)iconBtn
{
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconBtn.frame = CGRectMake(10, 10, 60, 60);
        _iconBtn.backgroundColor = [UIColor clearColor];
        _iconBtn.layer.cornerRadius = 30;
        _iconBtn.layer.masksToBounds = YES;
        
        NSString *userInfoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.txt"];//当前应用的沙盒路径
        NSMutableArray *userInfoArray = [NSKeyedUnarchiver unarchiveObjectWithFile:userInfoPath];
        UserInfoModel *userInfoModel = [userInfoArray objectAtIndex:0];
        if (!userInfoModel.iconUrlStr) {
            [_iconBtn setImage:[UIImage imageNamed:@"head_default.png"] forState:UIControlStateNormal];
        } else {
            [_iconBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userInfoModel.iconUrlStr]]] forState:UIControlStateNormal];
        }
        
        
//        //加载首先访问本地沙盒是否存在相关图片
//        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
//        UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];
//        
//        if (!savedImage)
//        {
//            //默认头像
//            [_iconBtn setImage:[UIImage imageNamed:@"head_default.png"] forState:UIControlStateNormal];
//        }
//        else
//        {
//            [_iconBtn setImage:savedImage forState:UIControlStateNormal];
//        }
    }
    return _iconBtn;
}
- (UIButton *)iconUploadBtn
{
    if (!_iconUploadBtn) {
        _iconUploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconUploadBtn.frame = CGRectMake(self.iconView.frame.size.width-140, 20, 130, 50);
        _iconUploadBtn.backgroundColor = [UIColor clearColor];
        [_iconUploadBtn setTitle:@"上传头像" forState:UIControlStateNormal];
        [_iconUploadBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_iconUploadBtn setImage:[UIImage imageNamed:@"uplodIconImage"] forState:UIControlStateNormal];
        _iconUploadBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 110, 0, 0);
        _iconUploadBtn.titleEdgeInsets = UIEdgeInsetsMake(0 , 0, 0, 10);
    }
    return _iconUploadBtn;
}
- (UIButton *)iconClickButton
{
    if (!_iconClickButton) {
        _iconClickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconClickButton.frame = CGRectMake(0, 0, self.iconView.frame.size.width, self.iconView.frame.size.height);
        _iconClickButton.backgroundColor = [UIColor clearColor];
        [_iconClickButton addTarget:self action:@selector(iconBeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconClickButton;
}
- (EditPIView *)editPIView
{
    if (!_editPIView) {
        _editPIView = [[EditPIView alloc] initWithFrame:CGRectMake(10, 104, ScreenWidth-20, 300)];
        _editPIView.backgroundColor = [UIColor whiteColor];
        _editPIView.layer.cornerRadius = 4;
        _editPIView.layer.masksToBounds = YES;
        
    }
    return _editPIView;
}
- (UIView *)extensionView
{
    if (!_extensionView) {
        _extensionView = [[UIView alloc] initWithFrame:CGRectMake(10, 414, ScreenWidth-20, 60)];
        _extensionView.backgroundColor = [UIColor whiteColor];
        _extensionView.layer.cornerRadius = 4;
        _extensionView.layer.masksToBounds = YES;
    }
    return _extensionView;
}
- (UILabel *)extensionLabel
{
    if (!_extensionLabel) {
        _extensionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
        //        _extensionLabel.backgroundColor = [UIColor cyanColor];
        _extensionLabel.text = @"扩展信息";
        _extensionLabel.textColor = [UIColor lightGrayColor];
        _extensionLabel.font = [UIFont systemFontOfSize:23];
    }
    return _extensionLabel;
}
- (UIButton *)extensionButton
{
    if (!_extensionButton) {
        _extensionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _extensionButton.frame = CGRectMake(self.extensionView.frame.size.width-50, 10, 40, 40);
        _extensionButton.backgroundColor = [UIColor clearColor];
        [_extensionButton setImage:[UIImage imageNamed:@"extensionImage"] forState:UIControlStateNormal];
    }
    return _extensionButton;
}
- (UIButton *)extensionClickButton
{
    if (!_extensionClickButton) {
        _extensionClickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _extensionClickButton.frame = CGRectMake(0, 0, self.extensionView.frame.size.width, self.extensionView.frame.size.height);
        _extensionClickButton.backgroundColor = [UIColor clearColor];
//        [_extensionClickButton addTarget:self action:@selector(extensionBeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _extensionClickButton;
}

- (EditPIExtensionView *)editPIExtensionView
{
    if (!_editPIExtensionView) {
        _editPIExtensionView = [[EditPIExtensionView alloc] initWithFrame:CGRectMake(10, 470, ScreenWidth-20, 280)];
        _editPIExtensionView.backgroundColor = [UIColor whiteColor];
        _editPIExtensionView.layer.cornerRadius = 4;
        _editPIExtensionView.layer.masksToBounds = YES;
        
    }
    return _editPIExtensionView;
}

//完成Button
- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _saveBtn.frame = CGRectMake(10, 500, ScreenWidth-20, 50);
        _saveBtn.frame = CGRectMake(10, 770, ScreenWidth-20, 50);
        _saveBtn.backgroundColor = ZSColor(0, 211, 100);//[UIColor colorWithRed:0/255.0 green:211/255.0 blue:100/255.0 alpha:1];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        _saveBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_saveBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [_saveBtn addTarget:self action:@selector(saveInformationMethod) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.layer.cornerRadius = 5;
        _saveBtn.layer.masksToBounds = YES;
        //        if (self.editView.nameTextField.text.length != 0) {
        //            _saveBtn.enabled = YES;
        //        }else{
        //            _saveBtn.enabled = NO;
        //        }
        
    }
    return _saveBtn;
}
//退出登录Button
- (UIButton *)exitBtn
{
    if (!_exitBtn) {
        _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitBtn.frame = CGRectMake(10, 830, ScreenWidth-20, 50);
        _exitBtn.backgroundColor = ZSColor(0, 211, 100);
        [_exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        _exitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _exitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_exitBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [_exitBtn addTarget:self action:@selector(exitBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        _exitBtn.layer.cornerRadius = 5;
        _exitBtn.layer.masksToBounds = YES;
    }
    return _exitBtn;
}


#pragma mark -
#pragma mark - Button的点击事件
- (void)iconBeClick
{
    UIAlertController *alertController;
    
    __block NSUInteger blockSourceType = 0;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //支持访问相机与相册情况
        alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            ZSLog(@"点击从相册中选取");
            //相册
            blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            ZSLog(@"点击拍照");
            //相机
            blockSourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            ZSLog(@"点击取消");
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
            
            ZSLog(@"点击从相册中选取");
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
            
            ZSLog(@"点击取消");
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
    
    /* 此处info 有六个可选类型
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    
    [_iconBtn setImage:image forState:UIControlStateNormal];
    [self saveImage:image withName:@"currentImage.png"];
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
#pragma mark - 保存用户编辑的信息
- (void)saveInformationMethod
{
    /*
     //通知传值
     self.editDataModel = [[EditDataModel alloc] init];
     self.editDataModel.nameString = self.editView.nameTextField.text;
     self.editDataModel.telephoneString = self.editView.telephoneTextField.text;
     self.editDataModel.jobString = self.editView.jobTextField.text;
     self.editDataModel.companyString = self.editView.companyTextField.text;
     [[NSNotificationCenter defaultCenter] postNotificationName:@"passValue" object:self.editDataModel];
     */
    
    //保存用户编辑的信息
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"regist.txt"];//当前应用的沙盒路径
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];//将沙盒路径下的归档对象解档出来
    //    NSString *imageString = (NSString *)[NSKeyedArchiver keyPathsForValuesAffectingValueForKey:self.imagePath];
    
    if (array == nil) {
        array = [NSMutableArray array];
    }
    //用户基本信息
    self.editPIDataModel = [[EditPIDataModel alloc] init];
    self.editPIDataModel.nameString = self.editPIView.nameTextField.text;
    self.editPIDataModel.telephoneString = self.editPIView.telephoneTextField.text;
    self.editPIDataModel.jobString = self.editPIView.jobTextField.text;
    self.editPIDataModel.companyString = self.editPIView.companyTextField.text;
    self.editPIDataModel.qqString = self.editPIView.qqTextField.text;
    
    //用户扩展信息
    self.editPIDataModel.emailString = self.editPIExtensionView.emailTextField.text;
    self.editPIDataModel.WXAccountString = self.editPIExtensionView.WXAccountTextField.text;
    self.editPIDataModel.addressString = self.editPIExtensionView.addressTextField.text;
    self.editPIDataModel.focusString = self.editPIExtensionView.focusTextField.text;
    self.editPIDataModel.findString = self.editPIExtensionView.findTextField.text;
    
    [array insertObject:self.editPIDataModel atIndex:0];
    
    //    [self.iconBtn setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    /* 1. 先读取沙盒中存储的信息
     * 2. 在原有的信息上拼接     NSArray = @[arr1, arr2, arr3];
     * 3. 加判断  如果姓名，邮箱地址，密码，性别没有值，就不存储且给用户提示
     * 4. 如果用到沙盒中存储的信息，遍历数组的内容加以判断
     */
    
    //把刚才写的数组存到沙盒当中去
    if ([NSKeyedArchiver archiveRootObject:array toFile:path]) {
        ZSLog(@"信息保存成功");
        //        [self changeEnable];
        [self goBack];
    }else{
        ZSLog(@"信息保存失败");
    }
    
    ZSLog(@"%@",path);
    //打印数组中的元素
    //    NSArray *list = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    //    ZSLog(@"%@",list);
    
    //用通知传值显示改变编辑后的内容
    NSNumber *number = [[NSNumber alloc] initWithInt:1];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"passValue" object:number];
    
}

- (void)exitBtnMethod
{
    ZSLog(@"退出登录");
    //删除三方登录的数组里的信息
    NSString *userInfoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.txt"];//当前应用的沙盒路径
    NSMutableArray *userInfoArray = [NSKeyedUnarchiver unarchiveObjectWithFile:userInfoPath];
//    for (int i =0; i < [userInfoArray count]; i++) {
//        UserInfoModel *userInfoModel = [userInfoArray objectAtIndex:0];
//        model.userNameStr = nil;
//        model.iconUrlStr = nil;
//    }
    [userInfoArray removeAllObjects];
    
    ZSLog(@"%@",userInfoArray);
    
    ZSLog(@"%@",userInfoPath);
    
    //切换用户
//     LoginViewController *profileVC = [LoginViewController share];
//    [self presentViewController:profileVC animated:YES completion:nil];
    
    //删除文件路径
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    [fileManager removeItemAtPath:userInfoPath error:nil];
    
    if ([self.delegate respondsToSelector:@selector(deleteUserInfoPathMethod)]) {
        NSString *str = @"删除成功";
        [self.delegate performSelector:@selector(deleteUserInfoPathMethod) withObject:str];
    }

    
    
    
    [self goBack];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
