//
//  LeftView.h
//  yo_parking
//
//  Created by zhanghangzhen on 16/4/14.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftView : UIView

@property(nonatomic)BOOL IS_OPEN;

- (void)openLeftView:(BOOL)animated;

- (void)closeLeftView:(BOOL)animated;

-(void)openingLeftView:(CGFloat)with;

@end
