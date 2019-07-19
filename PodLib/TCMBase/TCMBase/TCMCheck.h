//
//  TCMCheck.h
//  Pods-BaseDemo
//
//  Created by ZZJ on 2019/7/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCMCheck : NSObject
/* 验证手机号 */
+ (BOOL)validateMobile:(NSString *)mobileNum;

/* 验证邮箱 */
+ (BOOL)validateEmail:(NSString *)emailStr;

/* 金额检查 */
+ (BOOL)validMoney:(NSString*)str;

/* 打电话 */
+(void)callPhoneWithPhoneNumber:(NSString*)phoneNumber;

@end

NS_ASSUME_NONNULL_END
