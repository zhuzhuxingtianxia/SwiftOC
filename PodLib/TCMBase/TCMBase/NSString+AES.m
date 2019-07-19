//
//  NSString+AES.m
//  AFNetworking
//
//  Created by ZZJ on 2019/7/13.
//

#import "NSString+AES.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

static NSString *const AES_IV_PARAMETER = @"";

@implementation NSString (AES)

//AES加密
- (NSString*)tcm_encryptAESByKey:(NSString *)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aesData = [self AES128operation:kCCEncrypt
                                       data:data
                                        key:key
                                         iv:AES_IV_PARAMETER];;
    
    NSString *base64Str = [aesData base64EncodedStringWithOptions:0];
    
    return base64Str;
}
//AES解密
- (NSString*)tcm_DecryptAESByKey:(NSString *)key {
    NSData *baseData = [[NSData alloc]initWithBase64EncodedString:self options:0];
    NSData *aesDecData = [self AES128operation:kCCDecrypt
                                          data:baseData
                                           key:key
                                            iv:AES_IV_PARAMETER];
    
    NSString *decStr = [[NSString alloc] initWithData:aesDecData encoding:NSUTF8StringEncoding];
    
    return decStr;
}

/**
 *  AES加解密算法
 *
 *  @param operation kCCEncrypt（加密）kCCDecrypt（解密）
 *  @param data      待操作Data数据
 *  @param key       key
 *  @param iv        向量
 *
 *  @return data
 */
- (NSData *)AES128operation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES, kCCOptionECBMode|kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [data bytes], [data length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess) {
        NSLog(@"Success");
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    } else {
        NSLog(@"Error");
    }
    
    free(buffer);
    return nil;
}


@end
