//
//  PagerSubCell0.m
//  ComponentDemo
//
//  Created by ZZJ on 2019/7/12.
//  Copyright © 2019 Jion. All rights reserved.
//

#import "PagerSubCell0.h"
#import <YYKit.h>

@interface PagerSubCell0()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UILabel *detailView;
@property (nonatomic, strong) UILabel *bottomView;

@end
@implementation PagerSubCell0
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.height-20, self.height-20)];
        _iconView.image = [UIImage imageNamed:@"girl0.jpg"];
        [self addSubview:_iconView];
        
        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(_iconView.right+10, 10, self.width-_iconView.right-20, 18)];
        _titleView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        _titleView.text = @"我是林明祯";
        _titleView.font = [UIFont systemFontOfSize:18];
        _titleView.textColor = [UIColor colorWithHexString:@"#3D3D3D"];
        [self addSubview:_titleView];
        
        _detailView = [[UILabel alloc] initWithFrame:CGRectMake(_titleView.left, _titleView.bottom+2, _titleView.width, 36)];
        _detailView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        _detailView.text = @"薛之谦MV刚刚好女主角";
        _detailView.numberOfLines = 2;
        _detailView.font = [UIFont systemFontOfSize:16];
        _detailView.textColor = [UIColor colorWithHexString:@"#3D3D3D"];
        [self addSubview:_detailView];
        
        _bottomView = [[UILabel alloc] initWithFrame:CGRectMake(_titleView.left, self.height-10-16, _titleView.width, 16)];
        _bottomView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        _bottomView.text = @"粉丝约会节";
        _bottomView.font = [UIFont systemFontOfSize:16];
        _bottomView.textColor = [UIColor colorWithHexString:@"#3D3D3D"];
        [self addSubview:_bottomView];
    }
    return self;
}

@end
