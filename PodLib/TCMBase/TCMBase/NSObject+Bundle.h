//
//  NSObject+Bundle.h
//  AFNetworking
//
//  Created by ZZJ on 2019/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Bundle)
/**
 *  APP名称
 */
@property (nonatomic, copy, readonly) NSString *bundleDisplayName;
@property (class, nonatomic, copy, readonly) NSString *bundleDisplayName;
/**
 *  project名称
 */
@property (nonatomic, copy, readonly) NSString *projectName;
@property (class, nonatomic, copy, readonly) NSString *projectName;

/**
 *  APP版本号
 */
@property (nonatomic, copy, readonly) NSString *bundleVersion;
@property (class, nonatomic, copy, readonly) NSString *bundleVersion;


/**
 *  APP Build号
 */
@property (nonatomic, copy, readonly) NSString *bundleBuildVersion;
@property (class, nonatomic, copy, readonly) NSString *bundleBuildVersion;

/**
 *  APP Identifier标识
 */
@property (nonatomic, copy, readonly) NSString *bundleIdentifier;
@property (class, nonatomic, copy, readonly) NSString *bundleIdentifier;


@end

NS_ASSUME_NONNULL_END
