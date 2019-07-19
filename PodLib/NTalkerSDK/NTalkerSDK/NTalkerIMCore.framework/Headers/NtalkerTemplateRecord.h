//
// Created by gordon on 2018/5/29.
// Copyright (c) 2018 NTalker. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NtalkerTemplateRecord : NSObject
/** 接待组id */
@property (copy, nonatomic) NSString *templateId;
/** 接待组 名称 */
@property (copy, nonatomic) NSString *templateName;
/** 最后一条消息 */
@property (copy, nonatomic) NSString *lastMsgContent;
/** 最后一条消息 时间 */
@property (copy, nonatomic) NSString *lastMsgTime;
/** 接待组头像 */
@property (copy, nonatomic) NSString *templateIcon;
/** 消息未读数 */
@property (copy, nonatomic) NSString *unReadMsgCount;

+(instancetype)recordWithTemplateId:(NSString *)templateId templateName:(NSString *)templateName lastMsgContent:(NSString *)lastMsgContent lastMsgTime:(NSString *)lastMsgTime templateIcon:(NSString *)templateIcon unReadMsgCount:(NSString *)unReadMsgCount;
-(instancetype)initWithTemplateId:(NSString *)templateId templateName:(NSString *)templateName lastMsgContent:(NSString *)lastMsgContent lastMsgTime:(NSString *)lastMsgTime templateIcon:(NSString *)templateIcon unReadMsgCount:(NSString *)unReadMsgCount;

@end