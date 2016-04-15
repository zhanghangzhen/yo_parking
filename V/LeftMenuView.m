//
//  LeftMenuView.m
//  Park
//
//  Created by  apple on 15/7/3.
//  Copyright (c) 2015年  apple. All rights reserved.
//

#import "LeftMenuView.h"
#import "Header.h"
@implementation LeftMenuView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.sideOffset = frame.size.width/3*2;
        self.defaultAlpha = 0.4;
        
        self.delegate = self;
        self.contentSize = CGSizeMake(self.sideOffset+frame.size.width, frame.size.height);
        self.backgroundColor = [UIColor clearColor];
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = 0;
        
//        [self setCanCancelContentTouches:NO];
//        [self setDelaysContentTouches:YES];
        
        self.vContent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.sideOffset, frame.size.height)];
        self.vContent.backgroundColor = kUIColorFromRGB(0x09091a);
//        self.tbLeftView.alpha = 1.0;
        [self addSubview:self.vContent];
        
        [self setLeftView];
        
        _alphaView = [[UIView alloc]initWithFrame:CGRectMake(self.sideOffset, 0, frame.size.width, frame.size.height)];
        _alphaView.backgroundColor = [UIColor grayColor];
        [self addSubview:_alphaView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissLeftView:)];
        [_alphaView addGestureRecognizer:tapGesture];
        
        self.contentOffset = CGPointMake(self.sideOffset, 0);
    }
    return self;
}

- (void)setLeftView
{
    _ivHeadBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.sideOffset, 130)];
    self.ivHeadBg.backgroundColor = kUIColorFromRGB(0x151525);
    [self.vContent addSubview:self.ivHeadBg];
    
    _ivHead = [[UIImageView alloc] initWithFrame:CGRectMake((self.sideOffset-50)/2, 30, 50, 50)];
    _ivHead.backgroundColor = [UIColor clearColor];
    _ivHead.layer.cornerRadius = _ivHead.bounds.size.width/2.0;
    _ivHead.layer.masksToBounds = YES;
    [self.vContent addSubview:self.ivHead];
    
    UITapGestureRecognizer *loginGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginAction:)];
    _ivHeadBg.userInteractionEnabled = YES;
    [_ivHeadBg addGestureRecognizer:loginGesture];
    
    _labPhone = [[UILabel alloc] initWithFrame:CGRectMake(20, 80+5, self.sideOffset-40, 40)];
    _labPhone.backgroundColor = [UIColor clearColor];
    _labPhone.textAlignment = NSTextAlignmentCenter;
    _labPhone.textColor = [UIColor whiteColor];
    _labPhone.font = [UIFont systemFontOfSize:20];
    [self.vContent addSubview:_labPhone];
    
    _tbMenuView = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, self.sideOffset, screen_height-130-30) style:UITableViewStylePlain];
    _tbMenuView.backgroundColor = [UIColor clearColor];
    _tbMenuView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbMenuView.dataSource = self;
    _tbMenuView.delegate = self;
    _tbMenuView.showsVerticalScrollIndicator = NO;
    _tbMenuView.scrollEnabled = NO;
    [self.vContent addSubview:_tbMenuView];
    
    UILabel *labVersion = [[UILabel alloc] initWithFrame:CGRectMake(0, screen_height-30, self.sideOffset, 25)];
    labVersion.backgroundColor = [UIColor clearColor];
    labVersion.textColor = [UIColor whiteColor];
    labVersion.font = [UIFont systemFontOfSize:15];
    labVersion.textAlignment = NSTextAlignmentCenter;
    labVersion.text = [NSString stringWithFormat:@"约停车 V %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [self.vContent addSubview:labVersion];
}

- (void)loginAction:(UIGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = CGPointMake(self.sideOffset, 0);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([self.menuDelegate respondsToSelector:@selector(selectedMenuIndex:)]) {
            [self.menuDelegate selectedMenuIndex:10];//只执行登陆操作
        }
    }];
}

#pragma mark - UITableView DataSource and Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *menuCell = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    UIButton *btnMenu = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, self.sideOffset, 45)];
    btnMenu.backgroundColor = [UIColor clearColor];
    btnMenu.titleLabel.font = [UIFont systemFontOfSize:18];
    btnMenu.tag = indexPath.row;
    [btnMenu addTarget:self action:@selector(menuSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btnMenu];
    
    switch (indexPath.row) {
        case 0:
            [btnMenu setImage:[UIImage imageNamed:@"orders_n.png"] forState:UIControlStateNormal];
            [btnMenu setImage:[UIImage imageNamed:@"orders_hl.png"] forState:UIControlStateHighlighted];
            [btnMenu setTitle:@"订单" forState:UIControlStateNormal];
            break;
        case 1:
            [btnMenu setImage:[UIImage imageNamed:@"account_n.png"] forState:UIControlStateNormal];
            [btnMenu setImage:[UIImage imageNamed:@"account_hl.png"] forState:UIControlStateHighlighted];
            [btnMenu setTitle:@"账户" forState:UIControlStateNormal];
            break;
        case 2:
            [btnMenu setImage:[UIImage imageNamed:@"preferential_n.png"] forState:UIControlStateNormal];
            [btnMenu setImage:[UIImage imageNamed:@"preferential_hl.png"] forState:UIControlStateHighlighted];
            [btnMenu setTitle:@"优惠" forState:UIControlStateNormal];
            break;
        case 3:
            [btnMenu setImage:[UIImage imageNamed:@"share_n.png"] forState:UIControlStateNormal];
            [btnMenu setImage:[UIImage imageNamed:@"share_hl.png"] forState:UIControlStateHighlighted];
            [btnMenu setTitle:@"分享" forState:UIControlStateNormal];
            break;
        case 4:
            [btnMenu setImage:[UIImage imageNamed:@"message_n.png"] forState:UIControlStateNormal];
            [btnMenu setImage:[UIImage imageNamed:@"message_hl.png"] forState:UIControlStateHighlighted];
            [btnMenu setTitle:@"消息" forState:UIControlStateNormal];
            break;
        case 5:
            [btnMenu setImage:[UIImage imageNamed:@"about_n.png"] forState:UIControlStateNormal];
            [btnMenu setImage:[UIImage imageNamed:@"about_hl.png"] forState:UIControlStateHighlighted];
            [btnMenu setTitle:@"关于" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    [btnMenu setImageEdgeInsets:UIEdgeInsetsMake(0, 16, 0, self.sideOffset-86+27-16)];//36+23
    [btnMenu setTitleEdgeInsets:UIEdgeInsetsMake(0, 27, 0, self.sideOffset-86-27)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)menuSelectedAction:(UIButton *)menuBtn
{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = CGPointMake(self.sideOffset, 0);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([self.menuDelegate respondsToSelector:@selector(selectedMenuIndex:)]) {
            [self.menuDelegate selectedMenuIndex:menuBtn.tag];
        }
    }];
}

#pragma mark - scrollView
- (void)closeSideView:(BOOL)animated
{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = CGPointMake(self.sideOffset, 0);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)openLeftView:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0, 0) animated:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [defaults objectForKey:user_id];
    if (userid!=nil)
    {
//        NSString *reqKey = [defaults objectForKey:REQ_KEY];
//        NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
//        [_ivHead setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://b2c.ezparking.com.cn/rtpi-service/member/getIcon.do?key=%@&id=%@&rnd=%f",reqKey,userid,nowTime]] placeholderImage:[UIImage imageNamed:@"user_head.png"]];
//        _labPhone.text = [[NSUserDefaults standardUserDefaults] objectForKey:user_phone];
    }
    else
    {
        [_ivHead setImage:[UIImage imageNamed:@"user_head.png"]];
        _labPhone.text = @"登录";
    }
}

- (void)arrangeViews:(UIScrollView *)scrollView
{
//    NSLog(@"final:%f,offset:%f",scrollView.contentOffset.x,self.sideOffset/2);
    if (scrollView.contentOffset.x<self.sideOffset/2)
    {
        [self openLeftView:YES];
    }
    else
    {
        [self closeSideView:YES];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"dragging:%f,%d",scrollView.contentOffset.x,decelerate);
    if (!decelerate){
        [self arrangeViews:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"Decelerating:%f",scrollView.contentOffset.x);
    [self arrangeViews:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _alphaView.alpha = (1-self.defaultAlpha)*(self.sideOffset-scrollView.contentOffset.x)/self.sideOffset;
}

- (void)dismissLeftView:(UITapGestureRecognizer *)tap
{
    [self closeSideView:YES];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
////    UIView *backView = [[UIView alloc]initWithFrame:rect];
//}

@end
