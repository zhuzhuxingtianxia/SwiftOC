//
//  TCMPaymentBase.h
//  TCMSharePay
//
//  Created by ZZJ on 2019/7/16.
//

#import <Foundation/Foundation.h>
#import <WechatOpenSDK/WXApi.h>
#import <WeexSDK/WeexSDK.h>
#import "SocialShare.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  支付方式
 */
typedef NS_ENUM(NSInteger, TCMPaymentType) {
    /**
     *  支付宝
     */
    TCMPaymentTypeAlipay = 1,
    /**
     *  微信
     */
    TCMPaymentTypeWechat,
    /**
     *  招商银行一网通
     */
    TCMPaymentTypeCMBC
};
@interface TCMPaymentBase : NSObject<WXModuleProtocol>

+ (void)paymentType:(TCMPaymentType)payType orderData:(NSDictionary*)orderData completion:(void(^)(NSError *error, id success))completion;

@end

NS_ASSUME_NONNULL_END
