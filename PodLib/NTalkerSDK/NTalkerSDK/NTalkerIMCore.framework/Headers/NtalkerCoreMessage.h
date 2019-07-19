//
//  NtalkerMessageModel.h
//  NtalkerIMLib
//
//  Created by wzh on 2017/12/27.
//  Copyright © 2017年 ios_develop. All rights reserved.
//core层消息模型

#import <Foundation/Foundation.h>

@interface NtalkerCoreMessage : NSObject
/*************************基础参数**********************/
///用户唯一标示
@property (nonatomic, copy) NSString *ntid;
///企业唯一标示
@property (nonatomic, copy) NSString *siteId;
///登录IM必选参数
@property (nonatomic, copy) NSString *token;
///IM连接地址(tcp)
@property (nonatomic, copy) NSString *imAddress;
///IM服务地址（http）
@property (nonatomic, copy) NSString *imHttpAddress;
///接待组id （请求会话资源时必选参数）
@property (nonatomic, copy) NSString *templateid;
///http握手需要的参数
@property (nonatomic, copy) NSString *sessionId;
///消息发送次数
@property (nonatomic, assign) NSUInteger sendCount;
///主动评价：0；邀请评价：1
@property (nonatomic, assign) NSUInteger evaluationType;
/***************************************************/

@property (nonatomic, strong) NSMutableArray *templateidArr;

/**
 消息发送者
 */
@property (nonatomic, copy) NSString *fromUser;

/**
 消息发送者名称
 */
@property (nonatomic, copy) NSString *fromUserName;

/**
 消息接收者，对于访客来说，可以传入templateId
 */
@property (nonatomic, copy) NSString *toUser;

/**
 会话ID
 */
@property (nonatomic, copy) NSString *converId;

/**
 消息ID
 */
@property (nonatomic, copy) NSString *msgId;

/**
 消息时间
 */
@property (nonatomic, copy) NSString *msgTime;

/**
 消息类型
 */
@property (nonatomic, copy) NSString *msgType;

/**
 消息来源类型：客服、访客
 */
@property (nonatomic, copy) NSString *userType;

/**
 消息状态：发送中:0 成功:1  失败:2
 */
@property (nonatomic, copy) NSString *status;

/**
 消息体内容
 */
@property (nonatomic, copy) NSString *msgContent;

/**
 消息体内容(字典格式)
 */
@property (nonatomic, strong) NSDictionary *messageContent;
///拓展信息
@property (nonatomic, strong) NSDictionary *extension;
/*
 @"messageid":message[@"messageid"],
 @"message": message[@"message"],
 @"createat":message[@"createat"],
 @"msgtype":message[@"msgtype"],
 @"url":message[@"url"],
 @"sourceurl":message[@"sourceurl"],
 @"status":@0,
 @"size":message[@"size"],
 @"extension":@"",
 @"duration":message[@"duration"],
 */
#pragma mark - 上行消息参数
///消息ID
@property (nonatomic, copy) NSString *send_messageid;
///会话消息体
@property (nonatomic, copy) NSString *send_message;
///消息创建时间
@property (nonatomic, copy) NSString *send_createat;
///消息类型
@property (nonatomic, copy) NSString *send_msgtype;
///消息子类型
@property (nonatomic, assign) NSInteger subMsgType;
///图片消息缩略图url
@property (nonatomic, copy) NSString *send_url;
///富媒体消息源文件url
@property (nonatomic, copy) NSString *send_sourceurl;
///消息发送状态
@property (nonatomic, copy) NSString *send_status;
///富媒体消息大小
@property (nonatomic, copy) NSString *send_size;
///拓展信息
@property (nonatomic, strong) NSDictionary *send_extension;
///语音消息时长
@property (nonatomic, copy) NSString *send_duration;
///评价内容
@property (nonatomic, strong) NSArray *send_evaluation;

#pragma mark - 未读消息相关参数
///接待组ID
@property (nonatomic, copy) NSString *unRead_templateId;
///消息发送者名称
@property (nonatomic, copy) NSString *unRead_FromName;
///未读消息条数
@property (nonatomic, copy) NSString *unRead_count;

#pragma mark - 视频通话相关参数

//任务编号，由任务发起方生成，使用频道ID   会话ID_随机数(6位)_发起成员类型（0 客服 1 访客）
@property (nonatomic, strong) NSString *taskid;
//任务类型 1：语言  2：视频
@property (nonatomic, assign) NSInteger tasktype;
//相关描述
@property (nonatomic, strong) NSString *des;
//操作类型 1：接受 2：拒绝 3：取消 4:超时无应答
@property (nonatomic, assign) NSInteger operation;
//音视频通话时长
@property (nonatomic, assign) long long time;
//获取干系人视频聊天列表 每页显示数量（默认为5）
@property (nonatomic, assign) NSInteger rp;
//获取干系人视频聊天列表 当前页数（默认为1）
@property (nonatomic, assign) NSInteger page;
//接收人
@property (nonatomic, strong) NSArray *accepter;
//操作人编号
@property (nonatomic, strong) NSString *operat;
//任务开始时间
@property (nonatomic, assign) long starttime;
//发起人
@property (nonatomic, strong) NSDictionary *avfromUser;
//用户编号
@property (nonatomic, strong) NSString *userid;


/**
 将上行消息转换为 满足数据库存储的 NtalkerCoreMessage 对象

 @return 满足数据库存储的 NtalkerCoreMessage 对象
 */
- (instancetype)convertCoreMessage;
@end
