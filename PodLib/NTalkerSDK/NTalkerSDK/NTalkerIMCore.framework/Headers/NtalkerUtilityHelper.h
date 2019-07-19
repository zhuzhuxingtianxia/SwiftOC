//
//  NtalkerUtilityHelper.h
//  NtalkerChatCore
//
//  Created by Ntalker on 15/8/20.
//  Copyright (c) 2015年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NtalkerUtilityHelper : NSObject

//获取cid（会随着应用卸载改变）
+ (NSString *)cidFromLocalStore;

///1970据当前的时间(精确到毫秒)
+ (NSString *)getNowTimeInterval;

//get请求时拼接完整的URL
+ (NSString *)URLStringByURLBody:(NSString *)businessName andParam:(NSMutableDictionary *)paramDic;

//模型转换成容器
+ (id)dictOrArrayWithModel:(id)dataModel;


//判断对应的siteID是否需要getflashserver请求
+ (BOOL)needGetflashserverBySited:(NSString *)sited;

//获取设备类型
+ (NSString *)deviceModel;

//长id变短id
+ (NSString *)shortUidFromUid:(NSString *)uid;

//将十六进制转为颜色
+ (UIColor *)colorWithHexString: (NSString *) stringToConvert;

//
+ (NSString *)siteidFromUid:(NSString *)uid;

//
+ (NSString *)siteidfromSettingid:(NSString *)settingid;

+ (NSString *)md5:(NSString *)originStr;

+ (NSString *)stringFromGBData:(NSData *)data;

+ (NSString *)randomString;

+ (long)randomNumber;

//+ (NSString *)gzipInflate:(NSData *)compressStr;

+ (BOOL)isKefuUserid:(NSString *)uid;

+ (BOOL)isVisitUserid:(NSString *)uid;

//+ (NSString *)getFlashserverAddress;

+ (CGFloat)backConnectTime;

+ (NSString *)getFormatTimeString:(NSString *)timeStr;

+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect ;

+ (NSString *)getConfigFile:(NSString *)fileName;

+ (NSString *)stringByNtalkerEncodeFromString:(NSString *)oldString;

+ (NSString *)stringByNtalkerDecodeFromString:(NSString *)oldString;

/**
 获取服务器地址

 @return 服务器地址
 */
+ (NSString *)getFlashserverAddress;

+ (BOOL)checkUid:(NSString *)uid;

+ (BOOL)checkUName:(NSString *)uName;

+ (BOOL)checkULevel:(NSString *)uLevel;
///获取IP地址
+ (NSString *)getIPAddress;

/**
 获取设备唯一标示(生成之后不会改变，除非强制刷机)

 @return UUID
 */
+ (NSString *)getUUID;
/**
 根据会话ID获取templateId

 @param converid 会话ID
 @return templateId
 */
+ (NSString *)templateIdWithConverId:(NSString *)converid;

/**
 根据templateId获取企业ID

 @param templateId 接待组ID
 @return 企业ID
 */
+ (NSString *)siteIdWithTemplateId:(NSString *)templateId;

/**
 生成指定长度的随机字符串

 @param length 长度
 @return 字符串
 */
+ (NSString *)randomStringWithLength:(NSInteger)length;

/**
 json转字典

 @param json json字符串
 @return 字典
 */
+ (NSDictionary *)jsonToDic:(NSString *)json;


/**
 字典转json

 @param dic 字典
 @return json字符串
 */
+ (NSString *)dictToJson:(NSDictionary *)dic;
/**
 从json字符串解析出消息文本

 @param messageContent json字符串消息
 @return 消息文本
 */
+ (NSString *)messageTextWithJsonMessageContent:(NSString *)messageContent;

/**
 根据消息类型生成：[语音][视频][图片]...

 @param type 消息类型
 @return 消息类型说明
 */
+ (NSString *)messageTypeTextWithMessageType:(NSString *)type;


/**
 获取待客云请求会话资源的请求id

 @return requestId
 */
+ (NSString *)getRequestId;

/**
 获取SDK版本号

 @return 版本号
 */
+ (NSString *)versionNumber;
///版本更新时间
+ (NSString *)versionUpDate;

///获取网络时间
+ (NSDate *)getInternetDate;

/**
 替换emoji表情为Unicode

 @param emojiString 包含emoji表情的字符串
 @return 替换完成的字符串
 */
+ (NSString *)replaceEmoji:(NSString *)emojiString;

/**
 替换Unicode为emoji表情

 @param unicodeStr 包含Unicode格式的emojin表情的字符串
 @return 替换完成的字符串
 */
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

@end
