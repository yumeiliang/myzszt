
#import "JSONUtil.h"
#import "UtilsHeader.h"

@implementation JSONUtil

+(NSDictionary *)dictionaryWithNSData:(NSData *)data
{
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(error) {
        DSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}


+(NSArray *) arrayWithNSData:(NSData *) data
{
    NSError *error;
    NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        DSLog(@"json解析失败：%@",error);
    }
    return array;
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [self dictionaryWithNSData:jsonData];
}


+(NSArray *) arrayWithJsonString:(NSString *) jsonstring
{
    if (!jsonstring) {
        return nil;
    }
    
    NSData *jsonData=[jsonstring dataUsingEncoding:NSUTF8StringEncoding];
    return [self arrayWithNSData:jsonData];
}


+(NSString *) jsonStringWithDict:(NSDictionary *) dict
{
    NSError *error;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        DSLog(@"字典转json字符串失败：%@",error);
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+(NSString *) jsonStringWithArray:(NSArray *) array
{
    NSError *error;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        DSLog(@"数组转json字符串失败：%@",error);
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}
@end
