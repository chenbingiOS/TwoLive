//
//  CBGuideView.m
//  FwApp
//
//  Created by hxbjt on 2018/9/7.
//  Copyright © 2018年 chenbing. All rights reserved.
//

#import "CBGuideView.h"
#import "CBGuideViewCell.h"

@interface CBGuideView() <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *view;       ///< 容器
@property (nonatomic, strong) NSArray *images;              ///< 图片数组
@property (nonatomic, strong) UIPageControl *pageControl;   ///< 指示器
@property (nonatomic, strong) UIColor *buttonBgColor;       ///< 按钮背景色
@property (nonatomic, strong) UIColor *buttonBorderColor;   ///< 按钮边框颜色
@property (nonatomic, strong) UIColor *titleColor;          ///< 按钮文字颜色
@property (nonatomic, copy)   NSString *buttonTitle;        ///< 按钮文字

@end

@implementation CBGuideView

DEF_SINGLETON(CBGuideView)

#pragma mark - Public

- (void)showGuideViewWithImages:(NSArray *)images
                 andButtonTitle:(NSString *)title
            andButtonTitleColor:(UIColor *)titleColor
               andButtonBGColor:(UIColor *)bgColor
           andButtonBorderColor:(UIColor *)borderColor {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    //根据版本号来判断是否需要显示引导页，一般来说每更新一个版本引导页都会有相应的修改
    BOOL show = [userDefaults boolForKey:[NSString stringWithFormat:@"version_%@", version]];
    
    if (!show) {
        self.images = images;
        self.buttonBorderColor = borderColor;
        self.buttonBgColor = bgColor;
        self.buttonTitle = title;
        self.titleColor = titleColor;
        self.pageControl.numberOfPages = images.count;
        
        if (nil == self.window) {
            self.window = [UIApplication sharedApplication].keyWindow;
        }
        
        [self.window addSubview:self.view];
        [self.window addSubview:self.pageControl];
        
        [userDefaults setBool:YES forKey:[NSString stringWithFormat:@"version_%@", version]];
        [userDefaults synchronize];
    }
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CBGuideViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdGuideViewCell forIndexPath:indexPath];
    
    UIImage *img = [self.images objectAtIndex:indexPath.row];
    CGSize size = [self adapterSizeImageSize:img.size compareSize:kScreenViewBounds.size];
    
    //自适应图片位置,图片可以是任意尺寸,会自动缩放.
    cell.imageView.frame = CGRectMake(0, 0, size.width, size.height);
    cell.imageView.image = img;
    cell.imageView.center = CGPointMake(kScreenViewBounds.size.width / 2, kScreenViewBounds.size.height / 2);
    
    if (indexPath.row == self.images.count - 1) {
        [cell.button setHidden:NO];
        [cell.button addTarget:self action:@selector(nextButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button setBackgroundColor:self.buttonBgColor];
        [cell.button setTitle:self.buttonTitle forState:UIControlStateNormal];
        [cell.button setTitleColor:self.titleColor forState:UIControlStateNormal];
        cell.button.layer.borderColor = [self.buttonBorderColor CGColor];
    } else {
        [cell.button setHidden:YES];
    }
    
    return cell;
}

/**
 *  计算自适应的图片
 *
 *  @param is 需要适应的尺寸
 *  @param cs 适应到的尺寸
 *
 *  @return 适应后的尺寸
 */
- (CGSize)adapterSizeImageSize:(CGSize)is compareSize:(CGSize)cs
{
    CGFloat w = cs.width;
    CGFloat h = cs.width / is.width * is.height;
    
    if (h < cs.height) {
        w = cs.height / h * w;
        h = cs.height;
    }
    return CGSizeMake(w, h);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (scrollView.contentOffset.x / kScreenViewBounds.size.width);
    if (self.pageControl.currentPage == self.images.count-1) {
        self.pageControl.hidden = YES;
    } else {
        self.pageControl.hidden = NO;
    }
}

/**
 *  点击立即体验按钮响应事件
 *
 *  @param sender sender
 */
- (void)nextButtonHandler:(id)sender {
    self.view.alpha = 1;
    [UIView animateWithDuration:0.35 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.pageControl removeFromSuperview];
        [self.view removeFromSuperview];
        [self setWindow:nil];
        [self setView:nil];
        [self setPageControl:nil];
    }];
}

/**
 *  引导页界面
 *
 *  @return 引导页界面
 */
- (UICollectionView *)view {
    if (!_view) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = kScreenViewBounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _view = [[UICollectionView alloc] initWithFrame:kScreenViewBounds collectionViewLayout:layout];
        _view.bounces = NO;
        _view.backgroundColor = [UIColor whiteColor];
        _view.showsHorizontalScrollIndicator = NO;
        _view.showsVerticalScrollIndicator = NO;
        _view.pagingEnabled = YES;
        _view.dataSource = self;
        _view.delegate = self;
        [_view registerClass:[CBGuideViewCell class] forCellWithReuseIdentifier:kReuseIdGuideViewCell];
    }
    return _view;
}

/**
 *  初始化pageControl
 *
 *  @return pageControl
 */
- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, 0, kScreenViewBounds.size.width, 44.0f);
        if (iPhoneX) {
            [_pageControl setCenter:CGPointMake(kScreenViewBounds.size.width / 2, kScreenViewBounds.size.height - 140+22)];
        } else {
            [_pageControl setCenter:CGPointMake(kScreenViewBounds.size.width / 2, kScreenViewBounds.size.height - 98+22)];
        }
        
    }
    return _pageControl;
}

@end
