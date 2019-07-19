//
//  NtalkerUserInfo.h
//  NengCloud
//
//  Created by Ntalker on 2017/1/16.
//  Copyright © 2017年 NTalker. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NtalkerCoreConstant.h"
#import "NtalkerFlashServerModel.h"
#import "NTalkerChatTableHeaderModel.h"
#import "NtalkerLeaveMsgSetInfoModel.h"
#import "NtalkerDeviceModel.h"
#import "NtalkerConfigureInfo.h"

typedef NS_ENUM(NSUInteger, E_TYPE_NET) {
    /*
     初始状态
     */
    E_TYPE_NET_INIT,
    /*
     未知
     */
    E_TYPE_NET_UNKNOW,
    /*
     无网络连接
     */
    E_TYPE_NET_NO,
    /*
     WiFi连接
     */
    E_TYPE_NET_WIFI,
    /*
     手机网络连接
     */
    E_TYPE_NET_WWAN,
};

@interface NtalkerUserInfo : NSObject

@property (nonatomic, assign) E_TYPE_NET netType;
///当前集成的用户类型
@property (nonatomic, assign) Ntalker_ClientType clientType;

@property (nonatomic, copy) NSString *siteId;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, copy) NSString *appKey;

@property (nonatomic, copy) NSString *converid;

@property (nonatomic, copy) NSString *userLevel;

@property (nonatomic, strong) NtalkerDeviceModel *device;

@property (nonatomic, strong) NtalkerFlashServerModel * serverModel;

@property (nonatomic, strong) NtalkerLeaveMsgSetInfoModel * leaveMsgSetInfoModel;

@property (nonatomic, strong) NTalkerChatTableHeaderModel *goodsHeaderModel;
@property (nonatomic, assign) BOOL initSuccess;

/*!接待组名称*/
@property (nonatomic, copy) NSString *templateName;
/**接待组id*/
@property (nonatomic, copy) NSString *templateid;
@property (nonatomic, strong) NSMutableDictionary *templateIdNameDic;
@property (nonatomic, strong) NSMutableDictionary *templateIdUnreadMsgCountDic;
///企业名称
@property (nonatomic, copy) NSString *siteName;
/**客服名称*/
@property (nonatomic, copy) NSString *nickName;
///多人会话场景下客服名称
@property (nonatomic, copy) NSString *kefuName;
/**客服id*/
@property (nonatomic, copy) NSString *kefuid;
/* 客服图像 */
@property (nonatomic, copy) NSString *keFuIcon;
///个性签名
@property (nonatomic, copy) NSString *signature;
///邀请视频通话的状态
@property (nonatomic, copy) NSString *videoCallStatus;
/**
 logo地址
 */
@property (nonatomic, copy) NSString *logo;

/**
 轨迹需要
 */
@property (nonatomic, copy) NSString *sid;

/**
 针对 一对访客和客服 的 数据库中 对应的唯一表名
 */
@property (nonatomic, copy) NSString *uniqueDataStoreID;

/**
 以下参数，是为了获取ntid
 */
@property (copy, nonatomic) NSString *username;//访客名称
@property (copy, nonatomic) NSString *Qq;
@property (copy, nonatomic) NSString *Wechat;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic, readonly) NSString *imei;
@property (copy, nonatomic) NSString *cookie;
@property (copy, nonatomic) NSString *enterpriseId;
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *ntid;//ntid新接口参数补充

///登录类型（0未登录 1.wechat 2.qq 3.phone 4.email 5.login）
@property (assign, nonatomic) NSInteger type;
///登录id
@property (copy, nonatomic, readonly) NSString *loginid;
///访客id
@property (copy, nonatomic, readonly) NSString *guestid;

/**
 记录app当前界面是否是聊窗（NtalkerChatViewController）
 */
@property (nonatomic, assign) BOOL isBackground;
//标记app打开情况下，但不是聊天界面时，未读的消息数量
@property (nonatomic, assign) NSInteger unreadMsgCount;

#pragma mark - 评价相关
///强制评价
@property (nonatomic, assign) BOOL isEnforcementEvaluated;
///主动评价
@property (nonatomic, assign) BOOL isInitiativeEvaluated;
///邀请评价
@property (nonatomic, assign) BOOL isInvitedEvaluated;
//是否进入主动评价过界面
@property (nonatomic, assign) BOOL isHavedInitialedEvaluated;
//是否进入留言界面
@property (nonatomic, assign) BOOL isShowingLeaveMsgVC;
///是否开启输入引导
@property (nonatomic, assign) BOOL isOpenInputGuide;
//是否开启推送
@property (nonatomic, assign) BOOL isOpenPush;
/**评价按钮可点击性*/
@property (nonatomic, assign) BOOL isCanTouch;
/**聊窗区域客服名称是否显示*/
@property (nonatomic, assign) BOOL isShowKefuName;

#pragma MARK - 设置聊天的输入框栏
@property (nonatomic, assign) BOOL isShowCommonProblems;
@property (nonatomic, assign) BOOL isAllowFace;
@property (nonatomic, assign) BOOL isAllowMoreFunc;
@property (nonatomic, assign) BOOL isAllowVoiceFunc;
@property (nonatomic, assign) BOOL isAllowASR;
@property (nonatomic, assign) BOOL isAllowVoice;
//语音识别是否直接显示在输入框
@property (nonatomic, assign) BOOL voice_recognition_position;

// + 内部的功能
///是否开启拍照和相册功能
@property (nonatomic, assign) BOOL enable_picture;
///是否开启小视频功能
@property (nonatomic, assign) BOOL enable_samllVideo;
///是否开启评价功能
@property (nonatomic, assign) BOOL enable_evaluate;
///转人工按钮是否显示
@property (nonatomic, assign) BOOL enable_staffservice;
/**
 存储访客id和待客云之间的对应关系 （因更换id需要）
 */
@property (nonatomic, strong) NSMutableDictionary *useridAndServerConnectDic;

#pragma Push - 相关参数  跟随轨迹上传
////设备类型
//@property (strong, nonatomic) NSString *devicetype;
//设备类型
@property (assign, nonatomic) NSInteger devicetype;
////推送类型
//@property (strong, nonatomic) NSString *appPushType;
//推送类型
@property (assign, nonatomic) NSInteger appPushType;
//推送token
@property (copy, nonatomic) NSString *devicetoken;
//bundleId
@property (copy, nonatomic) NSString *appid;
//是否是生产环境
@property (assign, nonatomic) BOOL isProduction;

#pragma MARK: - 排队相关参数
//客服状态
@property (nonatomic, assign) BOOL isKeFuOffline;
//是否可在排队时进入留言
@property (nonatomic, assign) BOOL isCanShowLeaveMsg;
//是否可主动放弃排队
@property (nonatomic, assign) BOOL isCanGiveUpQueue;
//区分是访客或者客服
@property (nonatomic, assign) BOOL isGuest;
/**
 ATS是否打开
 */
@property (nonatomic, assign) BOOL isOpenATS;
/**
 是否被加黑
 */
@property (nonatomic, assign) BOOL isForbidden;

///是否正在视频通话
@property (nonatomic, assign) BOOL isVideoCalling;

/**
 轨迹开关是否打开
 */
@property (nonatomic, assign) BOOL isOpenTrail;
#pragma MARK: -商品id
///商品id
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productUrl;

#pragma MARK: - 客服专用
@property (nonatomic, copy) NSString *userid;

#pragma mark - 服务器地址
///服务器地址
@property (nonatomic, copy) NSString *flashserverAddress;
///留言公告(待客云下行消息中的留言公告，优先显示此公告)
@property (nonatomic, copy) NSString *content;
///聊天窗口消息加载模式（默认:0）0：手动加载 1：自动加载
@property (nonatomic, assign) NSUInteger pattern;
///是否打开过聊窗
@property (nonatomic, assign) BOOL isOpenedChat;
///是否更新过IMEI号
@property (nonatomic, assign, readonly) BOOL isUpdateIMEI;
///是否隐藏聊窗键盘区域预览图片长图、GIF标识
@property (nonatomic, assign) BOOL isHiddenLongImageOrGifLogo;
///加密方式：0：不加密（缺省）1：RSA 2：DES 3：AES
@property (nonatomic, assign) NSUInteger encryption;
///语音识别APPID
@property (nonatomic, copy) NSString *ASRAppId;
///是否开启吸底超媒体功能(默认开启)
@property (nonatomic, assign) BOOL enableSnap;
///超媒体获取内容自定义参数需要用户传入（可选）
@property (nonatomic, copy) NSString *hyperMediaParameter;
///erpParam
@property (nonatomic, copy) NSString *erpParam;
/**历史消息是否滚动到最后一条：默认滚动*/
@property (nonatomic, assign) BOOL scrollToLastHistoryMessage;
/**是否启用本地通知：默认启用*/
@property (nonatomic, assign) BOOL localNotificationEnabled;
/**是否隐藏企业logo*/
@property (nonatomic, assign) BOOL isHiddenEnterpriseLogo;
/**是否统一客服信息*/
@property (nonatomic, assign) BOOL isUnifyKefu;
/**是否同步历史消息 : 默认为YES*/
@property (nonatomic, assign) BOOL isSynchHistoryMessage;
/**是否启用输入引导功能：默认为：NO 不启用*/
@property (nonatomic, assign) BOOL inputGuideEnabled;
/**平台ID*/
@property (nonatomic, copy) NSString *platformId;

#pragma mark - 时间同步参数
///服务器时间矫正参数
@property (nonatomic, assign, readonly) long long serverTime_correct;
///服务器当前时间戳 单位：毫秒（ms）
@property (nonatomic, assign) unsigned long long  serverTime;

+ (instancetype)sharedBasicInfo;

#pragma mark - readonly 属性更新方法

/**
 * 更新 loginId
 * @param loginId guestId
 */
- (void)updateLoginId:(NSString *)loginId;
/**
 * 更新 guestId
 * @param guestId  guestId
 */
- (void)updateGuestId:(NSString *)guestId;

/**
 更新IMEI号

 @param imei IMEI号
 */
- (void)updateImei:(NSString *)imei;
@end
