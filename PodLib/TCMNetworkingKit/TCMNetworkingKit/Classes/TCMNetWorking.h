//
//  TCMNetWorking.h
//  TCMNetworking
//
//  Created by Dao on 2017/12/20.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const TCMUploadImageMark;
FOUNDATION_EXTERN NSString *const TCMRequestNologin;
FOUNDATION_EXTERN NSString *const TCMRequestError;
FOUNDATION_EXTERN NSString *const TCMRequestFail;
FOUNDATION_EXTERN NSString *const TCMRequestModel;
FOUNDATION_EXTERN NSString *const TCMRequestInfo;
FOUNDATION_EXTERN NSString *const TCMRequestFlagSuccess;
FOUNDATION_EXTERN NSString *const TCMRequestFlag;

/**
 网络请求成功Bolck

 @param obj 网络返回数据
 */
typedef void (^TCM_NS_Successed)    (__kindof NSObject* obj);

/**
 网络请求失败Block

 @param err 失败信息
 */
typedef void (^TCM_NS_Failed)       (NSError *err);

/**
 网络任务类型
 */
typedef NS_ENUM(NSUInteger, TCMNetWorkingTaskMode) {
    /**基本网络请求*/
    TCMNetWorkingTaskModeDefault,
    /**上传*/
    TCMNetWorkingTaskModeUpload,
    /**下载*/
    TCMNetWorkingTaskModeDownload,
};

@interface TCMNetWorking : NSObject
+ (NSString *)baseURLString;
@property (class, nonatomic, copy) NSString *sessionID;
@property (class, nonatomic, copy) NSString *touristID;

/**
 *  发起网络请求[仅请求参数]
 *
 *  taskMode:TCMNetWorkingTaskModeDefault
 *  @param URLString URL
 *  @param parameters 请求参数
 *  @param handler 请求结果
 */
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(NSDictionary *)parameters
           completionHandler:(void (^)(NSDictionary *dic, NSError *connectionError))handler;

/**
 *  发起网络请求[requestModel、请求参数]
 *
 *  taskMode:TCMNetWorkingTaskModeDefault
 *  @param URLString URL
 *  @param requestModel requestModel
 *  @param parameters 请求参数
 *  @param handler 请求结果
 */
+ (void)requestWithURLString:(NSString *)URLString
                requestModel:(NSString *)requestModel
                  parameters:(NSDictionary *)parameters
           completionHandler:(void (^)(NSDictionary *dic, NSError *connectionError))handler;
/**
 *  发起网络请求[requestModel、请求参数]
 *
 *  @param URLString URL
 *  @param taskMode 任务类型[TCMNetWorkingTaskMode]
 *  @param requestModel requestModel
 *  @param parameters 请求参数
 *  @param handler 请求结果
 */
+ (void)requestWithURLString:(NSString *)URLString
                    taskMode:(TCMNetWorkingTaskMode)taskMode
                requestModel:(NSString *)requestModel
                  parameters:(NSDictionary *)parameters
               completionHandler:(void (^)(NSDictionary *dic, NSError *connectionError))handler;

@end
