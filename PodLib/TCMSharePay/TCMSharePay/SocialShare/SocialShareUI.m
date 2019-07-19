//
//  SocialShareUI.m
//  Superior
//
//  Created by Dao on 2018/7/26.
//  Copyright © 2018 淘菜猫. All rights reserved.
//

#import "SocialShareUI.h"

/*
 * 单例模式
 */
#define JLSDeclare(ClassName)       + (instancetype)ClassName;
#define JLSImplement(ClassName)     static ClassName *__##ClassName##__;\
+ (ClassName *)ClassName\
{\
return [[ClassName alloc] init];\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
__##ClassName##__ = [super allocWithZone:zone];\
});\
return __##ClassName##__;\
}\
- (instancetype)init\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
__##ClassName##__ = [super init];\
});\
return __##ClassName##__;\
}\
/*copy在底层 会调用copyWithZone:*/\
- (id)copyWithZone:(NSZone *)zone{\
return  __##ClassName##__;\
}\
+ (id)copyWithZone:(struct _NSZone *)zone{\
return  __##ClassName##__;\
}\
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{\
return __##ClassName##__;\
}\
- (id)mutableCopyWithZone:(NSZone *)zone{\
return __##ClassName##__;\
}

@interface SocialShareUIItem : NSObject

@property (nonatomic, assign) SocialSharePlatform platform;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) UIImage *icon;
@property (nonatomic, copy) SocialShareSelectionBlock selectionBlock;
@property (nonatomic, weak) id<SocialShareUIDelegate> delegate;

- (UIView *)viewWithBlock:(SocialShareSelectionBlock)block;
- (UIView *)viewWithDelegate:(id<SocialShareUIDelegate>) delegate;

+ (SocialShareUIItem *)itemWithPlatform:(SocialSharePlatform)platform;
+ (SocialShareUIItem *)itemWithPlatform:(SocialSharePlatform)platform name:(NSString *)name icon:(UIImage *)icon;
+ (UIView *)itemViewWithPlatform:(SocialSharePlatform)platform;
@end

@interface SocialShareUI () <SocialShareUIDelegate>

@property (nonatomic, weak) id<SocialShareUIDelegate> delegate;
@property (nonatomic, copy) SocialShareSelectionBlock selectionBlock;
@property (nonatomic, strong) SocialShareMessage *message;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, SocialShareUIItem *> *platformConfig;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, weak) UIView *floorView;
@property (nonatomic, weak) UIView *containView;
@end

@implementation SocialShareUI

JLSImplement(SocialShareUI)

+ (void)load{
    [super load];
    [self registerPlatform:SocialSharePlatform_WeChat_Timeline platformName:@"微信朋友圈" icon:[UIImage imageNamed:@"umsocial_wechat_timeline"]];
    [self registerPlatform:SocialSharePlatform_WeChat_Session platformName:@"微信好友" icon:[UIImage imageNamed:@"umsocial_wechat"]];
    [self registerPlatform:SocialSharePlatform_QQ_Session platformName:@"QQ" icon:[UIImage imageNamed:@"umsocial_qq"]];
    [self registerPlatform:SocialSharePlatform_QQ_Zone platformName:@"QQ空间" icon:[UIImage imageNamed:@"umsocial_qzone"]];
}

+ (void)registerPlatform:(SocialSharePlatform)platform platformName:(NSString *)name icon:(UIImage *)icon{
    SocialShareUIItem *item = [SocialShareUIItem itemWithPlatform:platform name:name icon:icon];
    [self.SocialShareUI.platformConfig setObject:item forKey:@(platform)];
}

+ (void)showShareMenuInWindowWithPlatform:(SocialSharePlatform)platform selectionBlock:(SocialShareSelectionBlock)selectionBlock{
    self.SocialShareUI.selectionBlock = selectionBlock;
    NSMutableArray<SocialShareUIItem *> *array = [NSMutableArray array];
    [self.SocialShareUI.platformConfig.allValues enumerateObjectsUsingBlock:^(SocialShareUIItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.platform & platform) {
            [array addObject:obj];
        }
    }];
    [self.SocialShareUI showShareMenuInWindowWithPlatform: array];
}
+ (void)showShareMenuInWindowWithPlatformArray:(NSArray<NSNumber *> *)platform selectionBlock:(SocialShareSelectionBlock)selectionBlock{
    self.SocialShareUI.selectionBlock = selectionBlock;

    NSMutableArray<SocialShareUIItem *> *array = [NSMutableArray array];
    NSDictionary<NSNumber *, SocialShareUIItem *> *platformConfig = self.SocialShareUI.platformConfig;
    [platform enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[platformConfig objectForKey:obj]];
    }];
    [self.SocialShareUI showShareMenuInWindowWithPlatform:array];
}

+ (void)showShareMenuInWindowWithPlatform:(SocialSharePlatform)platform delegate:(id<SocialShareUIDelegate>)delegate{
    self.SocialShareUI.delegate = delegate;
    NSMutableArray<SocialShareUIItem *> *array = [NSMutableArray array];
    [self.SocialShareUI.platformConfig.allValues enumerateObjectsUsingBlock:^(SocialShareUIItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.platform & platform) {
            [array addObject:obj];
        }
    }];
    [self.SocialShareUI showShareMenuInWindowWithPlatform:array];
}
+ (void)showShareMenuInWindowWithPlatformArray:(NSArray<NSNumber *> *)platform delegate:(id<SocialShareUIDelegate>)delegate{
    self.SocialShareUI.delegate = delegate;
    NSMutableArray<SocialShareUIItem *> *array = [NSMutableArray array];

    NSDictionary<NSNumber *, SocialShareUIItem *> *platformConfig = self.SocialShareUI.platformConfig;
    [platform enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[platformConfig objectForKey:obj]];
    }];

    [self.SocialShareUI showShareMenuInWindowWithPlatform:array];
}


- (void)showShareMenuInWindowWithPlatform:(NSArray<SocialShareUIItem *> *)platform{

    platform = [platform sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return ([(SocialShareUIItem *)obj1 platform] > [(SocialShareUIItem *)obj2 platform]);
    }];


    CGRect bounds = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:bounds];
    view.backgroundColor = UIColor.clearColor;

    CGFloat screenScale = 375.0/CGRectGetWidth(bounds);
    CGFloat topHeight = 50 * screenScale;
    CGFloat bottomHeight = 50 * screenScale;
    CGFloat contentHeight = 110 * screenScale;
    CGFloat height = topHeight + bottomHeight + contentHeight;

    UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(bounds), CGRectGetWidth(bounds), height)];
    containView.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:249.0f/255.0f alpha:1.0f];
;
    //顶部视图
    UIView *TopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bounds), 1)];
    [containView addSubview:TopView];
    TopView.backgroundColor = UIColor.clearColor;
    TopView.translatesAutoresizingMaskIntoConstraints = NO;

    //内容视图
    UIView *contentView = [[UIView alloc] init];
    [containView addSubview:contentView];
    contentView.backgroundColor = UIColor.clearColor;
    contentView.translatesAutoresizingMaskIntoConstraints = NO;

    //低部视图
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    [containView addSubview: button];
    button.backgroundColor = UIColor.clearColor;
    button.translatesAutoresizingMaskIntoConstraints = NO;

    [button setTitle:@"取  消" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(hideMenu) forControlEvents:(UIControlEventTouchUpInside)];


    //底部排版
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:containView attribute:(NSLayoutAttributeLeading) multiplier:1.0 constant:0];
    [containView addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightContainView = [NSLayoutConstraint constraintWithItem:button attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:containView attribute:(NSLayoutAttributeTrailing) multiplier:1.0 constant:0];
    [containView addConstraint:rightContainView];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:button attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:containView attribute:(NSLayoutAttributeBottom) multiplier:1.0 constant:0];
    [containView addConstraint:bottom];
    
    NSLayoutConstraint *heightButton = [NSLayoutConstraint constraintWithItem:button attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:bottomHeight];
    [button addConstraint:heightButton];

    UIView *breakLine = [[UIView alloc] initWithFrame:CGRectZero];
    breakLine.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1.0f];
    [button addSubview:breakLine];
    breakLine.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *leftButton = [NSLayoutConstraint constraintWithItem:breakLine attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:button attribute:(NSLayoutAttributeLeading) multiplier:1.0 constant:0];
    [button addConstraint:leftButton];
    
    NSLayoutConstraint *rightButton = [NSLayoutConstraint constraintWithItem:breakLine attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:button attribute:(NSLayoutAttributeTrailing) multiplier:1.0 constant:0];
    [button addConstraint:rightButton];
    
    NSLayoutConstraint *bottomButton = [NSLayoutConstraint constraintWithItem:breakLine attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:button attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0];
    [button addConstraint:bottomButton];
    
    NSLayoutConstraint *heightBreakLine = [NSLayoutConstraint constraintWithItem:breakLine attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:1];
    [breakLine addConstraint:heightBreakLine];

    //内容布局
    NSLayoutConstraint *left2 = [NSLayoutConstraint constraintWithItem:contentView attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:containView attribute:(NSLayoutAttributeLeading) multiplier:1.0 constant:0];
    [containView addConstraint:left2];
    
    NSLayoutConstraint *right2 = [NSLayoutConstraint constraintWithItem:contentView attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:containView attribute:(NSLayoutAttributeTrailing) multiplier:1.0 constant:0];
    [containView addConstraint:right2];
    
    NSLayoutConstraint *bottom2 = [NSLayoutConstraint constraintWithItem:contentView attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:button attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0];
    [containView addConstraint:bottom2];
    
    NSLayoutConstraint *height2 = [NSLayoutConstraint constraintWithItem:contentView attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:contentHeight];
    [contentView addConstraint:height2];

    CGFloat edgeWidth = 40 *screenScale;
    CGFloat itemWidth = (CGRectGetWidth(bounds) - edgeWidth * 2.0) / 2;
    CGFloat itemSize = 80 * screenScale;
    [platform enumerateObjectsUsingBlock:^(SocialShareUIItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *item = [obj viewWithDelegate:self];
        [contentView addSubview:item];
        item.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *widthL = [NSLayoutConstraint constraintWithItem:item attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:itemSize];
        [item addConstraint:widthL];

        NSLayoutConstraint *heightL = [NSLayoutConstraint constraintWithItem:item attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:itemSize];
        [item addConstraint:heightL];

        NSLayoutConstraint *CenterX = [NSLayoutConstraint constraintWithItem:item attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:contentView attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:(edgeWidth + (idx + 0.5) *itemWidth)];
        [contentView addConstraint:CenterX];

        NSLayoutConstraint *CenterY = [NSLayoutConstraint constraintWithItem:item attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:contentView attribute:(NSLayoutAttributeCenterY) multiplier:1.0 constant:-20];
        [contentView addConstraint:CenterY];
    }];


    //顶部布局
    NSLayoutConstraint *left3 = [NSLayoutConstraint constraintWithItem:TopView attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:containView attribute:(NSLayoutAttributeLeading) multiplier:1.0 constant:0];
    [containView addConstraint:left3];
    
    NSLayoutConstraint *right3 = [NSLayoutConstraint constraintWithItem:TopView attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:containView attribute:(NSLayoutAttributeTrailing) multiplier:1.0 constant:0];
    [containView addConstraint:right3];
    
    NSLayoutConstraint *top3 = [NSLayoutConstraint constraintWithItem:TopView attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:containView attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0];
    [containView addConstraint:top3];
    
    NSLayoutConstraint *height3 = [NSLayoutConstraint constraintWithItem:TopView attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:topHeight];
    [TopView addConstraint:height3];

    UILabel *title = [[UILabel alloc] init];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.text = @" 分享给好友 ";
    title.font = [UIFont systemFontOfSize:15];
    [TopView addSubview:title];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:title attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:TopView attribute:(NSLayoutAttributeCenterX) multiplier:1.0 constant:0];
    [TopView addConstraint:left];
    
    NSLayoutConstraint *right4 = [NSLayoutConstraint constraintWithItem:title attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:TopView attribute:(NSLayoutAttributeCenterY) multiplier:1.0 constant:5];
    [TopView addConstraint:right4];

    UIView *leftBreak = [[UIView alloc] init];
    leftBreak.translatesAutoresizingMaskIntoConstraints = NO;
    leftBreak.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1.0f];
    [TopView addSubview:leftBreak];
    NSLayoutConstraint *right5 = [NSLayoutConstraint constraintWithItem:leftBreak attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:title attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:-10];
    [TopView addConstraint:right5];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:leftBreak attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:title attribute:(NSLayoutAttributeCenterY) multiplier:1.0 constant:0];
    [TopView addConstraint:centerY];
    //
    NSLayoutConstraint *height6 = [NSLayoutConstraint constraintWithItem:leftBreak attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:1];
    [leftBreak addConstraint:height6];
    
    NSLayoutConstraint *width6 = [NSLayoutConstraint constraintWithItem:leftBreak attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:80];
    [leftBreak addConstraint:width6];

    UILabel *rightBreak = [[UILabel alloc] init];
    rightBreak.translatesAutoresizingMaskIntoConstraints = NO;
    rightBreak.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1.0f];

    [TopView addSubview:rightBreak];
    NSLayoutConstraint *right7 = [NSLayoutConstraint constraintWithItem:rightBreak attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:title attribute:(NSLayoutAttributeRight) multiplier:1.0 constant:10];
    [TopView addConstraint:right7];
    
    NSLayoutConstraint *centerY7 = [NSLayoutConstraint constraintWithItem:rightBreak attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:title attribute:(NSLayoutAttributeCenterY) multiplier:1.0 constant:0];
    [TopView addConstraint:centerY7];
    
    NSLayoutConstraint *height7 = [NSLayoutConstraint constraintWithItem:rightBreak attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:1];
    [rightBreak addConstraint:height7];
    
    NSLayoutConstraint *width7 = [NSLayoutConstraint constraintWithItem:rightBreak attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1.0 constant:80];
    [rightBreak addConstraint:width7];


    [view addSubview:containView];
    self.containView = containView;

    UIView *floorView = [[UIView alloc] initWithFrame:bounds];
    floorView.backgroundColor = UIColor.blackColor;
    [view insertSubview:floorView atIndex:0];
    floorView.alpha = 0.0;
    self.floorView = floorView;

    [UIView animateWithDuration:.3 animations:^{
        floorView.alpha = 0.3;
        containView.center = CGPointMake(containView.center.x, containView.center.y - height);
    }];

    [[UIApplication sharedApplication].keyWindow addSubview:view];

    if (self.view) {
        [self.view removeFromSuperview];
        self.message = nil;
    }
    self.view = view;
}

- (void)hideMenu{
    self.delegate = nil;
    self.selectionBlock = nil;
    self.message = nil;
    [UIView animateWithDuration:.3 animations:^{
        self.floorView.alpha = 0.0;
        self.containView.center = CGPointMake(self.containView.center.x, self.containView.center.y + CGRectGetHeight(self.containView.frame));
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        self.view = nil;
    }];
}

- (void)selectPlatform:(SocialSharePlatform)platform userInfo:(NSDictionary *)userInfo{
    if (self.message) {
        self.message.platform = platform;
        [SocialShare sendMessage:[self.message copy]];
    } else if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(selectPlatform:userInfo:)]) {
            [self.delegate selectPlatform:platform userInfo:userInfo];
        }
    } else if (self.selectionBlock){
        self.selectionBlock(platform, userInfo);
    }
    [self hideMenu];
}

- (NSMutableDictionary *)platformConfig{
    if (!_platformConfig) {
        _platformConfig = [NSMutableDictionary dictionary];
    }

    return _platformConfig;
}
+ (SocialShareMessage *)message{
    return self.SocialShareUI.message;
}
+ (void)setMessage:(SocialShareMessage *)message{
    self.SocialShareUI.message = message;
}
@end

@implementation SocialShareUIItem

+ (SocialShareUIItem *)itemWithPlatform:(SocialSharePlatform)platform{
    return [SocialShareUI.SocialShareUI.platformConfig objectForKey:@(platform)];
}
+ (SocialShareUIItem *)itemWithPlatform:(SocialSharePlatform)platform name:(NSString *)name icon:(UIImage *)icon{
    SocialShareUIItem *item = [[self alloc] init];
    item.platform = platform;
    item.name = name;
    item.icon = icon;
    return item;
}
+ (UIView *)itemViewWithPlatform:(SocialSharePlatform)platform{
    return [self itemWithPlatform:platform].itemView;
}

- (UIView *)viewWithBlock:(SocialShareSelectionBlock)block{
    self.selectionBlock = block;
    return [self itemView];
}

- (UIView *)viewWithDelegate:(id<SocialShareUIDelegate>)delegate{
    self.delegate = delegate;
    return [self itemView];
}

- (UIView *)itemView{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];

    [button setImage:self.icon forState:(UIControlStateNormal)];
//    [button setBackgroundImage:[UIImage imageNamed:@"umsocial_default"] forState:(UIControlStateNormal)];
    button.tag = self.platform;
    button.layer.cornerRadius = 10;
    button.backgroundColor = UIColor.clearColor;

    UILabel *label = [[UILabel alloc] init];
    label.text = self.name;
    label.font = [UIFont systemFontOfSize:14];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [button addSubview:label];

    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:label attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:button attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [button addConstraint:top];

    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:label attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:button attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [button addConstraint:centerX];

    [button addTarget:self action:@selector(action) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}

- (void)action{
    [self.delegate selectPlatform:self.platform userInfo:nil];
}
@end


