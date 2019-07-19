//
//  TabPageExampleController.m
//  ComponentDemo
//
//  Created by ZZJ on 2019/7/12.
//  Copyright © 2019 Jion. All rights reserved.
//

#import "TabPageExampleController.h"
#import <TCMComponent.h>
#import <YYKit.h>
#import "TabPageSubController.h"

@interface TabPageExampleController ()<UIScrollViewDelegate>
{
    NSInteger _currentIndex;
}
@property (nonatomic,strong)TCMTabPagerView *tabpage;
@property (nonatomic, strong)UIScrollView *contentScroller;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation TabPageExampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"TabPage实例";
    
    [self buildView];
}

-(void)buildView {
    
    [self.view addSubview:self.tabpage];
    NSArray *normalIcons = @[@"car_unselect",@"flight_unselect",@"home_unselect",@"hotel_unselect",@"fun_unselect",@"ticket_unselect",@"transfer_unselect",@"visa_unselect",@"wifi_unselect",@"car_unselect"];
    NSArray *selectIcons = @[@"car_select",@"flight_select",@"home_select",@"hotel_select",@"fun_select",@"ticket_select",@"transfer_select",@"visa_select",@"wifi_select",@"car_select"];
    
    _dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i<selectIcons.count; i++) {
        TCMTabPagerConfigItemModel *model = [TCMTabPagerConfigItemModel new];
        model.title = [NSString stringWithFormat:@"标题%ld",i];
        model.normalIconName = normalIcons[i];
        model.selectIconName = selectIcons[i];
        [_dataArray addObject:model];
    }
    //设置标题数据
    [self.tabpage renderUIWithArray:_dataArray];
    
    _contentScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _tabpage.bottom, self.view.width, self.view.height-_tabpage.bottom)];
    _contentScroller.backgroundColor = [UIColor orangeColor];
    _contentScroller.pagingEnabled = YES;
    _contentScroller.delegate = self;
    _contentScroller.bounces = NO;
    _contentScroller.showsHorizontalScrollIndicator = NO;
    _contentScroller.contentSize = CGSizeMake(_contentScroller.width*_dataArray.count, _contentScroller.height);
    [self.view addSubview:_contentScroller];
    
    [self loadSubViewController:0];
}

- (void)loadSubViewController:(NSInteger)index {
    _currentIndex = index;
    [_contentScroller setContentOffset:CGPointMake(index*_contentScroller.width, 0) animated:YES];
    [_tabpage tabItemSelected:index];
    
    TCMTabPagerConfigItemModel *viewModel = _dataArray[index];
    if (!viewModel.vcInstance) {
        TabPageSubController *vc = [TabPageSubController new];
        vc.view.frame = CGRectMake(index*_contentScroller.width, 0, _contentScroller.width, _contentScroller.height);
        vc.pageIndex = index;
        [_contentScroller addSubview:vc.view];
        viewModel.vcInstance = vc;
        [self addChildViewController:vc];
    }else{
        TabPageSubController *vc = (TabPageSubController*)viewModel.vcInstance;
        vc.pageIndex = index;
    }
}

#pragma mark -- UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //滚动停止的时候才设置item被选中
    CGFloat positionPage = scrollView.contentOffset.x/scrollView.width;
    if (((int)(positionPage*1000))%1000<1) {
        int page = (int)positionPage;//当前滑动到的page
        if (_currentIndex != page) {
            _currentIndex = page;
            [self loadSubViewController:_currentIndex];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //2、TCMViewPagerViewTypeNoScroll模式下面 对于maskView的处理
    CGFloat rate = scrollView.contentOffset.x/scrollView.contentSize.width;
    CGFloat tabWidth = _tabpage.tabScroller.contentSize.width;
    CGFloat itemWidth = _tabpage.maskView.width;
    UIView *maskView = _tabpage.maskView;
    TCMViewPagerViewType type = _tabpage.pagerConfigModel.type;
    if (type == TCMViewPagerViewTypeNoScroll) {
        maskView.frame = CGRectMake(rate*self.view.width, maskView.top, maskView.width, maskView.height);
    }else if(type == TCMViewPagerViewTypeCanScroll){
        CGFloat centerX = tabWidth*rate+itemWidth/2;
        if (centerX>self.view.width/2 && centerX<tabWidth-self.view.width/2) {
            _tabpage.tabScroller.contentOffset = CGPointMake(centerX-self.view.width/2, 0);
            maskView.frame = CGRectMake(self.view.width/2-itemWidth/2, maskView.top, maskView.width, maskView.height);
        }
        
        if (centerX <= self.view.width/2) {
            _tabpage.tabScroller.contentOffset = CGPointMake(0, 0);
            maskView.frame = CGRectMake(tabWidth*rate, maskView.top, maskView.width, maskView.height);
        }
        
        if (centerX >= tabWidth-self.view.width/2) {
            _tabpage.tabScroller.contentOffset = CGPointMake(tabWidth-self.view.width, 0);
            maskView.frame = CGRectMake(self.view.width/2+tabWidth*rate-(tabWidth-self.view.width/2), maskView.top, maskView.width, maskView.height);
        }
    }
}


#pragma mark -- getter

-(TCMTabPagerView*)tabpage{
    if (!_tabpage) {
        TCMTabPagerView *topView = [[TCMTabPagerView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 55)];
        topView.backgroundColor = [UIColor blackColor];
        
        TCMTabPagerConfigModel *pagerConfigModel = [TCMTabPagerConfigModel new];
        //item类型：r图片+文字
        pagerConfigModel.itemType = TCMTabPagerItemTypeForTextAndImage;
        //文字设置
        pagerConfigModel.normalTitleColor = @"#ffffff";
        pagerConfigModel.selectTitleColor = @"#FFC900";
        pagerConfigModel.fontSize = [UIFont systemFontOfSize:13];
        pagerConfigModel.selectFontSize = [UIFont boldSystemFontOfSize:14];
        //设置滑动
        pagerConfigModel.itemWidth = 80;
        pagerConfigModel.type = TCMViewPagerViewTypeCanScroll;
        //设置底部滑动条
        pagerConfigModel.maskColor = @"#FFC900";
        pagerConfigModel.maskWidth = 10;
        pagerConfigModel.maskHeight = 2;
        pagerConfigModel.maskPositionType = TCMViewPagerMaskPositionTypeBottom;
        
        //设置配置
        topView.pagerConfigModel = pagerConfigModel;
        
        __weak typeof(self) weakSelf = self;
        [topView addItemClickBlock:^(NSInteger tag) {
            NSLog(@"tag==%ld",tag);
            [weakSelf loadSubViewController:tag];
        }];
        //设置默认选中第一个
//        [self loadSubViewController:1];
        
        _tabpage = topView;
    }
    return _tabpage;
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
