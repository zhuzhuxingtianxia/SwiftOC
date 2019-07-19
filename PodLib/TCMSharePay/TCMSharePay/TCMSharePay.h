//
//  TCMSharePay.h
//
//  Created TCMSharePay
//  Copyright (c) on 2019/7/10..
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
// 用于添加分享的封装、支付封装

#import <Foundation/Foundation.h>

#if __has_include(<TCMSharePay/TCMSharePay.h>)

FOUNDATION_EXPORT double TCMSharePayVersionNumber;
FOUNDATION_EXPORT const unsigned char TCMSharePayVersionString[];

#import <TCMSharePay/TCMPaymentBase.h>
#import <TCMSharePay/SocialShare.h>
#import <TCMSharePay/SocialShareUI.h>

#else

#import "TCMPaymentBase.h"
#import "SocialShare.h"
#import "SocialShareUI.h"


#endif
