//
//  NtalkerConfigureInfo.h
//  NTalkerClientSDK
//
//  Created by Ntalker on 16/5/15.
//  Copyright © 2016年 NTalker. All rights reserved.
//记录配置信息

#import <Foundation/Foundation.h>
#import "NtalkerEvaluateSetInfoModel.h"

@interface NtalkerConfigureInfo : NSObject

@property (strong, nonatomic) NSString *flashServerAddress;
@property (assign, nonatomic) BOOL needLinkCard;
@property (assign, nonatomic) NSInteger unreadMsgMaxTime;
@property (nonatomic, assign) BOOL enableLog;
@property (strong, nonatomic) NtalkerEvaluateSetInfoModel *evaluateSetInfoModel;

//统计用的时间戳
@property (strong, nonatomic) NSString *htmlsId;
///是否自动连接  1：自动连接  0：非直接连接
@property (assign, nonatomic) NSInteger autoconnect;
///暂时没有用
@property (nonatomic, assign) NSInteger disconnectionTime;
///IM超时断开时间(单位：毫秒)
@property (nonatomic, assign) NSInteger sdkdisconnecttime;
//记录mqtt握手是否成功
@property (nonatomic, assign) BOOL isMQTTConnected;

+ (NtalkerConfigureInfo *)sharedInfo;

@end
