//
//  LeftView.m
//  yo_parking
//
//  Created by zhanghangzhen on 16/4/14.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "LeftView.h"
#import "Header.h"

@interface LeftView ()<UITableViewDelegate,UITableViewDataSource>

{
    CGFloat X;
    CGFloat Y;
    CGFloat width;
    CGFloat hight;
    UIView *_HeadView;
    UITableView *tabView;
    
    UIView*alphaView;
    
}

@property (nonatomic,copy)NSMutableArray *dataArr;

@end

@implementation LeftView

-(NSMutableArray *)dataArr{

    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]initWithObjects:@"订单",@"车辆管理",@"积分商城",@"建议反馈", nil];
    }
    return _dataArr;
}
-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
         self.backgroundColor = [UIColor blackColor];
         self.alpha = 1.0;
       
        Y = frame.origin.y;
        width = 250;
        hight = frame.size.height;
        X = frame.origin.x;
        
        //点击的手势：
        // 我们需要定义一个方法，当手势识别检测到的时候，运行
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        // setNumberOfTapsRequired 点按次数
        [tap setNumberOfTapsRequired:1];
        // setNumberOfTouchesRequired 点按的手指数量
        [tap setNumberOfTouchesRequired:1];
        // 把手势识别增加到视图上
        [self addGestureRecognizer:tap];
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self addGestureRecognizer:swipeLeft];
         [self setHeadView];
         [self setTabeView];
        }
    return  self;
}
-(void)swipeAction:(UISwipeGestureRecognizer*)swi{
    if (self.IS_OPEN) {
        [self closeLeftView:YES];
        self.IS_OPEN = NO;
    }
}
-(void)tapAction:(UITapGestureRecognizer*)tap{

    if (self.IS_OPEN) {
        [self closeLeftView:YES];
        self.IS_OPEN = NO;
    }
 }
-(void)setHeadView{
   
    
    alphaView = [[UIView alloc]initWithFrame:CGRectMake(-screen_width, Y, screen_width, hight)];
    alphaView.backgroundColor = [UIColor colorWithRed:0.111 green:0.179 blue:0.110 alpha:0.1];
    [self addSubview:alphaView];
    
    //点击的手势：
    // 我们需要定义一个方法，当手势识别检测到的时候，运行
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    // setNumberOfTapsRequired 点按次数
    [tap setNumberOfTapsRequired:1];
    // setNumberOfTouchesRequired 点按的手指数量
    [tap setNumberOfTouchesRequired:1];
    // 把手势识别增加到视图上
    [alphaView addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [alphaView addGestureRecognizer:swipeLeft];
    _HeadView = [[UIView alloc]initWithFrame:CGRectMake(X, 0, 250, 150)];
    _HeadView.backgroundColor = [UIColor blackColor];
    [self addSubview:_HeadView];
    
}
-(void)setTabeView{
     tabView = [[UITableView alloc]initWithFrame:CGRectMake(X, 0, 250, hight)];
     tabView.alpha = 1;
     tabView.delegate = self;
     tabView.dataSource = self;
     tabView.backgroundColor = [UIColor blackColor];
     tabView.tableHeaderView = _HeadView;
     tabView.tableFooterView = [[UIView alloc]init];
     [self addSubview:tabView];
    
}
-(void)openLeftView:(BOOL)animated{
    
    self.IS_OPEN = YES;
    X = 0;
//     width = screen_width;
      if (animated) {
            [UIView animateWithDuration:0.5 animations:^{
             self.frame = CGRectMake(X, Y, width, hight);
                tabView.frame = CGRectMake(X , Y, 250, hight);
          }];
    }else{
    self.frame = CGRectMake(X, Y, width, hight);
    tabView.frame = CGRectMake(X , Y, 250, hight);

     }
  }

-(void)closeLeftView:(BOOL)animated{
    self.IS_OPEN = NO;
//    width = 0.0;
    X = -width;
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
             self.frame = CGRectMake(X, Y, width, hight);
            tabView.frame = CGRectMake(X , Y, width, hight);
            
            alphaView.frame = CGRectMake(-screen_width, Y, screen_width, hight);
            

         }];
    }else{
        self.frame = CGRectMake(X, Y, width, hight);
        tabView.frame = CGRectMake(X, Y, width, hight);
        alphaView.frame = CGRectMake(-screen_width, Y, screen_width, hight);

     }
}
-(void)openingLeftView:(CGFloat)with{
    self.frame = CGRectMake(X + with, Y, width, hight);
    tabView.frame = CGRectMake(X + with, Y, width, hight);
    alphaView.frame = CGRectMake(X + with , 0, screen_width, screen_height);
    alphaView.alpha = width / 250.0;
 }
 

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%ld",(long)indexPath.row);
    
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString*cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
     cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
