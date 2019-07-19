//
//  thybridBackgroundView.m
//  AFNetworking
//
//  Created by Dao on 2018/11/17.
//

#import "thybridBackgroundView.h"
#import "TCMWeex.h"
#import <Masonry/Masonry.h>


const NSInteger THYBRID_BACKGROUND_VIEW_TAG = 1024;
const NSInteger THYBRID_CREATE_VIEW_TAG = 2048;

@interface UIImage (weex_ShadowImage)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

@interface thybridBackgroundView ()

@property (nonatomic, strong) UIView *NavigationView;

@property (nonatomic, strong) UIView *optionView;

@end

@implementation thybridBackgroundView


+ (instancetype)objectWithHandler:(UIViewController<tHybridWeexProtocol> *)handler{
    thybridBackgroundView *obj = [[self alloc] init];
    UIView *containView = [[UIView alloc] init];
    
    [obj addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    obj.handler = handler;

    return obj;
}


- (void)setLoadingStatus:(THYBRID_LOADING_STATUS)loadingStatus{

    switch (loadingStatus) {
        case THYBRID_LOADING_STATUS_LOADING:
            [self resetOptionView:nil];
            break;
        case THYBRID_LOADING_STATUS_NETWORK_ERROR:
            [self networkError];
            break;
        case THYBRID_LOADING_STATUS_LOAD_FAILED:
            [self loadFail];
            break;
        case THYBRID_LOADING_STATUS_NO_FILE:
            [self noFile];
            break;
        case THYBRID_LOADING_STATUS_LOAD_FINISH:
            self.exclusiveTouch = NO;
            break;
        case THYBRID_LOADING_STATUS_FILE_EXECUTION_FAILED:
            [self executionFail];
            break;
        case THYBRID_LOADING_STATUS_RENDER_FINISH:
            if (_loadingStatus == THYBRID_LOADING_STATUS_FILE_EXECUTION_FAILED) {
                return;
            }
            [self finish];
            break;
    }
    _loadingStatus = loadingStatus;
}

- (void)networkError{
    UILabel *label = [[UILabel alloc] init];
    [self resetOptionView:label];
    label.text = @"网络不可用,请检查网络后重试！";
    label.textAlignment = NSTextAlignmentCenter;
}

- (void)loadFail{
    [self failView];
}

- (void)noFile{
    UILabel *label = [[UILabel alloc] init];
    [self resetOptionView:label];
    label.text = @"文件不存在,请稍后重试！";
    label.textAlignment = NSTextAlignmentCenter;
}

- (void)executionFail{
    UILabel *label = [[UILabel alloc] init];
    [self resetOptionView:label];
    NSLog(@"%@", label);
    label.text = @"程序异常,请稍后重试！";
    label.textAlignment = NSTextAlignmentCenter;
    self.hidden = NO;

}

-(void)failView {
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeCenter;
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"tHybridKit" withExtension:@"bundle"];
    if (url) {
        NSBundle *targetBundle = [NSBundle bundleWithURL:url];
        UIImage *image = [UIImage imageNamed:@"404.png"
                                    inBundle:targetBundle
               compatibleWithTraitCollection:nil];
        imageView.image = image;
    }
    
    [self resetOptionView:imageView];
}

- (void)finish{
    [self resetOptionView:nil];
    self.hidden = YES;
}


- (void)action{
    [self resetOptionView:nil];
    if ([self.handler respondsToSelector:@selector(rendererWeex)]) {
        [self.handler rendererWeex];
    }
}

- (UINavigationBar *)navigationBar{
    if (!_navigationBar) {
        UIView *NavigationView = [[UIView alloc] init];
        [self addSubview:NavigationView];
        [NavigationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.offset(0);
            if (tHybridKit.Thybrid_Kit_Iphone_X){
                make.height.mas_equalTo(44 + 44);
            } else {
                make.height.mas_equalTo(44 + 20);
            }
        }];
        _NavigationView = NavigationView;
        
        UINavigationBar *bar = [[UINavigationBar alloc] init];

        UIColor *barColor = [UINavigationBar appearance].barTintColor;
        if (self.handler.noption.titleColor) {
            barColor = self.handler.noption.barColor;
        }
        
        bar.barTintColor = barColor;
        NavigationView.backgroundColor = barColor;
        bar.translucent = NO;
        
        [NavigationView addSubview:bar];
        [bar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.offset(0);
        }];
        
        _navigationBar = bar;
    }
    
    return _navigationBar;
}

- (UINavigationItem *)navigationItem{
    if (!_navigationItem) {
        UINavigationItem *item = [[UINavigationItem alloc] init];
        self.navigationBar.items = @[item];
        item.title = @"淘菜猫";
        UIColor *titleColor = UIColor.whiteColor;
        if (self.handler.noption.titleColor) {
            titleColor = self.handler.noption.titleColor;
        }
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: titleColor,
                                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                                                     }];
        UIColor *shadowColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
        [self.navigationBar setShadowImage:[UIImage imageWithColor:shadowColor]];

        _navigationItem = item;
    }
    
    return _navigationItem;
}


- (NSString *)title{
    return self.navigationItem.title;
}
- (void)setTitle:(NSString *)title{
    if (!title.length) {
        self.NavigationView.backgroundColor = [UIColor whiteColor];
        self.navigationBar.hidden = YES;

        [self.NavigationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];

        return;
    }
    self.navigationItem.title = title;
}
- (UIBarButtonItem *)leftBarButtonItem{
    return self.navigationItem.leftBarButtonItem;
}
- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem{
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (UIBarButtonItem *)rightBarButtonItem{
    return self.navigationItem.rightBarButtonItem;
}
- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem{
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
- (void)resetOptionView:(UIView *)childView{
    [self.optionView removeFromSuperview];

    if (!childView) {
        return;
    }
    UIView *view = [[UIView alloc] init];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.mas_equalTo(self.NavigationView.mas_bottom).offset(0);
    }];

    childView.backgroundColor = UIColor.whiteColor;
    [view addSubview:childView];
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.centerY.equalTo(view.mas_centerY).mas_offset(-100);
        make.height.mas_equalTo(250);
    }];
    self.optionView = view;
    if (childView) {
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundColor:[UIColor colorWithRed:195/255.0 green:45/255.0 blue:74/255.0 alpha:1.0]];
        [button setTitle:@"重新加载" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.layer.cornerRadius = 5.0;
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(100);
            make.top.equalTo(childView.mas_bottom).mas_offset(-30);
            make.centerX.equalTo(view.mas_centerX);
        }];
        [button addTarget:self action:@selector(action) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

@end


@implementation UIImage (weex_ShadowImage)

+ (UIImage *)imageWithColor:(UIColor *)color{
    if (!color) return nil;

    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    CGRect rect = CGRectMake(0.0f, 0.0f, width, 0.5);

    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
