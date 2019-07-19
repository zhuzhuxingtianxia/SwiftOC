//
//  NtalkerDBManager.h
//  NtalkerIMLib
//
//  Created by Gordon on 2017/12/27.
//  Copyright © 2017年 Ntalker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NtalkerCoreMessage;
@class NtalkerTemplateRecord;

@interface NtalkerDBManager : NSObject

+ (instancetype)sharedInstance;

/// 创表
- (void)creatMsgTable;
/**
 保存 NtalkerCoreMessage 对象（会判断数据库中是否存在此条记录，若已存在会‘更新’，不存在会‘添加’）
 
 @param message NtalkerCoreMessage 对象
 */
- (void)saveMessage:(NtalkerCoreMessage *)message;

/**
 通过 messageID 查单条 NtalkerCoreMessage
 
 @param messageID messageID
 @return NtalkerCoreMessage 对象
 */
- (NtalkerCoreMessage *)getMessageWithID:(NSString *)messageID;

/**
 通过 messageID 数组 查 NtalkerCoreMessage 数组
 
 @param messageIDs 待定
 @return NtalkerCoreMessage 对象数组
 */
- (NSArray < NtalkerCoreMessage*> *)getMessagesWithMessageIDs:(NSArray <NSString *>*)messageIDs;

/**
 通过传入'满足一个条件'查数组
 
 @param parameter 字段
 @param value 值
 @return NtalkerCoreMessage 对象数组
 */
- (NSArray <NtalkerCoreMessage *> *)getMessagesWithParameter:(NSString *)parameter value:(NSString *)value;
/**
 通过传入'满足一个条件'查分页数组（每页数据 20 条）
 
 @param parameter 字段
 @param value 值
 @param pageIndex 页数（从 0 开始）
 @return NtalkerCoreMessage 对象数组
 */
- (NSArray <NtalkerCoreMessage *> *)getMessagesWithParameter:(NSString *)parameter value:(NSString *)value pageIndex:(NSInteger)pageIndex;

/**
 通过传入’满足两个条件‘查数组
 
 @param parameter 第一个字段名
 @param value 第一个字段值
 @param secondParameter 第二个字段名
 @param secondValue 第二个字段值
 @return NtalkerCoreMessage 对象数组
 */
- (NSArray <NtalkerCoreMessage *> *)getMessagesWithParameter:(NSString *)parameter value:(NSString *)value secondParameter:(NSString *)secondParameter secondValue:(NSString *)secondValue;

/**
 通过传入’满足两个条件‘查分页数组（每页数据 20 条）
 
 @param parameter 第一个字段名
 @param value 第一个字段值
 @param secondParameter 第二个字段名
 @param secondValue 第二个字段值
 @param pageIndex 页数（从 0 开始）
 @return NtalkerCoreMessage 对象数组
 */
- (NSArray <NtalkerCoreMessage *> *)getMessagesWithParameter:(NSString *)parameter value:(NSString *)value secondParameter:(NSString *)secondParameter secondValue:(NSString *)secondValue pageIndex:(NSInteger)pageIndex;


/**
 根据 messageID 删除一条记录
 @param messageID messageID
 */
- (void)deleteMessageWithMessageID:(NSString *)messageID;

/**
 获取所有消息
 
 @return NtalkerCoreMessage 对象数组
 */
- (NSArray <NtalkerCoreMessage *> *)getAllMessages;

/**
 根据 messageID 更新 status
 
 @param status status
 @param messageID 消息ID
 */
- (void)updateStatus:(NSInteger)status byMessageID:(NSString *)messageID;

/**
 根据 messageID 更新 msgContent

 @param msgContentString msgContent 字符串
 @param messageID 消息ID
 */
- (void)updateMsgContent:(NSString *)msgContentString byMessageID:(NSString *)messageID;

/**
 删除表中所有数据
 */
- (void)deleteAllMessages;

/**
 根据时间倒序查 NtalkerCoreMessage 对象
 
 @param count 返回数量
 @param offset 偏移量
 @return NtalkerCoreMessage 对象数组
 */
- (NSArray <NtalkerCoreMessage *> *)getMessagesWithCount:(NSInteger )count offSet:(NSInteger)offset;

/**
 根据 templateID 查询 NtalkerCoreMessage 对象

 @param templateID 接待组 id
 @param count 数量
 @param offset 偏移量
 @return NtalkerCoreMessage 对象数组
 */
- (NSArray <NtalkerCoreMessage *> *)getMessagesWithTemplateID:(NSString *)templateID Count:(NSInteger )count offSet:(NSInteger)offset;

/**
 根据 ntid 查询 NtalkerCoreMessage 对象

 @param ntid ntid
 @param count 数量
 @param offset 偏移量
 @return NtalkerCoreMessage 对象数组
 */
- (NSArray <NtalkerCoreMessage *> *)getMessagesWithNtid:(NSString *)ntid count:(NSInteger )count offSet:(NSInteger)offset;

/**
 根据 ntid 和 templateID 查询 NtalkerCoreMessage 对象

 @param ntid ntid
 @param templateID templateID
 @param count 数量
 @param offset 偏移量
 @return NtalkerCoreMessage 对象数组
 */
- (NSArray <NtalkerCoreMessage *> *)getMessagesWithNtid:(NSString *)ntid templateID:(NSString *)templateID count:(NSInteger )count offSet:(NSInteger)offset;


#pragma mark =============================== 客服接待组历史记录表 操作 ======================================
/// 创表
- (void)creatTemplateRecordsTable;
/**
 * 保存 NtalkerTemplateRecord 对象（会判断数据库中是否存在此条记录，若已存在会‘更新’，不存在会‘添加’）
 * @param templateRecord  NtalkerTemplateRecord 对象
 */
- (void)saveTemplateRecord:(NtalkerTemplateRecord *)templateRecord;

/**
 * 查询 客服接待组历史记录
 * @param count 数量
 * @param offset 偏移量
 * @return NtalkerTemplateRecord 对象数组
 */
- (NSArray <NtalkerTemplateRecord *> *)getTemplateRecordsCount:(NSInteger)count offSet:(NSInteger)offset;

/**
 * 根据接待组 id 删除一条记录
 * @param templateId 接待组 id
 */
- (void)deleteNtalkerTemplateRecordByTemplateId:(NSString *)templateId;


/**
 将 接待组未读消息数 字段的值设为“0”

 @param templateId 接待组 id
 */
- (void)updateNtalkerTemplateRecordUnReadMsgCountAsZeroByTemplateId:(NSString *)templateId;

/**
 更新接待组未读消息数
 @param unreadMsgCount 未读消息条数
 @param templateId 接待组 id
 */
- (void)updateNtalkerTemplateRecordUnReadMsgCount:(NSInteger)unreadMsgCount templateId:(NSString *)templateId;

/**
 根据接待组 id 查询未读数

 @param templateId 接待组 id
 @return 未读数
 */
- (NSInteger)getUnReadMsgCountByTemplateId:(NSString *)templateId;

/**
 根据接待组 id 查询单条记录

 @param templateId 接待组 id
 @return NtalkerTemplateRecord 对象
 */
- (NtalkerTemplateRecord *)getTemplateRecordWithTemplateId:(NSString *)templateId;


#pragma mark =============== Ntalker_Flash_Server_Table 操作 ===============

/**
 根据 siteId 存储当前站点 flashServer 数据

 @param flashServerDic flashServer 数据字典
 @param ID siteId
 */
- (void)saveFlashServerDic:(NSDictionary *)flashServerDic withID:(NSString *)ID;

/**
 根据 siteId 查询当前站点 flashServer 数据

 @param ID siteId
 @return 当前站点 flashServer 字典
 */
- (NSDictionary *)getFlashServerDicByID:(NSString *)ID;

@end

