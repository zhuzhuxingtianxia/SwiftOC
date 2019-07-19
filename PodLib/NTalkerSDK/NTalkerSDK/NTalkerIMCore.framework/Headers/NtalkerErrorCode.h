//
//  NtalkerErrorCode.h
//  NTalkerIMCore
//
//  Created by wzh on 2019/1/15.
//  Copyright © 2019 NTalker. All rights reserved.
//

#ifndef NtalkerErrorCode_h
#define NtalkerErrorCode_h

#pragma mark ================= 初始化相关 =================
///siteid为空
static const NSInteger NTALKER_SITEID_NULL = 10001;

///服务器本地地址获取失败
static const NSInteger NTALKER_LOCAL_SERVER_ADDERESS_FAILURE = 10002;

///网络获取服务器地址失败
static const NSInteger NTALKER_NETWORK_SERVER_ADDERSS_FAILURE = 10003;

///没有网络
static const NSInteger NTALKER_NETWORK_FAILURE = 10004;

///初始化成功
static const NSInteger NTALKER_INIT_SUCCESS = 10005;

#pragma mark ================= 登录 =================
///没有初始化就调用登录
static const NSInteger NTALKER_NOT_INIT_LOGIN = 20001;

///登录的uid为空
static const NSInteger NTALKER_UID_NULL = 20002;

///uid非法
static const NSInteger NTALKER_UID_NOT_LEGAL = 20003;

///退出登录失败
static const NSInteger NTALKER_LOGOUT_FAILURE = 20004;

///登录操作成功
static const NSInteger NTALKER_LOGIN_SUCCESS = 20005;

///重复登录
static const NSInteger NTALKER_LOGIN_REPEAT = 20006;


#pragma mark ================= 账号中心 =================
///ntid获取失败
static const NSInteger NTALKER_NTID_FAILURE = 30001;

///token获取失败
static const NSInteger NTALKER_TOKEN_FAILURE = 30002;

///token的服务器地址获取失败
static const NSInteger NTALKER_TOKEN_SERVER_FAILURE = 30003;

///ntid的服务器地址获取失败
static const NSInteger NTALKER_NTID_SERVER_FAILURE = 30004;

///ntid获取成功
static const NSInteger NTALKER_NTID_SUCCESS = 30005;

///token获取成功
static const NSInteger NTALKER_TOKEN_SUCCESS = 30006;

#pragma mark ================= 轨迹 =================
///没有初始化就调用轨迹
static const NSInteger NTALKER_NOT_INIT_TRAIL = 60001;

///轨迹地址获取失败
static const NSInteger NTALKER_TRAIL_SERVER_FAILURE = 60002;

///ntid或token或sietid为空
static const NSInteger NTALKER_TRAIL_KEY_NULL = 60003;

///轨迹上传失败
static const NSInteger NTALKER_TRAIL_UPLOAD_FAILURE = 60004;

///轨迹上传成功
static const NSInteger NTALKER_TRAIL_UPLOAD_SUCCESS = 60005;
#endif /* NtalkerErrorCode_h */
