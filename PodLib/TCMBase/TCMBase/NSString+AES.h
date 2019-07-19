//
//  NSString+AES.h
//  AFNetworking
//
//  Created by ZZJ on 2019/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES)

//AES加密
- (NSString*)tcm_encryptAESByKey:(NSString *)key;

//AES解密
- (NSString*)tcm_DecryptAESByKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
