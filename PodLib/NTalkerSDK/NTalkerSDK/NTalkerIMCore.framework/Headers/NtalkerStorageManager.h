//
//  NtalkerStorageManager.h
//  NtalkerIMLib
//
//  Created by wzh on 2017/12/21.
//  Copyright © 2017年 ios_develop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NtalkerStorageManager : NSObject

//+ (NSString *)fetchCacheDir;
/**
 获取音频文件路径

 @return 音频文件路径
 */
+ (NSString *)fetchAudioFilePathWithFileName:(NSString *)fileName;

/**
 获取图片文件路径

 @param fileName 文件名
 @return 图片文件路径
 */
+ (NSString *)fetchImageFilePathWithFileName:(NSString *)fileName;

/**
 获取视频文件路径
 
 @return 音频文件路径
 */
+ (NSString *)fetchVideoFilePathWithFileName:(NSString *)fileName;

/**
 清除本地语音文件缓存

 @return 是否成功
 */
+ (BOOL)cleanAllAudioCache;

/**
 清除本地图片文件缓存

 @return 是否成功
 */
+ (BOOL)cleanAllImageCache;

/**
 清除本地视频文件缓存
 
 @return 是否成功
 */
+ (BOOL)cleanAllVideoCache;





/**
 存储图片-原图
 
 @param imageData 原图
 @param name 文件名
 @return 是否成功
 */
+ (BOOL)saveOriginImage:(NSData *)imageData name:(NSString *)name;

/**
 读取图片-原图
 
 @param imageName 图片名
 @return 原图
 */
+ (UIImage *)getOriginImageWithName:(NSString *)imageName;

/**
 删除图片-原图

 @param name 图片名
 @return 是否成功
 */
+ (BOOL)deleteOriginImageWithName:(NSString *)name;

/**
 存储图片-缩略图
 
 @param imageData 缩略图
 @param name 文件名
 @return 是否成功
 */
+ (BOOL)saveThumbImage:(NSData *)imageData name:(NSString *)name;

/**
 读取图片-缩略图
 
 @param imageName 图片名
 @return 缩略图
 */
+ (UIImage *)getThumbImageWithName:(NSString *)imageName;

/**
 删除图片-缩略图

 @param name 图片名
 @return 是否成功
 */
+ (BOOL)deleteThumbImageWithName:(NSString *)name;
/**
 存储音频文件
 
 @param audioFileData 音频文件
 @param name 文件名
 @return 是否成功
 */
+ (BOOL)saveAudioFile:(NSData *)audioFileData name:(NSString *)name;

/**
 获取音频文件
 
 @param name 文件名
 @return 文件
 */
+ (NSData *)getAudioFileWithName:(NSString *)name;

/**
 删除音频文件

 @param name 文件名
 @return 是否成功
 */
+ (BOOL)deleteAudioFileWithName:(NSString *)name;

/**
 存储视频文件
 
 @param videoFileData 视频文件
 @param name 文件名
 @return 是否成功
 */
//+ (BOOL)saveVideoFile:(NSData *)videoFileData name:(NSString *)name;

/**
 获取视频文件
 
 @param name 文件名
 @return 文件
 */
+ (NSData *)getVideoFileWithName:(NSString *)name;

/**
 删除视频文件

 @param name 文件名
 @return 文件
 */
+ (BOOL)deleteVideoFileWithName:(NSString *)name;
/**
 存储其他文件
 
 @param fileData 其他类型文件
 @param name 文件名
 @return 是否成功
 */
+ (BOOL)saveOtherFile:(NSData *)fileData name:(NSString *)name;

/**
 获取其他文件
 
 @param name 文件名
 @return 文件
 */
+ (NSData *)getOtherFileWithName:(NSString *)name;

/**
 删除其他类型文件

 @param name 文件名
 @return 是否成功
 */
+ (BOOL)deleteOtherFileWithName:(NSString *)name;

/**
 UserDefault 存储
 
 @param value 值
 @param key 键
 */
+ (void)saveValue:(id)value forKey:(NSString *)key;

/**
 UserDefault 取值
 
 @param key 键
 @return 值
 */
+ (id)getValueForKey:(NSString *)key;

@end

