//
//  TCMButton.m
//  Pods-ComponentDemo
//
//  Created by ZZJ on 2019/7/12.
//

#import "TCMButton.h"

@implementation TCMButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat space = _spaceBetweenTitleAndImage;
    
    CGFloat titleW = CGRectGetWidth(self.titleLabel.bounds);
    CGFloat titleH = CGRectGetHeight(self.titleLabel.bounds);
    
    CGFloat imageW = CGRectGetWidth(self.imageView.bounds);
    CGFloat imageH = CGRectGetHeight(self.imageView.bounds);
    
    CGFloat btnCenterX = CGRectGetWidth(self.bounds)/2;
    CGFloat imageCenterX = btnCenterX - titleW/2;
    CGFloat titleCenterX = btnCenterX + imageW/2;
    
    switch (_imageAlignmentType)
    {
        case ADButtonImageAlignmentTypeTop:
        {
            //self.titleEdgeInsets = UIEdgeInsetsMake(imageH/2+ space/2, -(titleCenterX-btnCenterX), -(imageH/2 + space/2), titleCenterX-btnCenterX);
            //self.imageEdgeInsets = UIEdgeInsetsMake(-(titleH/2 + space/2), btnCenterX-imageCenterX, titleH/2+ space/2, -(btnCenterX-imageCenterX));
            // image center
            CGPoint center;
            center.x = self.frame.size.width/2;
            center.y = self.imageView.frame.size.height/2 + (self.frame.size.height - self.imageView.frame.size.height - self.titleLabel.frame.size.height - space)/2;
            self.imageView.center = center;
            
            //text
            CGRect newFrame = [self titleLabel].frame;
            newFrame.origin.x = 0;
            newFrame.origin.y = CGRectGetMaxY(self.imageView.frame) + space;
            newFrame.size.width = self.frame.size.width;
            
            self.titleLabel.frame = newFrame;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        case ADButtonImageAlignmentTypeBottom:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageH/2+ space/2), -(titleCenterX-btnCenterX), imageH/2 + space/2, titleCenterX-btnCenterX);
            self.imageEdgeInsets = UIEdgeInsetsMake(titleH/2 + space/2, btnCenterX-imageCenterX,-(titleH/2+ space/2), -(btnCenterX-imageCenterX));
        }
            break;
        case ADButtonImageAlignmentTypeRight:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageW + space/2), 0, imageW + space/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW+space/2, 0, -(titleW+space/2));
        }
            break;
            
        default:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2, 0,  -space/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space);
        }
            break;
    }
}


@end
