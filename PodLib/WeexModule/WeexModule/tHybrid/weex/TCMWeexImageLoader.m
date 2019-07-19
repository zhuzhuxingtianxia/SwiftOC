//
//  TCMWeexImageLoader.m
//  Weex
//
//  Created by Dao on 2017/12/29.
//  Copyright © 2017年 Taocaimall. All rights reserved.
//

#import "TCMWeexImageLoader.h"
#import "YYWebImageManager.h"

@interface NSString (TCMWeexImageLoader)

- (nullable UIImage *)wxImage;
- (nullable NSURL *)wxURL;

@end

@implementation NSString (TCMWeexImageLoader)
- (nullable UIImage *)wxImage{
    NSArray *array = [self componentsSeparatedByString:@"/"];
    NSString *imageName = array.lastObject;
    NSLog(@"%@", imageName);

    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

- (nullable NSURL *)wxURL{
    return [NSURL URLWithString:self];
}
@end


@interface TCMWeexImageLoader ()<WXImageOperationProtocol>

@end

@implementation TCMWeexImageLoader


- (id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url imageFrame:(CGRect)imageFrame userInfo:(NSDictionary *)options completed:(void (^)(UIImage *, NSError *, BOOL))completedBlock {
    if (!completedBlock) {
        return self;
    }
    UIImage *image = url.wxImage;
    if (image) {
        completedBlock( image, nil, YES);
        return NULL;
    }

    return (id<WXImageOperationProtocol>)[[YYWebImageManager sharedManager] requestImageWithURL:url.wxURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        completedBlock([UIImage imageNamed:@"defaultImage"], nil, NO);
    } transform:NULL completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        completedBlock( image, error, YES);
    }];
}



- (void)cancel {

}

@end
