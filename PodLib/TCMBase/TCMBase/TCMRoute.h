//
//  TCMRoute.h
//  TCMBase
//
//  Created by ZZJ on 2019/7/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * Router 的 跳转方式
 */
typedef NS_ENUM(NSUInteger, TCMRouteStyle) {
    TCMRoutePush,
    TCMRoutePresent,
    TCMRoutePop,
    TCMRouteTab,
};
/**
 * 支持Router的类型要实现此协议
 */
@protocol TCMRouteProtocol <NSObject>
@optional
/**
 * 返回实例的方法， 如果不实现，则使用默认的KVC方式创建实例
 */
+ (nonnull UIViewController<TCMRouteProtocol> *)routeWithParams:(nullable NSDictionary<NSString *, id> *)params;
/*
 用于TCMRoutePop时，传递参数。
 */
- (void)routePopWithParams:(nullable NSDictionary<NSString *, id> *)params;

@end
@interface TCMRoute : NSObject

+ (UIViewController*)routeWithTarget:(nonnull NSString *)target  params:(nullable NSDictionary<NSString *, id>  *)params;

+ (UIViewController*)routeWithTarget:(nonnull NSString *)target routeStyle:(TCMRouteStyle)routeStyle params:(nullable NSDictionary<NSString *, id>  *)params;

@end


@interface UIViewController (RouteProtocol)<TCMRouteProtocol>

@end

NS_ASSUME_NONNULL_END
