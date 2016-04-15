//
//  LeftMenuView.h
//  Park
//
//  Created by  apple on 15/7/3.
//  Copyright (c) 2015年  apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftMenuDelegate <NSObject>

- (void)selectedMenuIndex:(NSInteger)index;

@end

@interface LeftMenuView : UIScrollView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<LeftMenuDelegate> menuDelegate;
@property (nonatomic, strong) UIView        *vContent;
@property (nonatomic, strong) UIImageView   *ivHeadBg;
@property (nonatomic, strong) UIImageView   *ivHead;
@property (nonatomic, strong) UILabel       *labPhone;
@property (nonatomic, strong) UITableView   *tbMenuView;
@property (nonatomic, strong) UIView        *alphaView;
@property (nonatomic, assign) CGFloat       sideOffset;
//@property (nonatomic, assign) CGFloat       sideAnimationDuration;
@property (nonatomic, assign) CGFloat       defaultAlpha;

- (void)openLeftView:(BOOL)animated;

@end
