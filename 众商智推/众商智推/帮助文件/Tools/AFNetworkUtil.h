
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AFNetworkUtil : NSObject
/**
 *  检测网络状态
 */
+ (void)netWorkStatusExistence:(void(^)())existDeal;

/**
 *  post提交Dict数据,返回字典
 *
 *  @param urlStr     地址
 *  @param parameters 参数（NSDirectory)
 *  @param success    成功信息（字典）
 *  @param fail       失败信息
 */

+ (void)postDictWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;

/**
 *  post提交Dict数据,返回NSData
 *
 *  @param urlStr             地址
 *  @param parameters         参数（NSDirectory)
 *  @param successBackData    成功信息（NSData）
 *  @param fail               失败信息
 */
+ (void)postDictWithUrl:(NSString *)urlStr parameters:(id)parameters successBackData:(void (^)(NSData *data))success fail:(void (^)())fail;

/**
 *  下载文件－下载到沙盒的缓存中
 *
 *  @param urlStr  下载地址
 *  @param success  下载成功的操作
 *  @param fail     下载失败后的操作
 */

+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail;

/**
 *  文件上传－自定义上传文件名
 *
 *  @param urlStr     地址
 *  @param parameters 参数
 *  @param fileURL    上传文件的本地地址
 *  @param name       服务器用来解析的字段（例如：<input type="file" name="facePhoto"/>）
 *  @param fileName   上传文件的文件名
 *  @param fileTye    上传文件的类型
 *  @param success    成功的回调
 *  @param fail       失败的回调
 */
+ (void)postUploadWithUrl:(NSString *)urlStr parameters:(id)parameters fileUrl:(NSURL *)fileURL name:(NSString *)name
                 fileName:(NSString *)fileName fileType:(NSString *)fileTye success:(void (^)(id responseObject))success fail:(void (^)())fail;


/**
 *  上传图片－自定义上传图片的名字
 *
 *  @param urlStr     上传地址
 *  @param parameters 参数
 *  @param image      上传的图片对象
 *  @param name       上传图片对应的key值
 *  @param success    成功的回调
 *  @param fail       失败的回调
 */

+ (void)postUploadImageWithUrl:(NSString *)urlStr parameters:(id)parameters image:(UIImage *)image name:(NSString *)name success:(void (^)(id responseObject))success fail:(void (^)())fail;
@end
