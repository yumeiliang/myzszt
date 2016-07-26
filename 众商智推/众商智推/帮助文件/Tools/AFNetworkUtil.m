
#import "AFNetworkUtil.h"
#import "AFNetworking.h"
#import "UtilsHeader.h"
#import "JSONUtil.h"

@implementation AFNetworkUtil

/**
 AFNetworkReachabilityStatusUnknown          = -1,  // 未知
 AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
 AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
 AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
 */

+ (void)netWorkStatusExistence:(void(^)())existDeal
{
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status==AFNetworkReachabilityStatusUnknown || status==AFNetworkReachabilityStatusNotReachable) {
            SHOW_ALERT(@"网络链接不可用，请检查网络");
            return;
        }else{
            if (existDeal) {
                existDeal();
            }
            
        }
    }];
}

+ (void)postDictWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    //在向服务端发送请求状态栏显示网络活动标志：
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求结束状态栏隐藏网络活动标志：
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        //转化成字符串
        DSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        //转化成字典
        NSDictionary *dict=[JSONUtil dictionaryWithNSData:responseObject];
        if (success) {
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求结束状态栏隐藏网络活动标志：
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        DSLog(@"%@", error);
        if (fail) {
            fail();
        }
        //错误信息提示
        DSHudError;
    }];
}

+ (void)postDictWithUrl:(NSString *)urlStr parameters:(id)parameters successBackData:(void (^)(NSData *data))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //在向服务端发送请求状态栏显示网络活动标志：
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求结束状态栏隐藏网络活动标志：
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        DSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求结束状态栏隐藏网络活动标志：
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        DSLog(@"%@", error);
        if (fail) {
            fail();
        }
        //错误信息提示
        DSHudError;
    }];
}


+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString *urlString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet controlCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //在向服务端发送请求状态栏显示网络活动标志：
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 将下载文件保存在缓存路径中
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        //请求结束状态栏隐藏网络活动标志：
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        DSLog(@"%@ %@", filePath, error);
        
        if (!error) {
            //成功
            if (success) {
                success(filePath);
            }
        }else{
            //失败
            if (fail) {
                fail();
            }
        }
        
    }];
    
    [task resume];
}



+ (void)postUploadWithUrl:(NSString *)urlStr parameters:(id)parameters fileUrl:(NSURL *)fileURL name:(NSString *)name
                 fileName:(NSString *)fileName fileType:(NSString *)fileTye success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //在向服务端发送请求状态栏显示网络活动标志：
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileURL:fileURL name:name fileName:fileName mimeType:fileTye error:nil];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求结束状态栏隐藏网络活动标志：
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        //转化成字符串
        DSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        //转化成字典
        NSDictionary *dict=[JSONUtil dictionaryWithNSData:responseObject];
        if (success) {
            success(dict);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求结束状态栏隐藏网络活动标志：
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        if (fail) {
            fail();
        }
    }];
}

+ (void)postUploadImageWithUrl:(NSString *)urlStr parameters:(id)parameters image:(UIImage *)image name:(NSString *)name success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置响应格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //在向服务端发送请求状态栏显示网络活动标志：
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置日期格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",str];
        
        NSData *data = UIImageJPEGRepresentation(image, 0.9);
        [formData appendPartWithFileData:data name:name fileName:[NSString stringWithFormat:@"%@",fileName] mimeType:@"image/jpeg"];

    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求结束状态栏隐藏网络活动标志：
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        //转化成字符串
        DSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        //转化成字典
        NSDictionary *dict=[JSONUtil dictionaryWithNSData:responseObject];
        if (success) {
            success(dict);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求结束状态栏隐藏网络活动标志：
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        if (fail) {
            fail();
        }

    }];
}

@end
