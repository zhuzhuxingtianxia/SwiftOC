//
//  TCMRunLabel.m
//  Pods-ComponentDemo
//
//  Created by ZZJ on 2019/7/12.
//

#import "TCMRunLabel.h"
static NSString *const kSpacing = @"          ";

@interface TCMRunLabel ()
@property (nonatomic) CGRect myRect;
@property (nonatomic,copy) NSString *myText;
@property (nonatomic,strong) CADisplayLink *dl;
@end

@implementation TCMRunLabel
-(void)awakeFromNib{
    [super awakeFromNib];
    if (self.text.length) {
        self.text = self.text;
    }
}


-(void)didMoveToWindow{
    [super didMoveToWindow];
    self.clipsToBounds = YES;
    
    self.myRect = CGRectMake(0, 0, [self singleLineStr:self.myText withFont:self.font].width,self.bounds.size.height);
}

-(void)drawTextInRect:(CGRect)rect{
    if ([self singleLineStr:self.myText withFont:self.font].width > self.bounds.size.width) {
        [super drawTextInRect:self.myRect];
    }else{
        [super drawTextInRect:rect];
    }
}

-(void)setText:(NSString *)text{
    //    NSLog(@"Text:%@  MyText:%@\n",text,self.myText);
    if(self.myText.length == 0 || (![text isEqualToString:[NSString stringWithFormat:@"%@%@%@",self.myText.length?self.myText:@"",kSpacing,self.myText.length?self.myText:@""]] && ![text isEqualToString:self.myText])) {
        self.myText = text;
        if ([self singleLineStr:self.myText withFont:self.font].width > self.bounds.size.width) {
            [self dl];
        }else{
            [_dl invalidate];
            _dl = nil;
        }
    }
    
    if (self.myText.length > 0 && [self singleLineStr:self.myText withFont:self.font].width <= self.bounds.size.width) {
        [super setText:self.myText];
    }else{
        [super setText:text];
    }
}

-(void)updateFrame:(CADisplayLink*)timer{
    //    NSLog(@"L:%ld\n",self.text.length);
    if ([self isDisplayedInScreen]) {
        self.myRect = CGRectMake(self.myRect.origin.x-.5, 0, [self singleLineStr:self.text withFont:self.font].width, self.bounds.size.height);
        [self setNeedsDisplay];
        
    }else{
        [timer invalidate];
        timer = nil;
    }
}

-(void)setMyRect:(CGRect)myRect{
    _myRect = myRect;
    //    NSLog(@"X:%f Width:%f\n",myRect.origin.x,myRect.size.width);
    if (myRect.origin.x <= self.bounds.size.width-[self singleLineStr:self.myText withFont:self.font].width) {
        self.text = [NSString stringWithFormat:@"%@%@%@",self.myText.length?self.myText:@"",kSpacing,self.myText.length?self.myText:@""];
        _myRect = CGRectMake(myRect.origin.x, myRect.origin.y, [self singleLineStr:self.text withFont:self.font].width, self.bounds.size.height);
    }
    
    if (myRect.origin.x <= -([self singleLineStr:self.myText withFont:self.font].width+[self singleLineStr:kSpacing withFont:self.font].width)) {
        _myRect = CGRectMake(0, 0, [self singleLineStr:self.myText withFont:self.font].width, self.bounds.size.height);
        self.text = self.myText;
        [_dl invalidate];
        _dl = nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dl];
        });
    }
}

-(CADisplayLink *)dl{
    if (!_dl) {
        _dl = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateFrame:)];
        [_dl addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _dl;
}


- (BOOL)isDisplayedInScreen{
    if (self == nil) {
        return FALSE;
    }
    if (self.hidden) {// 若view 隐藏
        return FALSE;
    }
    if (self.superview == nil) {// 若没有superview
        return FALSE;
    }
    CGRect rect = [self convertRect:self.frame fromView:self.superview];// 转换view对应window的Rect
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {// 若size为CGrectZero
        return  FALSE;
    }
    CGRect intersectionRect = CGRectIntersection(rect, [UIScreen mainScreen].bounds);// 获取 该view与window 交叉的 Rect
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    return TRUE;
}


-(CGSize)singleLineStr:(NSString*)str withFont:(UIFont*)font{
    return [str sizeWithAttributes:@{NSFontAttributeName:font}];
}

-(void)dealloc{
    NSLog(@"我走了，不要想我。。。\n");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
