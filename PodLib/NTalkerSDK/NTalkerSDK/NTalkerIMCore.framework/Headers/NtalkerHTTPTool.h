//
//  NtalkerHTTPTool.h
//
//
//  Created by mac on 2017/2/22.
//  Copyright © 2017年 NTalker. All rights reserved.
// 网络请求工具类


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,HttpState){
    GET,
    POST,
};

typedef void(^Completion)(id respone,BOOL isSuccess);
typedef void(^successBlock)(id respone);
typedef void(^failureBlock)(NSError *error);

@interface NtalkerHTTPTool : NSObject

+ (instancetype)shareManager;


/**
 get/post 网络请求方法

 @param state GET/ POST
 @param urlStr 请求地址
 @param dic 请求参数
 @param completion 回调
 */
- (void)requeset:(HttpState)state withURLString:(NSString*)urlStr withParma:(NSDictionary *)dic completion:(Completion)completion;
#pragma mark - 网络请求方法
/**
 发送post网络请求
 
 @param urlString 请求地址
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (NSURLSessionDataTask *)ntalker_POST:(NSString *)urlString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure;
/**
 发送get网络请求
 
 @param urlString 请求地址
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (NSURLSessionDataTask *)ntalker_GET:(NSString *)urlString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure;

/**
 上传图片
 
 @param path 图片本地路径
 @param parameters 参数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)ntalker_uploadPictureWithLocalPath:(NSString *)path  parameters:(id)parameters success:(successBlock)successBlock failure:(failureBlock)failureBlock;
/**
 上传音频
 
 @param path 音频本地路径
 @param parameters 参数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)ntalker_uploadAudioWithLocalPath:(NSString *)path  parameters:(id)parameters success:(successBlock)successBlock failure:(failureBlock)failureBlock;
/**
 上传视频
 
 @param path 视频本地路径
 @param parameters 参数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)ntalker_uploadVideoWithLocalPath:(NSString *)path  parameters:(id)parameters success:(successBlock)successBlock failure:(failureBlock)failureBlock;

/**
 下载小视频

 @param URLStr 视频网络地址
 @param params 参数
 @param completeHandle 回调
 */
- (void)sendDownloadVideoRequest:(NSString *)URLStr param:(id)params completeHandle:(void(^)(NSURL *videoURL))completeHandle;


///轨迹上传接口
- (void)ntalker_postTrail:(NSString *)urlString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
