//
//  NtalkerHTTPReportPushStatusTool.h
//  NTalkerIMCore
//
//  Created by 张二猛 on 2018/10/17.
//  Copyright © 2018年 NTalker. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^successBlock)(id respone);
//typedef void(^failurBlock)(NSString *error);

@interface NtalkerHTTPReportPushStatusTool : NSObject

+ (instancetype)shareManager;

//取消请求
- (void)cancel;

/**
 注册devicetoken

 @param URLString 注册地址
 @param param 参数
 @param requestCount 请求次数
 @param success 功回调
 @param failure 失败回调
 */
- (void)registerPushRequest:(NSString *)URLString
                      param:(NSDictionary *)param
               requestCount:(NSUInteger)requestCount
                    success:(void(^)(id responseObject))success
                    failure:(void(^)(NSString *error))failure;
/**
 上报状态
 
 @param URLString 上报IM状态地址
 @param param 参数
 @param requestCount 请求次数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)reportDeviceStatusWithUrlString:(NSString *)URLString
                                  param:(NSDictionary *)param
                           requestCount:(NSInteger)requestCount
                                success:(void(^)(id responseObject))success
                                failure:(void(^)(NSString *error))failure;

/**
 解绑推送服务
 
 @param URLString 解绑地址
 @param param 参数
 @param requestCount 请求次数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)removeDeviceStatusWithUrlString:(NSString *)URLString
                                  param:(NSDictionary *)param
                           requestCount:(NSInteger)requestCount
                                success:(void(^)(id responseObject))success
                                failure:(void(^)(NSString *error))failure;


@end


