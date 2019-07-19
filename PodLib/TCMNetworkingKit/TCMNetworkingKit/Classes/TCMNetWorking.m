//
//  TCMNetWorking.m
//  TCMNetworking
//
//  Created by Dao on 2017/12/20.
//

#import "TCMNetWorking.h"
#import <AFNetworking/AFNetworking.h>

NSString *const TCMRequestNologin = @"noLogin";
NSString *const TCMRequestError = @"error";
NSString *const TCMRequestFail = @"fail";
NSString *const TCMRequestModel = @"requestmodel";
NSString *const TCMRequestInfo = @"info";
NSString *const TCMRequestFlagSuccess = @"success";
NSString *const TCMRequestFlag = @"op_flag";

/**淘菜猫开发环境BaseURL*/
static NSString *const kNetworkServicePlatformDevelopment = @"http://115.159.31.56:80/taocaimall";
/**淘菜猫测试环境BaseURL*/
static NSString *const kNetworkServicePlatformTest = @"http://app.taocaimall.com/taocaimall";
/**淘菜猫预发布环境BaseURL*/
static NSString *const kNetworkServicePlatformPrepare = @"http://uatview.taocaimall.com/taocaimall";
/**淘菜猫生产环境BaseURL*/
#ifndef TCM_NETWORK_SERVICE_PLATFORM_PRODUCTION
    static NSString *const kNetworkServicePlatformProduction = @"https://m.taocaimall.com/taocaimall";
#else
    static NSString *const kNetworkServicePlatformProduction = TCM_NETWORK_SERVICE_PLATFORM_PRODUCTION;
#endif
/**网络提示语*/
NSString *const TCMNetworkServiceCrashInfo = @"网络出了点小问题，请重试下哦~";
/**服务器重启通知*/
NSString *const TCMNetworkServiceNotification = @"RPCEngineServerResetNotification";
NSString *const TCMUserStateLogout = @"TCMUserStateLogout";
/**图片加载标识*/
NSString *const TCMUploadImageMark = @"UploadImageMark";
/**登录标识*/
NSString *const TCMLoginMark = @"LoginMark";
/**网络超时20S*/
NSInteger const TCMRequestTimeOut_20 = 20;
/**网络超时60S*/
NSInteger const TCMRequestTimeOut_60 = 60;


#ifndef TCM_NETWORKING_CACHES

#define TCM_NETWORKING_CACHES   0

#endif

#define NSLog(...) printf("TCMNetWorking.Framework:\n%s\n", [[NSString stringWithFormat:__VA_ARGS__] UTF8String])

@implementation TCMNetWorking


+ (NSString *)baseURLString{
    return kNetworkServicePlatformDevelopment;
}


+ (void)requestWithURLString:(NSString *)URLString
             requestModel:(NSString *)requestModel
               parameters:(NSDictionary *)parameters
          timeoutInterval:(NSTimeInterval)timeoutInterval
        completionHandler:(void (^)(NSDictionary *, NSError *))handler{
    //构建请求URL
    NSString *relativeString = [NSString stringWithFormat:@"%@/%@",self.baseURLString, [URLString hasSuffix:@".json"] ? URLString : [URLString hasSuffix:@".htm"] ? URLString : [NSString stringWithFormat:@"%@.json",URLString]];
    NSLog(@"%@:请求参数：%@\n",relativeString,parameters);

    //构建请求参数
    NSMutableDictionary *par = [[NSMutableDictionary alloc] init];
    if (requestModel.length) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [par setValue:jsonStr forKey:requestModel];
    } else {
        par = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }

    //构建请求
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:relativeString parameters:par error:nil];
    request.timeoutInterval = timeoutInterval;
    if (self.sessionID.length) {
        [request setValue:[NSString stringWithFormat:@"JSESSIONID=%@",self.sessionID] forHTTPHeaderField:@"Cookie"];
    }
    if (self.touristID.length) {
        [request setValue:self.touristID forHTTPHeaderField:@"TouristId"];
    }

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    if (isWeb){
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    }else{
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    }

    //构建并发起网络请求
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSError *err;
        if (error ||
            [[responseObject valueForKey:TCMRequestFlag] isEqualToString:TCMRequestFail] ||
            [[responseObject valueForKey:TCMRequestFlag] isEqualToString:TCMRequestError]) {
            NSString *str = [responseObject valueForKey:TCMRequestInfo];
            if (!str) {
                str = [self handleError:error];
            }
            err = [NSError errorWithDomain:str code:error.code userInfo:nil];
        } else {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary*)responseObject;
               if (/*UserState == Login &&*/[dic[TCMRequestFlag] isEqualToString:TCMRequestNologin]) {
                   //服务器重启？
                   [[NSNotificationCenter defaultCenter] postNotificationName:TCMNetworkServiceNotification object:nil];
                   //用户登出
                   [[NSNotificationCenter defaultCenter] postNotificationName:TCMUserStateLogout object:nil];
                } else {
                    [self saveCaches:responseObject WithKey:[self getCacheskeyWithInterface:relativeString parameters:parameters]];
                }
            }
        }

        //请求失败，读取本地缓存
        id caches = nil;
        if (err) {
            caches = [self getCachesWithKey:[self getCacheskeyWithInterface:relativeString parameters:parameters]];
            if (caches) {
                responseObject = caches;
            }
        }

        handler(responseObject,err);
    }];
    [dataTask resume];
}

+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(NSDictionary *)parameters
           completionHandler:(void (^)(NSDictionary *, NSError *))handler{
    [self requestWithURLString:URLString taskMode:TCMNetWorkingTaskModeDefault requestModel:nil parameters:parameters completionHandler:handler];
}
+ (void)requestWithURLString:(NSString *)URLString
                requestModel:(NSString *)requestModel
                  parameters:(NSDictionary *)parameters
           completionHandler:(void (^)(NSDictionary *, NSError *))handler{
    [self requestWithURLString:URLString taskMode:TCMNetWorkingTaskModeDefault requestModel:requestModel parameters:parameters completionHandler:handler];
}
+ (void)requestWithURLString:(NSString *)URLString
                    taskMode:(TCMNetWorkingTaskMode)taskMode
                requestModel:(NSString *)requestModel
                  parameters:(NSDictionary *)parameters
           completionHandler:(void (^)(NSDictionary *, NSError *))handler{
    NSTimeInterval timeoutInterval = TCMRequestTimeOut_20;
    switch (taskMode) {
        case TCMNetWorkingTaskModeDefault:
            timeoutInterval = TCMRequestTimeOut_20;
            break;
            case TCMNetWorkingTaskModeUpload:
            case TCMNetWorkingTaskModeDownload:
            timeoutInterval = TCMRequestTimeOut_60;
            break;
    }

    [self requestWithURLString:URLString requestModel:requestModel parameters:parameters timeoutInterval:timeoutInterval completionHandler:handler];
}

+ (NSString *)handleError:(NSError *)error{
    return @"网络异常，暂未处理";
}

#pragma mark - 本地数据缓存
+ (void)saveCaches:(id)caches WithKey:(NSString *)key{
#if !TCM_NETWORKING_CACHES
    return ;
#else
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *path = [self getCachesPathWithKey:key];
        [NSKeyedArchiver archiveRootObject:caches toFile:path];
    });
#endif
}

+ (id)getCachesWithKey:(NSString *)key{
#if !TCM_NETWORKING_CACHES
    return nil;
#else
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        return nil;
    } else {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getCachesPathWithKey:key]];
    }
#endif
}

+ (NSString *)getCachesPathWithKey:(NSString *)key{
#if !TCM_NETWORKING_CACHES
    return nil;
#else
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *path = [cachesDirectory stringByAppendingPathComponent:@"TCMCaches"];
    NSString *str = [path stringByAppendingPathComponent:key];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:0];
    }
    return str;
#endif
}

+ (NSString *)getCacheskeyWithInterface:(NSString *)interface parameters:(NSDictionary *)parameters{
#if !TCM_NETWORKING_CACHES
    return nil;
#else
    interface = [interface stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSMutableString *str = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"%@%@", key, obj];
    }];
    return [NSString stringWithFormat:@"%@%@", interface,str];
#endif
}


static NSString *kSessionID = nil;
static NSString *const kSessionIDIdentifier = @"kSessionIDIdentifier";
+ (void)setSessionID:(NSString *)sessionID{
    kSessionID = sessionID;
    [[NSUserDefaults standardUserDefaults] setObject:kSessionID forKey:kSessionIDIdentifier];
}
+ (NSString *)sessionID{
    if (!kSessionID) {
        kSessionID = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionIDIdentifier];
    }
    return kSessionID;
}

static NSString *kTouristID = nil;
static NSString *const kTouristIDIdentifier = @"kTouristIDIdentifier";
+ (void)setTouristID:(NSString *)touristID{
    kTouristID = touristID;
    [[NSUserDefaults standardUserDefaults] setObject:kTouristID forKey:kTouristIDIdentifier];
}
+ (NSString *)touristID{
    if (!kTouristID) {
        kTouristID = [[NSUserDefaults standardUserDefaults] objectForKey:kTouristIDIdentifier];
    }
    return kTouristID;
}

@end
