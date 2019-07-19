//
//  TCMBannerView.m
//  Pods-ComponentDemo
//
//  Created by ZZJ on 2019/7/11.
//

#import "TCMBannerView.h"
#import "UIImageView+YYWebImage.h"

@interface TCMBannerView ()<UIScrollViewDelegate>
/** 页码指示器 */
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UIImageView *leftIV;
@property (nonatomic,strong) UIImageView *centerIV;
@property (nonatomic,strong) UIImageView *rightIV;
@property (nonatomic,assign) NSUInteger currentImageIndex;
@property (nonatomic,assign) CGFloat imgWidth;//图片宽度
@property (nonatomic,assign) CGFloat itemMargnPadding;//间距 2张图片间的间距  默认0
@property (nonatomic,assign) NSInteger imgCount;//数量
@property (nonatomic,weak) NSTimer *timer;

@end

#define ZXMainScrollViewWidth self.mainScrollView.frame.size.width
#define ZXMainScrollViewHeight self.mainScrollView.frame.size.height

@implementation TCMBannerView

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgWidth = ZXMainScrollViewWidth;
        [self initialization];
        [self setUpUI];
    }
    return self;
}
+(instancetype)initWithFrame:(CGRect)frame
                imageSpacing:(CGFloat)imageSpacing
                  imageWidth:(CGFloat)imageWidth {
    TCMBannerView *scrollView = [[self alloc] initWithFrame:frame];
    scrollView.imgWidth = imageWidth;
    scrollView.itemMargnPadding = imageSpacing;
    return scrollView;
}
+(instancetype)initWithFrame:(CGRect)frame
                imageSpacing:(CGFloat)imageSpacing
                  imageWidth:(CGFloat)imageWidth
                        data:(NSArray *)data{
    TCMBannerView *scrollView = [[self alloc] initWithFrame:frame];
    scrollView.imgWidth = imageWidth;
    scrollView.itemMargnPadding = imageSpacing;
    scrollView.data = data;
    return scrollView;
}

-(void)initialization{
    _initAlpha = 1;
    _autoScrollTime = 2.0;
    _imageHeightPoor = 0;
    self.pageIndicatorTintColor = [UIColor grayColor];
    self.currentPageIndicatorTintColor = [UIColor whiteColor];
    _showPageControl = YES;
    _hidesForSinglePage = YES;
    _autoScroll = YES;
    self.data = [NSArray array];
}

-(void)setUpUI{
    [self addSubview:self.mainScrollView];
    //图片视图；左边
    self.leftIV = [[UIImageView alloc] init];
    self.leftIV.contentMode = UIViewContentModeScaleToFill;
    self.leftIV.userInteractionEnabled = YES;
    [self.leftIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapGes)]];
    [self.mainScrollView addSubview:self.leftIV];
    
    //图片视图；中间
    self.centerIV = [[UIImageView alloc] init];
    self.centerIV.contentMode = UIViewContentModeScaleToFill;
    self.centerIV.userInteractionEnabled = YES;
    [self.centerIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerTapGes)]];
    [self.mainScrollView addSubview:self.centerIV];
    
    //图片视图；右边
    self.rightIV = [[UIImageView alloc] init];
    self.rightIV.contentMode = UIViewContentModeScaleToFill;
    self.rightIV.userInteractionEnabled = YES;
    [self.rightIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapGes)]];
    [self.mainScrollView addSubview:self.rightIV];
    
    [self updateViewFrameSetting];
}
- (void)setImageHeightPoor:(CGFloat)imageHeightPoor {
    _imageHeightPoor = imageHeightPoor;
    [self updateViewFrameSetting];
}

//创建页码指示器
-(void)createPageControl{
    if (_pageControl) [_pageControl removeFromSuperview];
    if (self.data.count == 0) return;
    if ((self.data.count == 1) && self.hidesForSinglePage) return;
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width - 200)/2, ZXMainScrollViewHeight - 30, 200, 30)];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = self.data.count;
    [self addSubview:_pageControl];
    _pageControl.pageIndicatorTintColor = self.pageIndicatorTintColor;
    _pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
    
    _pageControl.hidden = !_showPageControl;
}

#pragma mark - 设置初始尺寸
-(void)updateViewFrameSetting{
    //设置偏移量
    self.mainScrollView.contentSize = CGSizeMake(ZXMainScrollViewWidth * 3, ZXMainScrollViewHeight);
    self.mainScrollView.contentOffset = CGPointMake(ZXMainScrollViewWidth, 0.0);
    //图片视图；左边
    self.leftIV.frame = CGRectMake(self.itemMargnPadding/2, self.imageHeightPoor, self.imgWidth, ZXMainScrollViewHeight-self.imageHeightPoor*2);
    //图片视图；中间
    self.centerIV.frame = CGRectMake(ZXMainScrollViewWidth + self.itemMargnPadding/2, 0.0, self.imgWidth, ZXMainScrollViewHeight);
    //图片视图；右边
    self.rightIV.frame = CGRectMake(ZXMainScrollViewWidth * 2.0 + self.itemMargnPadding/2, self.imageHeightPoor, self.imgWidth, ZXMainScrollViewHeight-self.imageHeightPoor*2);
    
}
- (void)setImageRadius:(CGFloat)imageRadius {
    _imageRadius = imageRadius;
    self.leftIV.layer.cornerRadius = imageRadius;
    self.leftIV.layer.masksToBounds = YES;
    
    self.centerIV.layer.cornerRadius = imageRadius;
    self.centerIV.layer.masksToBounds = YES;
    
    self.rightIV.layer.cornerRadius = imageRadius;
    self.rightIV.layer.masksToBounds = YES;

    [self addShadowWithView:self.leftIV byOpacity:0.4];
    [self addShadowWithView:self.centerIV byOpacity:0.4];
    [self addShadowWithView:self.rightIV byOpacity:0.4];
    
}
- (void)setData:(NSArray *)data {
    if (data.count < _data.count) {
        [_mainScrollView setContentOffset:CGPointMake(ZXMainScrollViewWidth, 0) animated:NO];
    }
    _data = data;
    self.currentImageIndex = 0;
    self.imgCount = data.count;
    self.pageControl.numberOfPages = self.imgCount;
    [self setInfoByCurrentImageIndex:self.currentImageIndex];
    
    if (data.count != 1) {
        self.mainScrollView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        [self invalidateTimer];
        // ZXMainScrollViewWidth < self.frame.size.width    这样的 说明是 图片有间距 卡片 翻页效果那种布局
        self.mainScrollView.scrollEnabled = ZXMainScrollViewWidth < self.frame.size.width ?YES : NO;
    }
    
    [self createPageControl];
}

- (void)setInfoByCurrentImageIndex:(NSUInteger)currentImageIndex {
    if(self.imgCount == 0){
        return;
    }
    if([self isHttpString:self.data[currentImageIndex]]){
        [self.centerIV setImageWithURL:[NSURL URLWithString:self.data[currentImageIndex]] placeholder:self.placeHolderImage];
        
    }else {
        self.centerIV.image = self.data[currentImageIndex];
    }
    
    NSInteger leftIndex = (unsigned long)((_currentImageIndex - 1 + self.imgCount) % self.imgCount);
    if([self isHttpString:self.data[leftIndex]]){
        [self.leftIV setImageWithURL:[NSURL URLWithString:self.data[leftIndex]] placeholder:self.placeHolderImage];
    }else {
        self.leftIV.image = self.data[leftIndex];
    }
    
    NSInteger rightIndex = (unsigned long)((_currentImageIndex + 1) % self.imgCount);
    if([self isHttpString:self.data[rightIndex]]){
        [self.rightIV setImageWithURL:[NSURL URLWithString:self.data[rightIndex]] placeholder:self.placeHolderImage];
    }else {
        self.rightIV.image = self.data[rightIndex];
    }
    
    _pageControl.currentPage = currentImageIndex;
}

- (void)reloadImage {
    //~~ 避免0
    if(self.imgCount == 0) {
        return;
    }
    CGPoint contentOffset = [self.mainScrollView contentOffset];
    if (contentOffset.x > ZXMainScrollViewWidth) { //向左滑动
        _currentImageIndex = (_currentImageIndex + 1) % self.imgCount;
    } else if (contentOffset.x < ZXMainScrollViewWidth) { //向右滑动
        _currentImageIndex = (_currentImageIndex - 1 + self.imgCount) % self.imgCount;
    }
    
    [self setInfoByCurrentImageIndex:_currentImageIndex];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadImage];
    [self.mainScrollView setContentOffset:CGPointMake(ZXMainScrollViewWidth, 0) animated:NO] ;
    self.pageControl.currentPage = self.currentImageIndex;
    if ([self.delegate respondsToSelector:@selector(bannerView:clickedOnIndex:image:)]) {
        UIImage *img = self.centerIV.image;
        [self.delegate bannerView:self clickedOnIndex:self.currentImageIndex image:img];
    }else{
        if (self.clickImageBlock) {
            self.clickImageBlock(self.currentImageIndex);
        }
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self createTimer];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}


#pragma mark -- action
-(void)leftTapGes{
    
}

-(void)rightTapGes{
    
}

-(void)centerTapGes{
    
}

-(void)createTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTime target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer {
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)automaticScroll {
    if (0 == _imgCount) return;
    if(self.mainScrollView.scrollEnabled == NO) return;
    [self.mainScrollView setContentOffset:CGPointMake(ZXMainScrollViewWidth*2, 0.0) animated:YES];
}

#pragma mark -- properties
-(void)setItemMargnPadding:(CGFloat)itemMargnPadding {
    _itemMargnPadding = itemMargnPadding;
    self.mainScrollView.frame = CGRectMake((ZXMainScrollViewWidth - (self.imgWidth + itemMargnPadding))/2, 0, self.imgWidth + itemMargnPadding, ZXMainScrollViewHeight);
    [self updateViewFrameSetting];
}

-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setAutoScrollTime:(CGFloat)autoScrollTime {
    _autoScrollTime = autoScrollTime;
    
    [self setAutoScroll:self.autoScroll];
}

-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    
    if (_autoScroll) {
        [self createTimer];
    }
}

-(void)setPlaceHolderImage:(UIImage *)placeHolderImage {
    _placeHolderImage = placeHolderImage;
    self.centerIV.image = placeHolderImage;
    self.leftIV.image = placeHolderImage;
    self.rightIV.image = placeHolderImage;
}

-(void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl = showPageControl;
    self.pageControl.hidden = !_showPageControl;
}

- (void)setInitAlpha:(CGFloat)initAlpha {
    _initAlpha = initAlpha;
    self.leftIV.alpha = self.initAlpha;
    self.centerIV.alpha = 1;
    self.rightIV.alpha = self.initAlpha;
}

-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.clipsToBounds = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _mainScrollView;
}

-(BOOL)isHttpString:(NSString *)urlStr {
    if([urlStr hasPrefix:@"http:"] || [urlStr hasPrefix:@"https:"]){
        return YES;
    }else {
        return NO;
    }
}
#pragma mark - life circles
//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self invalidateTimer];
    }
}
//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _mainScrollView.delegate = nil;
    [self invalidateTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.itemMargnPadding > 0) {
        CGFloat currentX = scrollView.contentOffset.x - ZXMainScrollViewWidth;
        CGFloat bl = currentX/ZXMainScrollViewWidth*(1-self.initAlpha);
        CGFloat variableH = currentX/ZXMainScrollViewWidth*self.imageHeightPoor*2;
        if (currentX > 0) { //左滑
            self.centerIV.alpha = 1 - bl;
            self.rightIV.alpha = self.initAlpha + bl;
            
            CGRect centerIVframe = self.centerIV.frame;
            centerIVframe.size.height = ZXMainScrollViewHeight - variableH;
            centerIVframe.origin.y = currentX/ZXMainScrollViewWidth*self.imageHeightPoor;
            self.centerIV.frame = centerIVframe;
            
            CGRect rightIVframe = self.rightIV.frame;
            rightIVframe.size.height = ZXMainScrollViewHeight-2*self.imageHeightPoor+variableH;
            rightIVframe.origin.y = self.imageHeightPoor-currentX/ZXMainScrollViewWidth*self.imageHeightPoor;
            self.rightIV.frame = rightIVframe;
            
        } else if (currentX < 0){  // 右滑
            self.centerIV.alpha = 1 + bl;
            self.leftIV.alpha = self.initAlpha - bl;
            
            CGRect centerIVframe = self.centerIV.frame;
            centerIVframe.size.height = ZXMainScrollViewHeight + variableH;
            centerIVframe.origin.y = -currentX/ZXMainScrollViewWidth*self.imageHeightPoor;
            self.centerIV.frame = centerIVframe;
            
            CGRect leftIVframe = self.leftIV.frame;
            leftIVframe.size.height = ZXMainScrollViewHeight-2*self.imageHeightPoor-variableH;
            leftIVframe.origin.y = self.imageHeightPoor+currentX/ZXMainScrollViewWidth*self.imageHeightPoor;
            self.leftIV.frame = leftIVframe;
            
        } else {
            self.leftIV.alpha = self.initAlpha;
            self.centerIV.alpha = 1;
            self.rightIV.alpha = self.initAlpha;
            
            CGRect leftIVframe = self.leftIV.frame;
            leftIVframe.size.height = ZXMainScrollViewHeight-2*self.imageHeightPoor;
            leftIVframe.origin.y = self.imageHeightPoor;
            self.leftIV.frame = leftIVframe;
            
            CGRect centerIVframe = self.centerIV.frame;
            centerIVframe.size.height = ZXMainScrollViewHeight;
            centerIVframe.origin.y = 0;
            self.centerIV.frame = centerIVframe;
            
            CGRect rightIVframe = self.rightIV.frame;
            rightIVframe.size.height = ZXMainScrollViewHeight-2*self.imageHeightPoor;
            rightIVframe.origin.y = self.imageHeightPoor;
            self.rightIV.frame = rightIVframe;
            
        }
    }
}

#pragma mark - 快速添加阴影
- (void)addShadowWithView:(UIView*)view byOpacity:(CGFloat)shadowOpacity {
    view.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移2，y向下偏移6，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOpacity = shadowOpacity;//阴影透明度，默认0
    view.layer.shadowRadius = 3;//阴影半径，默认3
}


@end
