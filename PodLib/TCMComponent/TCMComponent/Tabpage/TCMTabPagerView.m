//
//  TCMTabPagerView.m
//  Pods-ComponentDemo
//
//  Created by ZZJ on 2019/7/11.
//

#import "TCMTabPagerView.h"
#import "YYKit.h"

@interface TCMTabPagerView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *tabViews;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) TCMViewPagerViewScrollViewBlock scrollViewBlock;
@property (nonatomic, copy) TCMViewPagerViewItemClickBlock itemClickBlock;
/** maskView显示颜色的Layer */
@property (nonatomic, strong) CALayer *maskLayer;
/** maskView显示颜色的Layer2 */
@property (nonatomic, strong) CALayer *secondaryMaskLayer;

@end

@implementation TCMTabPagerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initMaskView];
        [self initTabScroller];
    }
    return self;
}

- (void)initMaskView{
    
    _maskView = [[UIView alloc] initWithFrame:CGRectZero];
    _maskView.backgroundColor = [UIColor clearColor];
    _secondaryMaskLayer = [CALayer layer];
    _secondaryMaskLayer.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF19"].CGColor;
    [_maskView.layer addSublayer:_secondaryMaskLayer];
    _maskLayer = [CALayer layer];
    _maskLayer.backgroundColor = [UIColor colorWithHexString:@"#FFEEAE"].CGColor;
    [_maskView.layer addSublayer:_maskLayer];
    [self addSubview:_maskView];
    
    _pagerConfigModel = [[TCMTabPagerConfigModel alloc] init];
    
}

- (void)initTabScroller{
    _tabScroller = [[UIScrollView alloc] initWithFrame:self.bounds];
    _tabScroller.showsHorizontalScrollIndicator = NO;
    _tabScroller.backgroundColor = [UIColor clearColor];
    _tabScroller.bounces = YES;
    _tabScroller.delegate = self;
    [self addSubview:_tabScroller];
}

-(void)setPagerConfigModel:(TCMTabPagerConfigModel *)pagerConfigModel{
    
    if (pagerConfigModel.maskColor) {
        _pagerConfigModel.maskColor = pagerConfigModel.maskColor;
        _maskLayer.backgroundColor = [UIColor colorWithHexString:pagerConfigModel.maskColor].CGColor;
    }
    if (self.pagerConfigModel.maskHeight != pagerConfigModel.maskHeight) {
        _pagerConfigModel.maskHeight = pagerConfigModel.maskHeight;
    }
    if (self.pagerConfigModel.maskWidth != pagerConfigModel.maskWidth) {
        _pagerConfigModel.maskWidth = pagerConfigModel.maskWidth;
    }
    if (self.pagerConfigModel.needSecondaryMask != pagerConfigModel.needSecondaryMask) {
        _pagerConfigModel.needSecondaryMask = pagerConfigModel.needSecondaryMask;
    }
    if (pagerConfigModel.secondaryMaskColor) {
        _pagerConfigModel.secondaryMaskColor = pagerConfigModel.secondaryMaskColor;
    }
    if (self.pagerConfigModel.secondaryMaskColorAlpha !=pagerConfigModel.secondaryMaskColorAlpha) {
        _pagerConfigModel.secondaryMaskColorAlpha = pagerConfigModel.secondaryMaskColorAlpha;
    }
    if (self.pagerConfigModel.maskPositionType !=pagerConfigModel.maskPositionType) {
        _pagerConfigModel.maskPositionType = pagerConfigModel.maskPositionType;
    }
    if (self.pagerConfigModel.type !=pagerConfigModel.type) {
        _pagerConfigModel.type = pagerConfigModel.type;
    }
    if (self.pagerConfigModel.itemWidth !=pagerConfigModel.itemWidth) {
        _pagerConfigModel.itemWidth = pagerConfigModel.itemWidth;
    }
    if (self.pagerConfigModel.itemType !=pagerConfigModel.itemType) {
        _pagerConfigModel.itemType = pagerConfigModel.itemType;
    }
    if (self.pagerConfigModel.imageType !=pagerConfigModel.imageType) {
        _pagerConfigModel.imageType = pagerConfigModel.imageType;
    }
    if (pagerConfigModel.normalTitleColor) {
        _pagerConfigModel.normalTitleColor = pagerConfigModel.normalTitleColor;
    }
    if (pagerConfigModel.selectTitleColor) {
        _pagerConfigModel.selectTitleColor = pagerConfigModel.selectTitleColor;
    }
    if (self.pagerConfigModel.fontSize.pointSize != pagerConfigModel.fontSize.pointSize) {
        _pagerConfigModel.fontSize = pagerConfigModel.fontSize;
    }
    if (self.pagerConfigModel.selectFontSize.pointSize != pagerConfigModel.selectFontSize.pointSize) {
        _pagerConfigModel.selectFontSize = pagerConfigModel.selectFontSize;
    }
    
}


- (void)renderUIWithArray:(NSArray<TCMTabPagerConfigItemModel*> *)dataArray{
    if (dataArray==nil || dataArray.count<1) return;
    
    CGFloat offsetX = 0;
    [self handleItemWidthWithItemCount:dataArray.count];
    _maskView.frame = CGRectMake(0, 0, self.pagerConfigModel.itemWidth, self.height);
    if (self.pagerConfigModel.needSecondaryMask) {
        _secondaryMaskLayer.frame = _maskView.bounds;
        
        UIColor *secondaryMaskClor = [UIColor colorWithHexString:self.pagerConfigModel.secondaryMaskColor];
        _secondaryMaskLayer.backgroundColor = [secondaryMaskClor colorWithAlphaComponent:self.pagerConfigModel.secondaryMaskColorAlpha].CGColor;
    }else{
        [_secondaryMaskLayer removeFromSuperlayer];
    }
    
    if (self.pagerConfigModel.maskWidth>1) {
        if (self.pagerConfigModel.maskPositionType == TCMViewPagerMaskPositionTypeNone) {
            _maskLayer.frame = CGRectMake(_maskView.width/2-self.pagerConfigModel.maskWidth/2, 0, self.pagerConfigModel.maskWidth, _maskView.height);
        }else if(self.pagerConfigModel.maskPositionType == TCMViewPagerMaskPositionTypeTop) {
            _maskLayer.frame = CGRectMake(0, 0, self.pagerConfigModel.itemWidth, self.pagerConfigModel.maskHeight);
        }else if(self.pagerConfigModel.maskPositionType == TCMViewPagerMaskPositionTypeBottom) {
            _maskLayer.frame = CGRectMake(0, self.height-self.pagerConfigModel.maskHeight, self.pagerConfigModel.itemWidth, self.pagerConfigModel.maskHeight);
        }
    }
    _tabViews = [[NSMutableArray alloc] init];
    for (int i=0; i<dataArray.count; i++) {
        TCMTabPagerConfigItemModel *model = dataArray[i];
        TCMTabPagerItemView *itemView = [[TCMTabPagerItemView alloc] initWithFrame:CGRectMake(offsetX, 0, self.pagerConfigModel.itemWidth, self.height)];
        itemView.pagerConfigModel = self.pagerConfigModel;
        [itemView renderUIWithDataModel:model];
        itemView.tag = i;
        [_tabScroller addSubview:itemView];
        offsetX += self.pagerConfigModel.itemWidth;
        
        [_tabViews addObject:itemView];
        
        __weak typeof(self) weakSelf = self;
        [itemView addSelectedCallBack:^(NSInteger tag) {
            if (weakSelf.itemClickBlock) {
                weakSelf.itemClickBlock(tag);
            }
        }];
    }
    _tabScroller.contentSize = CGSizeMake(dataArray.count*self.pagerConfigModel.itemWidth, self.height);
    if (dataArray.count) {
         [self tabItemSelected:0];
    }
}

- (void)handleItemWidthWithItemCount:(NSInteger)count{
    if (self.pagerConfigModel.type == TCMViewPagerViewTypeNoScroll) {
        self.pagerConfigModel.itemWidth = self.width/count;
    }else if(self.pagerConfigModel.type == TCMViewPagerViewTypeCanScroll){
        if (self.pagerConfigModel.itemWidth<1) {//如果在canScroll的模式下面,没有设置itemWidth，默认和noScroll一样处理
            self.pagerConfigModel.itemWidth = self.width/count;
        }
    }
}

- (void)tabItemSelected:(NSInteger)index{
    _currentIndex = index;
    for (int i=0; i<_tabViews.count; i++) {
        TCMTabPagerItemView *tabView = _tabViews[i];
        if (i == index) {
            [tabView settingTabSelect:YES];
        }else{
            [tabView settingTabSelect:NO];
        }
    }
}

- (void)addScrollViewBlock:(TCMViewPagerViewScrollViewBlock)block{
    _scrollViewBlock = block;
}

- (void)addItemClickBlock : (TCMViewPagerViewItemClickBlock) block{
    _itemClickBlock = block;
}

#pragma mark -- UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat itemWidth = self.pagerConfigModel.itemWidth;
    CGFloat offsetX = scrollView.contentOffset.x;
    _maskView.frame = CGRectMake(_currentIndex*itemWidth-offsetX, _maskView.top, _maskView.width, _maskView.height);
    if (_scrollViewBlock) {
        _scrollViewBlock(scrollView);
    }
}

#pragma mark -- getter

-(TCMTabPagerConfigModel*)setNoalPagerConfigModel {
    //设置默认值
    if (!_pagerConfigModel) {
       TCMTabPagerConfigModel *pagerConfigModel = [TCMTabPagerConfigModel new];
        pagerConfigModel.topViewBgColor = @"#ffffff";
        pagerConfigModel.maskColor = @"#FFEEAE";
        pagerConfigModel.maskHeight = 2;
        pagerConfigModel.maskWidth = 80;
        pagerConfigModel.needSecondaryMask = NO;
        pagerConfigModel.secondaryMaskColor = @"#FFFFFF";
        pagerConfigModel.secondaryMaskColorAlpha = 0.0;
        pagerConfigModel.maskPositionType = TCMViewPagerMaskPositionTypeNone;
        pagerConfigModel.type = TCMViewPagerViewTypeNoScroll;
        pagerConfigModel.itemWidth = 80;
        pagerConfigModel.itemType = TCMTabPagerItemTypeForText;
        pagerConfigModel.imageType = TCMTabPagerItemImageTypeForLocal;
        pagerConfigModel.normalTitleColor = @"#666666";
        pagerConfigModel.selectTitleColor = @"#F3AB2B";
        _pagerConfigModel = pagerConfigModel;
    }
    return _pagerConfigModel;
}

@end
