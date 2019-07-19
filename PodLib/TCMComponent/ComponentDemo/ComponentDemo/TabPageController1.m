//
//  TabPageController1.m
//  ComponentDemo
//
//  Created by ZZJ on 2019/7/11.
//  Copyright © 2019 Jion. All rights reserved.
//

#import "TabPageController1.h"
#import <TCMComponent.h>
#import <YYKit.h>

@interface TabPageController1 ()
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation TabPageController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"效果展示";
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.contentSize = CGSizeMake(self.view.width, 150*6);
    [self.view addSubview:self.scrollView];
    
    [self buildView0];
    
    [self buildView1];
    
    [self buildView2];
    
    [self buildView3];
    
    [self buildView4];
    
    [self buildView5];
    
    [self buildView6];
}


-(void)buildView0 {
    UILabel *label = [UILabel new];
    label.text = @"只展示文字和选中状态";
    label.frame = CGRectMake(40, 0, 300, 50);
    [self.scrollView addSubview:label];
     TCMTabPagerView *topView = [[TCMTabPagerView alloc] initWithFrame:CGRectMake(0, label.bottom, self.view.width, 45)];
    topView.backgroundColor = [UIColor blackColor];
    
    TCMTabPagerConfigModel *pagerConfigModel = [TCMTabPagerConfigModel new];
    pagerConfigModel.normalTitleColor = @"#ffffff";
    pagerConfigModel.selectTitleColor = @"#FF0033";
    pagerConfigModel.fontSize = [UIFont systemFontOfSize:13];
    pagerConfigModel.selectFontSize = [UIFont boldSystemFontOfSize:14];
    //设置配置
    topView.pagerConfigModel = pagerConfigModel;
    
    NSMutableArray *titleArray = [NSMutableArray array];
    for (NSInteger i = 0; i<6; i++) {
        TCMTabPagerConfigItemModel *model = [TCMTabPagerConfigItemModel new];
        model.title = [NSString stringWithFormat:@"标题%ld",i];
        [titleArray addObject:model];
    }
    //设置标题数据
    [topView renderUIWithArray:titleArray];
    //设置选中索引
    [topView tabItemSelected:1];
    
    __weak typeof(TCMTabPagerView) *weakTopView = topView;
    [topView addItemClickBlock:^(NSInteger tag) {
        NSLog(@"tag==%ld",tag);
        [weakTopView tabItemSelected:tag];
    }];
    [self.scrollView addSubview:topView];
}
-(void)buildView1 {
    UILabel *label = [UILabel new];
    label.text = @"只展示文字蒙层和选中状态";
    label.frame = CGRectMake(40, 100, 300, 50);
    [self.scrollView addSubview:label];
    TCMTabPagerView *topView = [[TCMTabPagerView alloc] initWithFrame:CGRectMake(0, label.bottom, self.view.width, 45)];
    topView.backgroundColor = [UIColor blackColor];
    
    TCMTabPagerConfigModel *pagerConfigModel = [TCMTabPagerConfigModel new];
    pagerConfigModel.normalTitleColor = @"#ffffff";
    pagerConfigModel.selectTitleColor = @"#FF0033";
    pagerConfigModel.fontSize = [UIFont systemFontOfSize:13];
    pagerConfigModel.selectFontSize = [UIFont boldSystemFontOfSize:16];
    pagerConfigModel.maskColor = @"#269FE7";
    pagerConfigModel.maskWidth = 60;
    //设置配置
    topView.pagerConfigModel = pagerConfigModel;
    
    NSMutableArray *titleArray = [NSMutableArray array];
    for (NSInteger i = 0; i<6; i++) {
        TCMTabPagerConfigItemModel *model = [TCMTabPagerConfigItemModel new];
        model.title = [NSString stringWithFormat:@"标题%ld",i];
        [titleArray addObject:model];
    }
    //设置标题数据
    [topView renderUIWithArray:titleArray];
    
    __weak typeof(TCMTabPagerView) *weakTopView = topView;
    [topView addItemClickBlock:^(NSInteger tag) {
        NSLog(@"tag==%ld",tag);
        [weakTopView tabItemSelected:tag];
        UIView *maskView = weakTopView.maskView;
        maskView.frame = CGRectMake(tag*maskView.width, maskView.top, maskView.width, maskView.height);
    }];
    [self.scrollView addSubview:topView];
}
-(void)buildView2 {
    UILabel *label = [UILabel new];
    label.text = @"只展示文字下划线和选中状态";
    label.frame = CGRectMake(40, 200, 300, 50);
    [self.scrollView addSubview:label];
    TCMTabPagerView *topView = [[TCMTabPagerView alloc] initWithFrame:CGRectMake(0, label.bottom, self.view.width, 45)];
    topView.backgroundColor = [UIColor blackColor];
    
    TCMTabPagerConfigModel *pagerConfigModel = [TCMTabPagerConfigModel new];
    pagerConfigModel.normalTitleColor = @"#ffffff";
    pagerConfigModel.selectTitleColor = @"#FF0033";
    pagerConfigModel.fontSize = [UIFont systemFontOfSize:13];
    pagerConfigModel.selectFontSize = [UIFont boldSystemFontOfSize:14];
    pagerConfigModel.maskColor = @"#FF0033";
    pagerConfigModel.maskWidth = 60;
    pagerConfigModel.maskHeight = 2;
    pagerConfigModel.maskPositionType = TCMViewPagerMaskPositionTypeBottom;
    //设置配置
    topView.pagerConfigModel = pagerConfigModel;
    
    NSMutableArray *titleArray = [NSMutableArray array];
    for (NSInteger i = 0; i<6; i++) {
        TCMTabPagerConfigItemModel *model = [TCMTabPagerConfigItemModel new];
        model.title = [NSString stringWithFormat:@"标题%ld",i];
        [titleArray addObject:model];
    }
    //设置标题数据
    [topView renderUIWithArray:titleArray];
    //设置选中索引
    [topView tabItemSelected:1];
    //设置选中索引时，需设置滑块移动
    UIView *maskView = topView.maskView;
    maskView.frame = CGRectMake(1*maskView.width, maskView.top, maskView.width, maskView.height);
    
    __weak typeof(TCMTabPagerView) *weakTopView = topView;
    [topView addItemClickBlock:^(NSInteger tag) {
        NSLog(@"tag==%ld",tag);
        [weakTopView tabItemSelected:tag];
        //设置滑块移动
        UIView *maskView = weakTopView.maskView;
        maskView.frame = CGRectMake(tag*maskView.width, maskView.top, maskView.width, maskView.height);
    }];
    [self.scrollView addSubview:topView];
}

-(void)buildView3 {
    UILabel *label = [UILabel new];
    label.text = @"展示文字item超过一行";
    label.frame = CGRectMake(40, 300, 300, 50);
    [self.scrollView addSubview:label];
    TCMTabPagerView *topView = [[TCMTabPagerView alloc] initWithFrame:CGRectMake(0, label.bottom, self.view.width, 45)];
    topView.backgroundColor = [UIColor blackColor];
    
    TCMTabPagerConfigModel *pagerConfigModel = [TCMTabPagerConfigModel new];
    pagerConfigModel.normalTitleColor = @"#ffffff";
    pagerConfigModel.selectTitleColor = @"#FF0033";
    pagerConfigModel.fontSize = [UIFont systemFontOfSize:13];
    pagerConfigModel.selectFontSize = [UIFont boldSystemFontOfSize:14];
    //设置滑动
    pagerConfigModel.itemWidth = 80;
    pagerConfigModel.type = TCMViewPagerViewTypeCanScroll;
    //设置配置
    topView.pagerConfigModel = pagerConfigModel;
    
    NSMutableArray *titleArray = [NSMutableArray array];
    for (NSInteger i = 0; i<10; i++) {
        TCMTabPagerConfigItemModel *model = [TCMTabPagerConfigItemModel new];
        model.title = [NSString stringWithFormat:@"标题%ld",i];
        [titleArray addObject:model];
    }
    //设置标题数据
    [topView renderUIWithArray:titleArray];
    
    __weak typeof(TCMTabPagerView) *weakTopView = topView;
    [topView addItemClickBlock:^(NSInteger tag) {
        NSLog(@"tag==%ld",tag);
        [weakTopView tabItemSelected:tag];
        //写在内容的scrollView代理方法里
        if (pagerConfigModel.type == TCMViewPagerViewTypeCanScroll) {
            CGFloat rate = weakTopView.tabScroller.contentOffset.x/weakTopView.tabScroller.contentSize.width;
            CGFloat tabWidth = weakTopView.tabScroller.contentSize.width;
            CGFloat itemWidth = weakTopView.maskView.width;
            UIView *maskView = weakTopView.maskView;
            
            CGFloat centerX = tabWidth*rate+itemWidth/2;
            if (centerX>self.view.width/2 && centerX<tabWidth-self.view.width/2) {
                weakTopView.tabScroller.contentOffset = CGPointMake(centerX-self.view.width/2, 0);
                maskView.frame = CGRectMake(self.view.width/2-itemWidth/2, maskView.top, maskView.width, maskView.height);
            }
            
            if (centerX <= self.view.width/2) {
                weakTopView.tabScroller.contentOffset = CGPointMake(0, 0);
                maskView.frame = CGRectMake(tabWidth*rate, maskView.top, maskView.width, maskView.height);
            }
            
            if (centerX >= tabWidth-self.view.width/2) {
                weakTopView.tabScroller.contentOffset = CGPointMake(tabWidth-self.view.width, 0);
                maskView.frame = CGRectMake(self.view.width/2+tabWidth*rate-(tabWidth-self.view.width/2), maskView.top, maskView.width, maskView.height);
            }
        }
    }];
    
    [self.scrollView addSubview:topView];
}

-(void)buildView4 {
    UILabel *label = [UILabel new];
    label.text = @"展示文字item超过一行,加两个蒙层";
    label.frame = CGRectMake(40, 400, 300, 50);
    [self.scrollView addSubview:label];
    TCMTabPagerView *topView = [[TCMTabPagerView alloc] initWithFrame:CGRectMake(0, label.bottom, self.view.width, 45)];
    topView.backgroundColor = [UIColor blackColor];
    
    TCMTabPagerConfigModel *pagerConfigModel = [TCMTabPagerConfigModel new];
    pagerConfigModel.normalTitleColor = @"#ffffff";
    pagerConfigModel.selectTitleColor = @"#FF0033";
    pagerConfigModel.fontSize = [UIFont systemFontOfSize:13];
    pagerConfigModel.selectFontSize = [UIFont boldSystemFontOfSize:14];
    //底部滑块蒙层
    pagerConfigModel.maskColor = @"#FF0033";
    pagerConfigModel.maskWidth = 80;
    pagerConfigModel.maskHeight = 2;
    pagerConfigModel.maskPositionType = TCMViewPagerMaskPositionTypeBottom;
    //第二蒙层
    pagerConfigModel.needSecondaryMask = YES;
    pagerConfigModel.secondaryMaskColor = @"#FFFFFF";
    pagerConfigModel.secondaryMaskColorAlpha = 0.3;
    //设置滑动
    pagerConfigModel.itemWidth = 80;
    pagerConfigModel.type = TCMViewPagerViewTypeCanScroll;
    //设置配置
    topView.pagerConfigModel = pagerConfigModel;
    
    NSMutableArray *titleArray = [NSMutableArray array];
    for (NSInteger i = 0; i<10; i++) {
        TCMTabPagerConfigItemModel *model = [TCMTabPagerConfigItemModel new];
        model.title = [NSString stringWithFormat:@"标题%ld",i];
        [titleArray addObject:model];
    }
    //设置标题数据
    [topView renderUIWithArray:titleArray];
    
    __weak typeof(TCMTabPagerView) *weakTopView = topView;
    [topView addItemClickBlock:^(NSInteger tag) {
        NSLog(@"tag==%ld",tag);
        [weakTopView tabItemSelected:tag];
        //设置滑块移动
        UIView *maskView = weakTopView.maskView;
        maskView.frame = CGRectMake(tag*maskView.width, maskView.top, maskView.width, maskView.height);
    }];
    
    [self.scrollView addSubview:topView];
}

-(void)buildView5 {
    UILabel *label = [UILabel new];
    label.text = @"只展示图片";
    label.frame = CGRectMake(40, 500, 300, 50);
    [self.scrollView addSubview:label];
    TCMTabPagerView *topView = [[TCMTabPagerView alloc] initWithFrame:CGRectMake(0, label.bottom, self.view.width, 45)];
    topView.backgroundColor = [UIColor blackColor];
    
    TCMTabPagerConfigModel *pagerConfigModel = [TCMTabPagerConfigModel new];
    //区分本地图片和网络图片
    pagerConfigModel.itemType = TCMTabPagerItemTypeForImage;
    pagerConfigModel.maskColor = @"#FFC900";
    pagerConfigModel.maskWidth = 10;
    pagerConfigModel.maskHeight = 2;
    pagerConfigModel.maskPositionType = TCMViewPagerMaskPositionTypeBottom;
    //设置配置
    topView.pagerConfigModel = pagerConfigModel;
    
    NSMutableArray *titleArray = [NSMutableArray array];
    TCMTabPagerConfigItemModel *model = [TCMTabPagerConfigItemModel new];
    model.normalIconName = @"car_unselect";
    model.selectIconName = @"car_select";
    [titleArray addObject:model];
    TCMTabPagerConfigItemModel *model1 = [TCMTabPagerConfigItemModel new];
    model1.normalIconName = @"flight_unselect";
    model1.selectIconName = @"flight_select";
    [titleArray addObject:model1];
    TCMTabPagerConfigItemModel *model2 = [TCMTabPagerConfigItemModel new];
    model2.normalIconName = @"home_unselect";
    model2.selectIconName = @"home_select";
    [titleArray addObject:model2];
    TCMTabPagerConfigItemModel *model3 = [TCMTabPagerConfigItemModel new];
    model3.normalIconName = @"hotel_unselect";
    model3.selectIconName = @"hotel_select";
    [titleArray addObject:model3];
    
    //设置标题数据
    [topView renderUIWithArray:titleArray];
    //设置选中索引
    [topView tabItemSelected:1];
    //设置选中索引时，需设置滑块移动
    UIView *maskView = topView.maskView;
    maskView.frame = CGRectMake(1*maskView.width, maskView.top, maskView.width, maskView.height);
    
    __weak typeof(TCMTabPagerView) *weakTopView = topView;
    [topView addItemClickBlock:^(NSInteger tag) {
        NSLog(@"tag==%ld",tag);
        [weakTopView tabItemSelected:tag];
        //设置滑块移动
        UIView *maskView = weakTopView.maskView;
        maskView.frame = CGRectMake(tag*maskView.width, maskView.top, maskView.width, maskView.height);
    }];
    [self.scrollView addSubview:topView];
}

-(void)buildView6 {
    UILabel *label = [UILabel new];
    label.text = @"只展示文字+图片";
    label.frame = CGRectMake(40, 600, 300, 50);
    [self.scrollView addSubview:label];
    TCMTabPagerView *topView = [[TCMTabPagerView alloc] initWithFrame:CGRectMake(0, label.bottom, self.view.width, 55)];
    topView.backgroundColor = [UIColor blackColor];
    
    TCMTabPagerConfigModel *pagerConfigModel = [TCMTabPagerConfigModel new];
    //区分本地图片和网络图片
    pagerConfigModel.itemType = TCMTabPagerItemTypeForTextAndImage;
    pagerConfigModel.normalTitleColor = @"#ffffff";
    pagerConfigModel.selectTitleColor = @"#FFC900";
    pagerConfigModel.fontSize = [UIFont systemFontOfSize:13];
    pagerConfigModel.selectFontSize = [UIFont boldSystemFontOfSize:14];
    
    pagerConfigModel.maskColor = @"#FFC900";
    pagerConfigModel.maskWidth = 10;
    pagerConfigModel.maskHeight = 2;
    pagerConfigModel.maskPositionType = TCMViewPagerMaskPositionTypeBottom;
    //设置配置
    topView.pagerConfigModel = pagerConfigModel;
    
    NSMutableArray *titleArray = [NSMutableArray array];
    TCMTabPagerConfigItemModel *model = [TCMTabPagerConfigItemModel new];
    model.title = @"标题0";
    model.normalIconName = @"car_unselect";
    model.selectIconName = @"car_select";
    [titleArray addObject:model];
    TCMTabPagerConfigItemModel *model1 = [TCMTabPagerConfigItemModel new];
    model1.title = @"标题1";
    model1.normalIconName = @"flight_unselect";
    model1.selectIconName = @"flight_select";
    [titleArray addObject:model1];
    TCMTabPagerConfigItemModel *model2 = [TCMTabPagerConfigItemModel new];
    model2.title = @"标题2";
    model2.normalIconName = @"home_unselect";
    model2.selectIconName = @"home_select";
    [titleArray addObject:model2];
    TCMTabPagerConfigItemModel *model3 = [TCMTabPagerConfigItemModel new];
    model3.title = @"标题3";
    model3.normalIconName = @"hotel_unselect";
    model3.selectIconName = @"hotel_select";
    [titleArray addObject:model3];
    
    //设置标题数据
    [topView renderUIWithArray:titleArray];
    //设置选中索引
    [topView tabItemSelected:1];
    //设置选中索引时，需设置滑块移动
    UIView *maskView = topView.maskView;
    maskView.frame = CGRectMake(1*maskView.width, maskView.top, maskView.width, maskView.height);
    
    __weak typeof(TCMTabPagerView) *weakTopView = topView;
    [topView addItemClickBlock:^(NSInteger tag) {
        NSLog(@"tag==%ld",tag);
        [weakTopView tabItemSelected:tag];
        //设置滑块移动
        UIView *maskView = weakTopView.maskView;
        maskView.frame = CGRectMake(tag*maskView.width, maskView.top, maskView.width, maskView.height);
    }];
    [self.scrollView addSubview:topView];
}


-(void)buildView10 {
    TCMTabPagerView *topView = [[TCMTabPagerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 45)];
    topView.backgroundColor = [UIColor blackColor];
    
    TCMTabPagerConfigModel *pagerConfigModel = [TCMTabPagerConfigModel new];
    pagerConfigModel.topViewBgColor = @"#ffffff";
    pagerConfigModel.maskColor = @"#FFEEAE";
    pagerConfigModel.maskHeight = 2;
    pagerConfigModel.maskWidth = 80;
    pagerConfigModel.needSecondaryMask = NO;
    pagerConfigModel.secondaryMaskColor = @"#FFFFFF19";
    pagerConfigModel.secondaryMaskColorAlpha = 1.0;
    pagerConfigModel.maskPositionType = TCMViewPagerMaskPositionTypeNone;
    pagerConfigModel.type = TCMViewPagerViewTypeNoScroll;
    pagerConfigModel.itemWidth = 80;
    pagerConfigModel.itemType = TCMTabPagerItemTypeForText;
    pagerConfigModel.imageType = TCMTabPagerItemImageTypeForLocal;
    pagerConfigModel.normalTitleColor = @"#666666";
    pagerConfigModel.selectTitleColor = @"#F3AB2B";
    
    topView.pagerConfigModel = pagerConfigModel;
    
    NSMutableArray *titleArray = [NSMutableArray array];
    for (NSInteger i = 0; i<6; i++) {
        TCMTabPagerConfigItemModel *model = [TCMTabPagerConfigItemModel new];
        model.title = [NSString stringWithFormat:@"标题%ld",i];
        [titleArray addObject:model];
    }
    
    [topView renderUIWithArray:titleArray];
    
    __weak typeof(TCMTabPagerView) *weakTopView = topView;
    [topView addItemClickBlock:^(NSInteger tag) {
        NSLog(@"tag==%ld",tag);
        [weakTopView tabItemSelected:tag];
        UIView *maskView = weakTopView.maskView;
        maskView.frame = CGRectMake(tag*maskView.width, maskView.top, maskView.width, maskView.height);
    }];
    [self.view addSubview:topView];
}



-(void)dealloc {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
