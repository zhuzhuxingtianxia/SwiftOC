//
//  TabPageSubController.m
//  ComponentDemo
//
//  Created by ZZJ on 2019/7/12.
//  Copyright © 2019 Jion. All rights reserved.
//

#import "TabPageSubController.h"
#import <YYKit.h>
#import "PagerSubCell0.h"
#import "PagerSubCell1.h"

static NSString *const kCellid0 = @"kCellid0";
static NSString *const kCellid1 = @"kCellid1";

@interface TabPageSubController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TabPageSubController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

#pragma mark -- UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.pageIndex%2 == 0) {
        return 20;
    }else{
        return 40;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    if (self.pageIndex%2 == 0){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellid0 forIndexPath:indexPath];
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellid1 forIndexPath:indexPath];
    }
    
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.pageIndex%2 == 0) {
        return CGSizeMake(self.view.width,120);
    }else{
        CGFloat width = self.view.width/2-12;
        return CGSizeMake(width,width+32);
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.;
}

#pragma mark -- getter
-(UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[PagerSubCell0 class] forCellWithReuseIdentifier:kCellid0];
        [_collectionView registerClass:[PagerSubCell1 class] forCellWithReuseIdentifier:kCellid1];
    }
    
    return _collectionView;
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
