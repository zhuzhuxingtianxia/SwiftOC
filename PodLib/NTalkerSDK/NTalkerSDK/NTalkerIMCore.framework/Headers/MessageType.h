//
//  MessageType.h
//  TestMyMqtt
//
//  Created by Ntalker on 2016/11/15.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

// 握手消息
static const int MESSAGE_HANDSHAKE = 0;
// keepalive消息
static const int MESSAGE_KEEPALIVE = 1;
// 主动断开消息
static const int MESSAGE_DISCONNECT = 2;
// 空消息
static const int MESSAGE_INVALID = 3;
// 拉取消息
static const int MESSAGE_QUEST = 4;
// 信令消息(包含核对信息是否成功的targetid)
static const int MESSAGE_ORDER = 5;
// 文档消息
static const int MESSAGE_DOCUMENT = 6;
// 事件消息
static const int MESSAGE_EVENT = 7;
//结果消息
static const int MESSAGE_RESULT = 8;

// 文本消息
static const int MESSAGE_DOCUMENT_TXT = 11;
// 图片消息
static const int MESSAGE_DOCUMENT_IMAGE = 12;
// 短语音
static const int MESSAGE_DOCUMENT_AUDIO = 13;
// 短视频
static const int MESSAGE_DOCUMENT_VIDEO = 14;
// 消息名片
//static const int MESSAGE_DOCUMENT_CARD = 15;
// 超媒体
static const int MESSAGE_DOCUMENT_HYPERMEDIA = 15;
// 优惠券或红包消息
//static const int MESSAGE_DOCUMENT_COUPON = 16;
//logo标志
static const int MESSAGE_DOCUMENT_LOGO = 16;
//历史消息提示
static const int MESSAGE_HISTORY_TIP = 17;

/**文件传输消息*/
//static const int MESSAGE_DOCUMENT_FILE = 17;
/**富文本*/
static const int MESSAGE_DOCUMENT_RICH_MEDIA = 18;
/**命令消息通道*/
static const int MESSAGE_DOCUMENT_COMMAND = 19;
/**分割消息*/
static const int MESSAGE_DOCUMENT_SEPARATION = 20;

// 用户下线
static const int STATUS_USER_OFFLINE = 21;
// 用户上线
static const int STATUS_USER_ONLINE = 22;
// session忙碌
static const int STATUS_SESSION_BUSY = 23;
// session离开
static const int STATUS_SESSION_AWAY = 24;
// session隐身
static const int STATUS_SESSION_HIDE = 25;

// 会话创建
static const int STATUS_CONVERSATION_CREATE = 31;
// 会话销毁
static const int STATUS_CONVERSATION_DESTROY = 32;
// 会话暂停
static const int STATUS_CONVERSATION_FORZEN = 33;
// 成员加入会话
static const int STATUS_CONVERSATION_MEMBER_JOIN = 34;
// 成员离开会话
static const int STATUS_CONVERSATION_MEMBER_LEAVE = 35;
// 成员禁言
static const int STATUS_CONVERSATION_MEMBER_FORZEN = 36;
// 成员解禁
static const int STATUS_CONVERSATION_MEMBER_FREE = 37;

// 消息已到达服务器
static const int STATUS_MESSAGE_SEND_SENT = 41;
// 消息发送失败
static const int STATUS_MESSAGE_SEND_FAILED = 42;
// 消息已被接收
static const int STATUS_MESSAGE_SEND_RECEIVED = 43;
// 消息已被读取
static const int STATUS_MESSAGE_SEND_READ = 44;
// 文件已被下载
static const int STATUS_MESSAGE_SEND_DOWNLOAD = 45;
// 消息销毁
static const int STATUS_MESSAGE_SEND_CANCEL = 46;
// 消息已被其他端接收
static const int STATUS_MESSAGE_RECEIVE_MULTIPLE = 47;
// 消息已被其他端读取
static const int STATUS_MESSAGE_RECEIVE_READ = 48;
// 消息已被其他端监听
static const int STATUS_MESSAGE_RECEIVE_LISTENED = 49;

// 握手消息回应
static const int RESULT_MESSAGE_HANDLESHAKE = 61;
// 断开响应
static const int RESULT_MESSAGE_DISCONNECT = 62;
// keepalive响应
static const int RESULT_MESSAGE_KEEPLIVE = 63;

static const int RESULT_MESSAGE_LOGINREMIND = 64;
// 断开上一次的ClientSession(强制下线)——按终端信息（终端设备唯一性）
static const int RESULT_MESSAGE_CLIENT_OFFLINE = 65;
// 互踢模式下提示您的账号已在其他（类型）终端登录——按终端类型（终端类型唯一性）
static const int RESULT_MESSAGE_OTHER_LOGIN = 66;
//同步消息
static const int RESULT_MESSAGE_SYNCH = 67;
//历史消息
static const int REQUEST_MESSAGE_HISTORY = 71;


