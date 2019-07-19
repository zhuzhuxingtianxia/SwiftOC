//
//  NtalkerFlashServer.h
//  NengCloud
//
//  Created by mac on 2017/3/1.
//  Copyright © 2017年 NTalker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NtalkerFlashServerModel : NSObject

//API地址
@property (nonatomic, strong) NSString *NApiGatewayServer;
/**
 待客云服务地址
 */
@property (nonatomic, strong) NSString *NDolphinServer;
/**
 文件服务地址
 */
@property (nonatomic, strong) NSString *NFileServer;
/**
 机器人服务地址
 */
@property (nonatomic, strong) NSString *NEagleServer;
/**
 IM服务地址（http）
 */
@property (nonatomic, strong) NSString *NPigeonServer_httpServer;
/**
 IM服务地址（socket）
 */
@property (nonatomic, strong) NSString *NPigeonServer_socketServer;
/**
 IM连接地址(tcp)
 */
@property (strong, nonatomic) NSString *NPigeonServer_socketServer_tcp;
/**
 轨迹服务地址
 */
@property (nonatomic, strong) NSString *NSkyEyeServer;
/**
 账号中心服务地址
 */
@property (nonatomic, strong) NSString *NTAccountCenter_Visitant;
/**
 配置服务地址
 */
@property (nonatomic, strong) NSString *NTSettingServer;
/**
 未知，暂未使用
 */
@property (nonatomic, strong) NSString *VisitantServer;
/**
 templateid需要的地址
 */
@property (nonatomic, strong) NSString *waiterServer;

/**
 超媒体服务器地址
 */
@property (nonatomic,strong) NSString *NMagicServer;

/**
 IM状态服务器地址（http）
 */
@property (nonatomic,strong) NSString *NImstatusServer_httpServer;

/**
 消息拉取服务器地址（http）
 */
@property (nonatomic,strong) NSString *NCrocodileServer;

/**
 服务器校准时间
 */
@property (nonatomic, assign) long long serverTime_correct;


+ (instancetype)flashServerModel;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

- (instancetype)getFlashServerModelFromDic:(NSDictionary *)dic;

@end
