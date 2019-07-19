//
//  TCMPaymentBase.m
//  TCMSharePay
//
//  Created by ZZJ on 2019/7/16.
//

#import "TCMPaymentBase.h"
#import <AlipaySDK/AlipaySDK.h>

@interface TCMPaymentBase ()

@end
@implementation TCMPaymentBase

/***********  weex支付模块  *************/

WX_EXPORT_METHOD(@selector(pay:callback:));

- (void)pay:(NSDictionary *)option callback:(WXModuleCallback)callback{
    
    NSString *payType = [option valueForKey:@"payType"]; //'aliPay'||'wechatPay'
    TCMPaymentType theType = TCMPaymentTypeCMBC;
    if ([payType isEqualToString:@"alipay"]) {
        theType = TCMPaymentTypeAlipay;
    } else if ([payType isEqualToString:@"weChatpay"]) {
        theType = TCMPaymentTypeWechat;
    }
    
    [TCMPaymentBase paymentType:theType orderData:option completion:^(NSError * _Nonnull error, id  _Nonnull success) {
        if (callback) {
//            callback(success);
        }
    }];
}

+ (void)paymentType:(TCMPaymentType)payType orderData:(NSDictionary*)orderData completion:(void(^)(NSError *error, id success))completion {
    if (TCMPaymentTypeAlipay == payType){
        
        [self alipayWithOrderData:orderData completion:completion];
        
    }else if (TCMPaymentTypeWechat == payType){
        
        [self wechatPayWithOrderData:orderData completion:completion];
        
    }else if (TCMPaymentTypeCMBC == payType){
        
        [self cmbcPayWithOrderData:orderData completion:completion];
        
    }else{
        NSLog(@"Unknow Payment Type");
        if (completion) {
            NSError *error = [NSError errorWithDomain:@"不存在的支付类型" code:-1 userInfo:nil];
            completion(error,nil);
        }
    }
    
}

#pragma mark -- Alipay

+ (void)alipayWithOrderData:(NSDictionary*)orderData completion:(void(^)(NSError *error, id success))completion {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSArray *urlTypes = [infoDict objectForKey:@"CFBundleURLTypes"];
    NSArray *urlSchemes = [urlTypes[0] objectForKey:@"CFBundleURLSchemes"];
    NSString *appScheme = urlSchemes[0];
    
    //        [self Cancel];
    [[AlipaySDK defaultService] payOrder:[orderData valueForKey:@"payUrl"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSString *resultStatuStr = resultDic[@"resultStatus"];
        //                 返回码    含义
        //                 9000    订单支付成功
        //                 8000    正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
        //                 4000    订单支付失败
        //                 5000    重复请求
        //                 6001    用户中途取消
        //                 6002    网络连接出错
        //                 6004    支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
        //                 其它    其它支付错误
        NSString *code = @"1";
        NSString *msg = @"支付异常";
        switch (resultStatuStr.integerValue) {
            case 9000:
                code = @"0";
                msg = @"支付成功";
                break;
            case 4000:
            case 6002:
                msg = @"支付失败，请重试";
                break;
            case 6001:
                msg = @"已取消支付";
                break;
            default:
                msg = @"支付订单正在处理中";
                break;
        }
        [self payNotification:msg code:code];
    }];
}

+ (void)payNotification:(NSString *)msg code:(NSString *)code{
    NSDictionary *noti = @{
                           @"code": code,
                           @"msg": msg,
                           };
    
    NSDictionary * userInfo = @{
                                //                                @"weexInstance":@"",
                                @"param":noti
                                };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PayBack" object:NULL userInfo:userInfo];
    
}


#pragma mark -- Wechat

+ (void)wechatPayWithOrderData:(NSDictionary*)orderData completion:(void(^)(NSError *error, id success))completion {
    SocialShareMessage *msg = [SocialShareMessage payMessage:[orderData valueForKey:@"payParams"] platform:(SocialSharePlatform_WeChat_Session)];
    [SocialShare sendMessage:msg respondBlock:^(SocialShareResp *resp) {
        NSString *code = @"1";
        NSString *msg = @"支付i异常";
        if (resp) {
            switch (resp.result) {
                case SocialShareResultCodeSuccess:
                    code = @"0";
                    msg = @"支付成功";
                    break;
                case SocialShareResultCodeUserCancel:
                    msg = @"已取消支付";
                    break;
                default:
                    if (resp.msg.length) {
                        msg = resp.msg;
                    } else {
                        msg = @"支付失败";
                    }
                    break;
            }
        } else {
            msg = @"订单异常，拉起支付失败！";
        }
        [self payNotification:msg code:code];
    }];
}

#pragma mark -- CMBC
//暂不使用
+ (void)cmbcPayWithOrderData:(NSDictionary*)orderData completion:(void(^)(NSError *error, id success))completion {
//    NSString *PayURL = [[orderData valueForKey:@"payParams"] valueForKey:@"payUrl"];
    
    
}

@end
