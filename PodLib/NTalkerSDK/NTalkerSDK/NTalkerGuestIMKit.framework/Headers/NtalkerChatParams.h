//
//  NtalkerChatParams.h
//  NTalkerGuestIMKit
//
//  Created by wzh on 2018/4/11.
//  Copyright © 2018年 NTalker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NtalkerChatDelegate.h"

@interface NtalkerChatParams : NSObject

/**站点*/
@property (nonatomic, copy) NSString *siteId;
///接待组ID（必选参数）
@property (nonatomic, copy) NSString *settingId;
///产品ID
@property (nonatomic, copy) NSString *productId;
///页面等级
@property (nonatomic, copy) NSString *pagelevel;
///erpParam
@property (nonatomic, copy) NSString *erpParam;
///聊天页面代理（选填，“如果需要监听聊天页面事件时必须设置代理”）
@property (nonatomic, assign) id<NtalkerChatDelegate> delegate;
#pragma mark - 打开聊窗时自定义消息相关参数
///消息来源类型：1:客服、2:访客
@property (nonatomic, assign) NSInteger msgSourcetType;
///消息类型:（目前只支持文本消息）11:文本消息 12:图片消息 13:语音消息 14:视频消息
@property (nonatomic, assign) NSInteger msgType;
///是否发送至服务器
@property (nonatomic, assign) BOOL msgIsSendServer;
///消息内容
@property (nonatomic, copy) NSString *msgContent;
@end
