//
//  NtalkerEvaluateSetInfoModel.h
//  NtalkerIMLib
//
//  Created by NTalker-zhou on 17/8/17.
//  Copyright © 2017年 ios_develop. All rights reserved.
//  评价配置信息

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NtalkerEvaluationItemOptionsModel : NSObject

@property (nonatomic ,strong) NSString *content;

@property (nonatomic ,strong) NSString *itemId;

@property (nonatomic ,strong) NSString *optionId;

@property (nonatomic ,strong) NSString *siteid;

@property (nonatomic ,assign) NSInteger useable;

@property (nonatomic ,assign) NSInteger soure;

@property (nonatomic ,assign) NSInteger rank;

@property (nonatomic ,assign) NSInteger isDefault;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

@interface NtalkerEvaluationItemModel : NSObject

@property (nonatomic ,strong) NSString *result;

@property (nonatomic ,strong) NSString *itemId;

@property (nonatomic ,assign) NSInteger optionType;

@property (nonatomic ,strong) NSString *siteid;

@property (nonatomic ,strong) NSString *content;

@property (nonatomic ,strong) NSString *evaluationId;

@property (nonatomic ,assign) NSInteger userable;

@property (nonatomic ,strong) NSString *title;

@property (nonatomic ,assign) NSInteger rank;

@property (nonatomic ,strong) NSArray <NtalkerEvaluationItemOptionsModel *>*option;

- (instancetype)initWithDictionary:(NSDictionary *)dic;


@end



@interface NtalkerEvaluateSetInfoModel : NSObject

@property(nonatomic ,strong) NSString *title;

@property(nonatomic ,strong) NSString *evaluateBtnTitle;

//评价项目配置
@property (nonatomic ,strong) NSMutableArray <NtalkerEvaluationItemModel *>*conversationEvaluationItemsArray;
//评价方式配置
//@property (nonatomic ,strong) NSMutableArray *conversationEvaluationMethods;
@property (nonatomic ,strong) NSString *evaluationId;
@property (nonatomic ,strong) NSString *templateid;


- (instancetype)getEvaluateSetInfoModelFromDic:(NSDictionary *)dic;

@end
