//
//  NtalkerSDKCore.h
//  NtalkerIMLib
//
//  Created by wzh on 2017/12/21.
//  Copyright © 2017年 Ntalker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NtalkerCoreConstant.h"

typedef NS_ENUM(NSInteger, NTALKER_STATUS) {
    NTALKER_STATUS_CONNECTING = 0,
    NTALKER_STATUS_SUCCESS,
    NTALKER_STATUS_FAILURE,
};

@class NtalkerEventModel,NtalkerWebModel,NtalkerOrderModel,NtalkerProductModel, NtalkerCoreMessage,NtalkerLeaveMsgDetailModel,NtalkerFlashServerModel,NtalkerTemplateRecord,NtalkerSiteInfo;

@protocol NtalkerSDKCoreDelegate <NSObject>

@optional
///下行消息
- (void)ntalkerDidMessageReceive:(NtalkerCoreMessage *)message;
///消息发送成功的回执
- (void)ntalkerDidMessageDeliver:(NtalkerCoreMessage *)message;
///接收到预知消息
- (void)ntalkerRemoteNotifyOnPredictMessage:(NSDictionary *)dict;
///接收到机器人转人工失败
- (void)ntalkerRemoteNotifyRobotSwitchArtiFail:(NSDictionary *)dict;
///未读消息数
- (void)ntalkerOnUnReadMessage:(NSDictionary *)dict;
///排队信息
- (void)ntalkerRemoteNotifyQueueInformation:(NSDictionary *)dict;
///邀请评价
- (void)ntalkerRemoteNotifyInviteConversationEvaluation:(NSDictionary *)dict;
///会话信息
- (void)ntalkerRemoteNotifyConversationInformation:(NSDictionary *)dict;
///会话成员信息变化事件
- (void)ntalkerRemoteNotifyConversationMemberInfo:(NSDictionary *)dict;
///会话状态
- (void)ntalkerConversationStatus:(NTALKER_STATUS )status;
///客服离开
- (void)ntalkerCustomerServiceOffLine:(NSString *)converId userId:(NSString *)userId userName:(NSString *)name type:(NSInteger)type;;
///客服退出会话
- (void)ntalkerCustomerServiceExitConversation:(NSString *)converId userId:(NSString *)userId userName:(NSString *)name type:(NSInteger)type;
///客服离开后又再次在线
- (void)ntalkerCustomerServiceLeaveConversation:(NSString *)converId userId:(NSString *)userId userName:(NSString *)name type:(NSInteger)type;
///客服在线
- (void)ntalkerCustomerServiceOnLine:(NSString *)converId userId:(NSString *)userId userName:(NSString *)name sessionType:(NSInteger)type;
///会话成员发送变化
- (void)ntalkerRemoteNotifyConversationMemberInfoChange:(NSString *)converId name:(NSString *)name chatstatus:(NSInteger)chatstatus;
///会话终止事件
- (void)ntalkerRemoteNotifyConversationTerminated:(NSDictionary *)dict;

///获取到历史消息
- (void)ntalkerDidFetchHistoryMessages:(NSMutableArray <NtalkerCoreMessage *>*)mesages;
///访客被加入黑名单
- (void)ntalkerForbiddenConversation:(NSString *)converId userId:(NSString *)userId;
/** 获取聊天配置成功 */
- (void)ntalkerFetchSDKConfigSuccess;
/** 获取聊天配置失败 */
- (void)ntalkerFetchSDKConfigFailure;

//干系人发起一个视频聊天
- (void)ntalkerRemoteNotifyStreamMedia:(NSDictionary *)dict;
//干系人相应视频聊天结果
- (void)ntalkerRemoteNotifyCallBackStreamMedia:(NSDictionary *)dict;
//干系人离开视频聊天
- (void)ntalkerRemoteNotifyLeaveStreamMedia:(NSDictionary *)dict;
//当视频会话中少于两人时，中止视频聊天
- (void)ntalkerRemoteNotifyStopStreamMedia:(NSDictionary *)dict;
//获取干系人待处理的视频聊天列表
- (void)ntalkerRemoteNotifyGetStreamMedia:(NSDictionary *)dict;

@end

typedef void(^successBlock)(id respone);
typedef void(^failureBlock)(NSError *error);
typedef void(^templateSuccessBlock)(NSArray *templateArray);
typedef void(^templateFailureBlock)(NSError *error);
typedef void(^completion)(BOOL finished , NSUInteger code);

typedef void(^messagesDidReceive)(NtalkerCoreMessage *message);
typedef void(^messagesDidDeliver)(NtalkerCoreMessage *message);

typedef void(^DidDeliverBlock)(NSDictionary *message);
typedef void(^reportPushStatusCompletion)(id response);

typedef void(^getRobotInputGuideCompletion)(BOOL isSuccess, id response);

@interface NtalkerSDKCore : NSObject

/**
 记得一定要在不使用时置为空
 */
@property (nonatomic, weak) id<NtalkerSDKCoreDelegate> delegate;
//推送deviceToken
@property (nonatomic, strong) NSString *deviceToken;
///访客是否离开聊窗
@property (nonatomic, assign) BOOL isLeaveChat;

/**
 站点配置缓存池
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *,NtalkerSiteInfo *> *siteInfoMap;
///IM状态池
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *IMStatusPool;
#pragma mark - 初始化
+ (instancetype)sharedSDKCore;
/**
 初始化SDK

 @param siteid 企业ID
 @param type SDK 类型 客服 OR 访客
 @param completion 初始化结果回调
 */
- (void)ntalker_initSDKWithSiteid:(NSString *)siteid clientType:(Ntalker_ClientType)type completion:(completion)completion;
#pragma mark - 连接
/**
 连接IM
 */
- (void)ntalker_connectToIM:(NSString *)siteid templateId:(NSString *)templateId;

#pragma mark - 会话相关

/**
 向会话中发送消息
 
 @param message 消息
 */
- (void)ntalker_sendMessageOfServerGuest:(NtalkerCoreMessage *)message siteId:(NSString *)siteId;

/**
 关闭当前会话
 */
- (void)ntalker_leaveConversationOfServerGuest:(NSString *)siteid converId:(NSString *)converid;

/**
 退出会话，调用该接口后不会继续接收该会话消息（如果有推送功能下行消息就走推送）

 @param siteid 企业唯一标示
 @param converId 会话ID
 */
- (void)ntalker_exitConversationOfServerGuest:(NSString *)siteid converId:(NSString *)converId;
/**
 消息预知
 
@param message 消息
 */
- (void)ntalker_predictMessageOfServerGuest:(NtalkerCoreMessage *)message;

/**
 干系人进入会话（打开聊窗）
 干系人请求进入一个已经存在的会话，会话成员中已存在该干系人

 @param converId 会话id
 */
- (void)ntalker_enterConversationOfServerGuest:(NSString *)converId;
/**
 聊窗内三分钟断开会话后，重新进入会话

 @param siteId 企业唯一标示
 */
- (void)ntalker_againEnterConversationOfServerGuestSiteId:(NSString *)siteId;
/**
 主动退出排队
 */
- (void)ntalker_exitQueueOfServerGuest:(NSString *)siteid templateid:(NSString *)templateid;

/**
 访客评价会话
 
 @param evaluateModel 评价内容实体
 */
- (void)ntalker_remoteEvaluationConverstion:(NtalkerCoreMessage *)evaluateModel;

/**
 机器人转人工

 @param message 消息
 @param siteId 企业唯一标示
 */
- (void)ntalker_robotSwitchToPersonServer:(NtalkerCoreMessage *)message siteId:(NSString *)siteId;
/**
 比对会话是是否是当前会话

 @param templateId 接待组ID
 @param converId 会话ID
 */
- (BOOL)ntalker_checkConverstionWithTemplateId:(NSString *)templateId converId:(NSString *)converId;

/**
 清除会话

 @param templateId 接待组ID
 */
- (void)ntalker_clearConverstionWithTemplateId:(NSString *)templateId;

#pragma mark - 客服组信息
/**
 获取当前企业的客服组信息
 
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ntalker_getSDKTemplateSuccess:(templateSuccessBlock)success failure:(templateFailureBlock)failure;
#pragma mark - 轨迹
/**
 上传轨迹信息（参数是字典）
 
 @param pageName 当前页面名称
 @param web web
 @param order 订单
 @param product 商品
 @param event 事件
 @param customDict 自定义轨迹参数
 */
- (void)ntalker_pageView:(NSString *)pageName web:(NSDictionary *)web order:(NSDictionary *)order product:(NSDictionary *)product event:(NSDictionary *)event custom:(NSDictionary *)customDict;
/**
 上传轨迹信息(参数是数据模型)
 
 @param pageName 当前页面名称
 @param web web
 @param order 订单
 @param product 商品
 @param event 事件
 @param customDict 自定义轨迹参数
 */
- (void)ntalker_withPageView:(NSString *)pageName web:(NtalkerWebModel *)web order:(NtalkerOrderModel *)order product:(NtalkerProductModel *)product event:(NtalkerEventModel *)event custom:(NSDictionary *)customDict;
#pragma mark - 评价配置
/**
 获取评价配置
 
 @param success 成功
 @param failure 失败
 */
- (void)ntalker_getEvaluateSettingsSuccess:(successBlock)success failure:(failureBlock)failure;
#pragma mark - 商品信息
/**
 获取商品信息
 
 @param productId 商品ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ntalker_getGoodsDetailInfoWithProductId:(NSString *)productId success:(successBlock)success failure:(failureBlock)failure;
#pragma mark - 用户切换
/**
 *  登录
 *
 *  @param siteId 企业ID(必传参数)
 *  @param loginid     登录标识id （例如wechat账号、qq账号 、phone 、email 、login账号）
 *  @param username    登录用户名称
 *  @param userLevel   用户级别
 *  @param type        登录类型   (0未登录 1.wechat 2.qq 3.phone 4.email 5.login）
 *  @return 参数判断的返回值,0为参数正确
 */

- (NSInteger)ntalker_loginWithSiteId:(NSString *)siteId loginid:(NSString *)loginid andUsername:(NSString *)username andUserLevel:(NSString *)userLevel andType:(NSInteger)type;
/**
 登出

 @param siteId 企业ID(必传参数)
 */
- (void)ntalker_logout:(NSString *)siteId;
#pragma mark - 日志开关
/**
 日志开关

 @param  开关
 */
- (void)ntalker_setLogSwitch:(BOOL)enableLog;

#pragma mark - 存储相关

/**
 存储 NtalkerCoreMessage 到数据库

 @param coreMessage NtalkerCoreMessage 对象
 */
- (void)ntalker_saveCoreMessage:(NtalkerCoreMessage *)coreMessage;


- (void)ntalker_updateMessageContentDicString:(NSString *)msgContentDicString msgID:(NSString *)msgID;
/**
 清除所有会话语音文件

 @return 是否成功
 */
- (BOOL)ntalker_cleanAudioCache;

/**
 清除所有图片文件

 @return 是否成功
 */
- (BOOL)ntalker_cleanImageCache;
#pragma mark - 未读消息处理
/**
 处理未读消息
 
 @param userInfo 未读消息
 */
- (void)ntalker_handleRemoteNotification:(NSDictionary *)userInfo;

#pragma mark - Robot

- (void)getRobotInputGuideInfoWithQuestion:(NSString *)question robotId:(NSString *)robotId sessionId:(NSString *)sessionId senderId:(NSString *)senderId siteid:(NSString *)siteid inputGuideInfo:(getRobotInputGuideCompletion)inputGuideInfo;


#pragma mark - 历史会话列表相关
- (void)ntalker_saveCousult:(NtalkerTemplateRecord *)templateRecord;
- (NSArray <NSDictionary *>*)ntalker_getConsultHistoryListCount:(NSInteger)count offSet:(NSInteger)offset;
- (void)ntalker_deleteConsultByTemplateId:(NSString *)templateId;
- (void)ntalker_updateNtalkerTemplateRecordUnReadMsgCountAsZeroByTemplateId:(NSString *)templateId;


#pragma mark ------- 视频相关 --------
//干系人发起一个视频聊天
- (void)ntalkerRemoteStreamMedia:(NSDictionary *)dict siteId:(NSString *)siteId;
//干系人响应视频聊天结果
- (void)ntalkerRemoteCallBackStreamMedia:(NSDictionary *)dict siteId:(NSString *)siteId;
//干系人离开视频聊天，当会话内少于两人时；视频会话中止
- (void)ntalkerRemoteLeaveStreamMedia:(NSDictionary *)dict siteId:(NSString *)siteId;
//获取干系人待处理的视频聊天列表
- (void)ntalkerRemoteGetStreamMedia:(NSDictionary *)dict siteId:(NSString *)siteId;

#pragma mark -
/**
 设置APP被手动杀后的延迟时长
 
 @param time 时长
 */
- (void)ntalkerSetDelayKillAPP:(unsigned int)time;
@end
