//
//  NTalkerChatTableHeaderModel.h
//  NengCloud
//
//  Created by mac on 2017/4/14.
//  Copyright © 2017年 NTalker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTalkerChatTableHeaderModel : NSObject

@property (nonatomic, strong) NSString *goodIconUrl;

@property (nonatomic ,strong) NSString *goodName;

@property (nonatomic, assign) NSInteger goodPrice;

@property (nonatomic, strong) NSString *br;
@property (nonatomic, strong) NSString *ca;
@property (nonatomic, strong) NSString *iu;
@property (nonatomic, strong) NSString *mp;
@property (nonatomic, copy) NSString *prid;
@property (nonatomic, strong) NSString *sp;
@property (nonatomic, strong) NSString *pn;
/*
 "br":"耐克",
 "mp":"355",
 "prid":"p12345",
 "iu":"http://release-rd1.ntalker.com:140/rd/Products/p123",
 "sp":"311",
 "pn":"篮球",
 "ca":"运动类"
 */
@end
