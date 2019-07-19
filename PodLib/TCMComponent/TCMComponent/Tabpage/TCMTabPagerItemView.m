//
//  TCMTabPagerItemView.m
//  Pods-ComponentDemo
//
//  Created by ZZJ on 2019/7/11.
//

#import "TCMTabPagerItemView.h"
#import "YYKit.h"

static CGFloat const kIconSize = 25.f;
static CGFloat const kTitleSize = 12;
static NSString *const kNormalTitleColor = @"#666666";
static NSString *const kSelectTitleColor = @"#3d3d3d";
static NSString *const kNormalIconName = @"ic_element_tabbar_home_normal";
static NSString *const kSelectIconName = @"ic_element_tabbar_home_pressed";

@interface TCMTabPagerItemView ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) TCMTabPagerConfigItemModel *dataModel;
@property (nonatomic, copy)   TabPagerItemViewSelectCallBack selectCallBack;
@end

@implementation TCMTabPagerItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _iconView = [[UIImageView alloc] init];
        [self addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kTitleSize];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
        
    }
    return self;
}

- (void)renderUIWithDataModel:(TCMTabPagerConfigItemModel *)dataModel {
    _dataModel = dataModel;
    TCMTabPagerItemType itemType = _pagerConfigModel.itemType;
    switch (itemType) {
        case TCMTabPagerItemTypeForText:
            [self renderTextType:dataModel];
            break;
        case TCMTabPagerItemTypeForImage:
            [self renderImageType:dataModel];
            break;
        case TCMTabPagerItemTypeForTextAndImage:
            [self renderTextAndImageType:dataModel];
            break;
        default:
            break;
    }
}

- (void)settingTabSelect:(BOOL)select{
    TCMTabPagerItemType itemType = _pagerConfigModel.itemType;
    switch (itemType) {
        case TCMTabPagerItemTypeForText:
            if (select) {
                [self settingTitleColor:_pagerConfigModel.selectTitleColor];
                [self settingTitleFont:_pagerConfigModel.selectFontSize];
            }else{
                [self settingTitleColor:_pagerConfigModel.normalTitleColor];
                [self settingTitleFont:_pagerConfigModel.fontSize];
            }
            break;
        case TCMTabPagerItemTypeForImage:
            if (select) {
                [self settingIconType:_pagerConfigModel.imageType iconName:_dataModel.selectIconName selected:YES];
            }else{
                [self settingIconType:_pagerConfigModel.imageType iconName:_dataModel.normalIconName selected:NO];
            }
            break;
        case TCMTabPagerItemTypeForTextAndImage:
            if (select) {
                [self settingTitleColor:_pagerConfigModel.selectTitleColor];
                [self settingIconType:_pagerConfigModel.imageType iconName:_dataModel.selectIconName selected:YES];
            }else{
                [self settingTitleColor:_pagerConfigModel.normalTitleColor];
                [self settingIconType:_pagerConfigModel.imageType iconName:_dataModel.normalIconName selected:NO];
            }
            break;
        default:
            break;
    }
}

- (void)renderTextType:(TCMTabPagerConfigItemModel *)itemModel{
    _titleLabel.frame = self.bounds;
    _titleLabel.text = itemModel.title;
    [self settingTitleColor:_pagerConfigModel.normalTitleColor];
    [self settingTitleFont:_pagerConfigModel.fontSize];
}

- (void)renderImageType:(TCMTabPagerConfigItemModel *)itemModel{
    _iconView.frame = CGRectMake(self.width/2-kIconSize/2, self.height/2-kIconSize/2, kIconSize, kIconSize);
    [self settingIconType:_pagerConfigModel.imageType iconName:itemModel.normalIconName selected:NO];
}


- (void)renderTextAndImageType:(TCMTabPagerConfigItemModel *)itemModel{
    _iconView.frame = CGRectMake(self.width/2-kIconSize/2, 5., kIconSize, kIconSize);
    [self settingIconType:_pagerConfigModel.imageType iconName:itemModel.normalIconName selected:NO];
    
    _titleLabel.frame = CGRectMake(0, self.height-9.5-kTitleSize, self.width, kTitleSize);
    _titleLabel.text = itemModel.title;
    [self settingTitleColor:_pagerConfigModel.normalTitleColor];
}


/**
 设置图标
 */
- (void)settingIconType:(TCMTabPagerItemImageType)imageType iconName:(NSString *)iconName selected:(BOOL)selected{
    if (imageType == TCMTabPagerItemImageTypeForLocal) {
        if (!iconName || iconName.length<1) {
            _iconView.image = [UIImage imageNamed:kNormalIconName];
        }else{
            _iconView.image = [UIImage imageNamed:iconName];
        }
    }else if(imageType == TCMTabPagerItemImageTypeForUrl){
        if (iconName&&iconName.length>0) {
            [self setImageFromUrlWithIconUrl:iconName selected:selected];
        }else{
            if (selected) {
                _iconView.image = [UIImage imageNamed:@"trip_viewpager_item_selected"];
            }else{
                _iconView.image = [UIImage imageNamed:@"trip_viewpager_item_unselected"];
            }
        }
    }
}

//没有网络的情况下，需要默认图。使用placeholder会有闪动感觉
- (void)setImageFromUrlWithIconUrl: (NSString *)iconUrl selected : (BOOL)selected{
    NSURL *iconURL = [NSURL URLWithString:iconUrl];
    if (iconURL) {
        __weak typeof(self) weakSelf = self;
        
        [_iconView setImageWithURL:iconURL placeholder:nil options:0 completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            if (error) {
                if (selected) {
                    weakSelf.iconView.image = [UIImage imageNamed:@"trip_viewpager_item_selected"];
                }else{
                    weakSelf.iconView.image = [UIImage imageNamed:@"trip_viewpager_item_unselected"];
                }
            }
        }];
        
    }
}


/**
 设置文本颜色
 */
- (void)settingTitleColor:(NSString *)titleColor{
    if (!titleColor) {
        _titleLabel.textColor = [UIColor colorWithHexString:kNormalTitleColor];
    }else{
        _titleLabel.textColor = [UIColor colorWithHexString:titleColor];
    }
}

/**
设置文字大小
*/
- (void)settingTitleFont:(UIFont*)font{
    if (font) {
        _titleLabel.font = font;
    }else{
        _titleLabel.font = [UIFont systemFontOfSize:kTitleSize];
    }
}

- (void)addSelectedCallBack:(TabPagerItemViewSelectCallBack)callback{
    _selectCallBack = callback;
}

- (void)itemClicked{
    if (_selectCallBack) {
        _selectCallBack(self.tag);
    }
}


@end
