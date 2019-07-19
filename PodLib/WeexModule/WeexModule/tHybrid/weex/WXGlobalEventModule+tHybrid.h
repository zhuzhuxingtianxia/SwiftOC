//
//  WXGlobalEventModule+tHybrid.h
//  AFNetworking
//
//  Created by Dao on 2018/12/3.
//

#import "WXGlobalEventModule.h"

NS_ASSUME_NONNULL_BEGIN

/**
 扩展WXGlobalEventModule类
 */
@interface WXGlobalEventModule (tHybrid)


/**
 Weex向Native发送消息通知【仅供Weex调用】

 @param name 通知名称
 @param anObject 消息对象
 */
- (void)postNotificationName:(NSString *)name object:(nullable id)anObject;

@end

NS_ASSUME_NONNULL_END
