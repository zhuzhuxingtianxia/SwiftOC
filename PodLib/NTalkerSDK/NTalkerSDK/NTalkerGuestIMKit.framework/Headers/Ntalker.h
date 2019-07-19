//
//  Ntalker.h
//  NtalkerIMKit
//
//  Created by wzh on 2017/12/20.
//  Copyright © 2017年 Ntalker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///未读消息通知
/*未读消息数据格式
 @{@"settingId": settingId , @"unreadCount" :@(unreadCount), @"userName": userName,@"msgContent": @"你好啊", @"msgTime": 时间戳}
 */
extern NSString *const NtalkerUnReadMessageNotification;

@class NtalkerChatParams,NtalkerTrailModel,NtalkerConsultRecord;

@interface Ntalker : NSObject

#pragma mark -  内部使用
/**
 获取当前企业的客服组信息
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)ntalker_getSDKTemplateSuccess:(void(^)(NSArray<NSDictionary *> *templateArray))success failure:(void(^)(NSError *error))failure;


#pragma mark -  API
/**
 初始化SDK（公版用户）
 
 @param siteid 企业ID
 @param completion 初始化结果回调,返回值参考：NtalkerErrorCode.h
 */

+ (void)ntalker_initSDKWithSiteid:(NSString *)siteid completion:(void (^)(BOOL finished , NSUInteger code))completion;

/**
 初始化SDK(独立部署客户专用)

 @param siteid 企业ID
 @param serverAddress 独立部署的服务器地址
 @param completion 初始化结果回调,返回值参考：NtalkerErrorCode.h
 */
+ (void)ntalker_initSDKWithSiteid:(NSString *)siteid flashserverAddress:(NSString *)serverAddress completion:(void (^)(BOOL finished , NSUInteger code))completion;

/**
 初始化一个聊天窗口实例

 @param chatParams 创建聊天实例需要的参数
 @return 聊天窗口实例
 */
+ (UIViewController *)ntalker_chatViewControllerWithChatParam:(NtalkerChatParams *)chatParams;

/**
 用户登录
 
 @param userId 必填,登录用户的id, 只能输入数字、英文字母和"@"、"."、"_"、"-"三种字符，长度小于等于60位。
 @param userName 非必填,登录用户名, 如未填写,系统随机会随机生成一个用户名
 @return 返回值参考：NtalkerErrorCode.h
 */
+ (NSInteger)ntalker_loginWithUserId:(NSString *)userId andUserName:(NSString *)userName;

/**
 用户登录
 
 @param userId 必填,登录用户的id, 只能输入数字、英文字母和"@"、"."、"_"、"-"三种字符，长度小于等于60位。
 @param userName 非必填,登录用户名, 如未填写,系统随机会随机生成一个用户名
 @param userLevel 用户级别
 @return 返回值参考：NtalkerErrorCode.h
 */
+ (NSInteger)ntalker_loginWithUserId:(NSString *)userId andUsername:(NSString *)userName andUserLevel:(NSString *)userLevel;
/**
 用户登出
 */
+ (void)ntalker_logout;

/**
 判断用户是否已经登录

 @param userId 用户ID
 @return 是否登录
 */
+ (BOOL)ntalker_isLoginWithUserId:(NSString *)userId;
/**
 上报轨迹
 
 @param pageName 当前页面名称
 @param model 轨迹参数
 */
+ (void)ntalker_uploadTrailWithPageName:(NSString *)pageName model:(NtalkerTrailModel *)model;

/**
 日志开关
 
 @param enableLog 是否开启
 */
+ (void)ntalker_setLogSwitch:(BOOL)enableLog;

/**
 获取SDK版本号

 @return 版本号
 */
+ (NSString *)ntalker_versionNumber;

/**
 设置主题色（默认主题色是:#0684ea）

 @param themeColor 十六机制颜色
 */
+ (void)ntalker_themeColor:(NSString *)themeColor;


/**
 查询当前用户的历史咨询记录

 @param count 记录条数
 @param offset 偏移量
 @return 查询结果
 */
+ (NSArray <NtalkerConsultRecord *>*)ntalker_getConsultHistoryListCount:(NSInteger)count offSet:(NSInteger)offset;

/**
 删除一条咨询记录

 @param settingId 接待组ID
 */
+ (void)ntalker_deleteConsultBySettingId:(NSString *)settingId;

/**
 将一条咨询记录的消息未读数设置为“0”

 @param templateId 接待组ID
 */
+ (void)ntalker_updateNtalkerTemplateRecordUnReadMsgCountAsZeroByTemplateId:(NSString *)templateId;


/**
 聊天窗口消息加载模式（默认0：手动加载）

 @param pattern 0：手动加载 1：自动加载
 */
+ (void)ntalker_historyMessageLoadingPattern:(NSUInteger)pattern;

/**
 设置IMEI号（如果不设置，默认是SDK生成的设备唯一标示）

 @param imei IMEI号
 */
+ (void)ntalker_setupImei:(NSString *)imei;

/**
 加密方式
 0：不加密（缺省）
 1：RSA
 2：DES
 3：AES
 @param encryption 加密方式
 */
+ (void)ntalker_setEncryption:(NSUInteger)encryption;

/**
 是否开启超媒体吸底功能（默认开启）
 
 @param enableSnap enableSnap
 */
+ (void)ntalker_setEnableSnap:(BOOL)enableSnap;

/**
 设置语音识别APPID
 如果需使用科大讯飞语音识别定制的功能，需要替换科大讯飞的SDK并且必须传入APPID
 @param AppId 科大讯飞SDK APPID
 */
+ (void)ntalker_setASRAppId:(NSString *)AppId;

/**
 是否隐藏聊窗键盘区域预览图片长图、GIF标识

 @param isHidden 是否隐藏(默认显示)
 */
+ (void)ntalker_isHiddenLongImageOrGifLogo:(BOOL)isHidden;


/**
 消息发送接口(目前只支持文本消息发送)

 @param chatController 聊窗实例(必须是小能SDK创建的聊窗实例)
 @param type 消息类型:  11:文本消息 12:图片消息 13:语音消息 14:视频消息
 @param message 消息内容
 */
+ (void)ntalker_sendMessageWithChatController:(UIViewController *)chatController messageType:(NSInteger)type mesaage:(NSString *)message;

/**
 发送自定义类型消息

 @param chatController  聊窗实例(必须是小能SDK创建的聊窗实例)
 @param type 消息子类型：1：商品详情，2：订单详情，3：最近浏览商品
 @param message 消息内容
 */
+ (void)ntalker_sendCustomMessageWithChatController:(UIViewController *)chatController subMsgType:(NSInteger)type mesaage:(NSString *)message;

/**
 上传轨迹字典

 @param trailDict 轨迹字典
 */
+ (void)ntalker_setTrailDict:(NSDictionary *)trailDict;
/**
 设置超媒体自定义参数
 
 @param parameter 自定义参数 例如：@{@"token": @"18231yy31hh12",@"xxx": @"yyyy"}
 */
+ (void)ntalker_setHyperMediaData:(NSDictionary *)parameter;

/**
 设置APP被手动杀后的延迟时长

 @param time 时长
 */
+ (void)ntalker_setDelayKillAPP:(unsigned int)time;

/**
 历史消息是否滚动到最后一条

 @param isScroll 是否滚动(默认YES)
 */
+ (void)ntalker_scrollToLastHistoryMessage:(BOOL)isScroll;

/**
 是否启用本地通知

 @param enabled 默认启用
 */
+ (void)ntalker_localNotificationEnabled:(BOOL)enabled;

/**
 是否隐藏企业logo

 @param isHidden YES or NO （默认为：NO）
 */
+ (void)ntalker_isHiddenEnterpriseLogo:(BOOL)isHidden;

/**
 同步历史消息: 默认为YES 

 @param synch 是否同步历史消息
 */
+ (void)ntalker_synchHistoryMessage:(BOOL)synch;

/**
 是否启用输入引导功能<默认为：NO 不启用>

 @param enabled 默认为：NO 不启用
 */
+ (void)ntalker_inputGuideEnabled:(BOOL)enabled;

/**
 默认键盘类型:0：重构版； 1：经典版（默认为0）

 @param type 0：重构版； 1：经典版（默认为0）
 */
+ (void)ntalker_setKeyBoardType:(NSUInteger)type;

/**
 设置平台ID

 @param platformId 平台ID
 */
+ (void)ntalker_setPlatformId:(NSString *)platformId;
@end
