//
//  TCMCheck.m
//  Pods-BaseDemo
//
//  Created by ZZJ on 2019/7/10.
//

#import "TCMCheck.h"
@interface TCMCheck ()
    
@end

@implementation TCMCheck

#pragma mark - 验证手机号
+ (BOOL)validateMobile:(NSString *)mobileNum
    {
        NSString * MOBILE = @"^1([3-9][0-9])\\d{8}$";
        NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[0-9])\\d)\\d{7}$";
        NSString * CU = @"^1(3[0-2]|5[256]|8[0-9])\\d{8}$";
        NSString * CT = @"^1((33|53|8[0-9]|77)[0-9]|349)\\d{7}$";
        
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        
        if (([regextestmobile evaluateWithObject:mobileNum] == YES)
            || ([regextestcm evaluateWithObject:mobileNum] == YES)
            || ([regextestct evaluateWithObject:mobileNum] == YES)
            || ([regextestcu evaluateWithObject:mobileNum] == YES))
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
#pragma mark - 验证邮箱
+ (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:emailStr];

}

#pragma mark -- 金额检查
+ (BOOL)validMoney:(NSString*)str {
    //匹配以0开头的数字
    NSPredicate * predicate0 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0][0-9]+$"];
    //匹配两位小数、整数
    NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(([1-9]{1}[0-9]*|[0]).?[0-9]{0,2})$"];
    BOOL isPass = ![predicate0 evaluateWithObject:str] && [predicate1 evaluateWithObject:str] ? YES : NO;
    
    return isPass;
}

#pragma mark -- 数字校验[0-9]
+ (BOOL)validNumber:(NSString*)number {
    NSString *pattern = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}
#pragma mark -- 字母校验
+ (BOOL)validWord:(NSString*)word {
    NSString *pattern = @"^[A-Za-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:word];
    return isMatch;
}
#pragma mark -- 名字校验 【长度1-20的汉字】
+ (BOOL)checkName:(NSString *) userName{
    //^[\u4e00-\u9fa5]{0,}$
    NSString *pattern = @"^[一-龥]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

#pragma mark -- 打电话
+(void)callPhoneWithPhoneNumber:(NSString*)phoneNumber{
    if (phoneNumber.length == 0) {
        return;
    }
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNumber];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    });
}

@end
