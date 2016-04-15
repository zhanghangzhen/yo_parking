//
//  ViewController.m
//  yo_parking
//
//  Created by zhanghangzhen on 16/4/14.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import "LeftView.h"
#import "LeftMenuView.h"
#import "TestViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightItem;
@property (nonatomic,strong)LeftMenuView *leftView;


@end

@implementation ViewController
- (IBAction)showLeftView:(id)sender {
    [self.navigationController.view addSubview:_leftView];
    [UIView animateWithDuration:0.3 animations:^{
        [_leftView openLeftView:YES];
    }];

 }
- (IBAction)tableLists:(id)sender {
     TestViewController *vc = [[TestViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNabBar];
    self.leftView = [[LeftMenuView alloc]initWithFrame:self.view.bounds];
//    [self.navigationController.view addSubview:self.leftView];
    // 屏幕边缘侧拉手势
    UIScreenEdgePanGestureRecognizer *edgeGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    edgeGesture.edges = UIRectEdgeLeft;
    edgeGesture.delegate = self;
    [self.view addGestureRecognizer:edgeGesture];
 }
#pragma mark - GestureRecognizer Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

- (void)handleGesture:(UIScreenEdgePanGestureRecognizer *)gesture
{
    if(UIGestureRecognizerStateBegan == gesture.state)
    {
                NSLog(@"开始");
        [self.navigationController.view addSubview:_leftView];
    }
    else if(UIGestureRecognizerStateChanged == gesture.state)
    {
        // 根据被触摸手势的view计算得出坐标值
        CGPoint translation = [gesture translationInView:gesture.view];
                NSLog(@"进行中:%@", NSStringFromCGPoint(translation));
        
        if (translation.x<_leftView.sideOffset)
        {
            _leftView.contentOffset = CGPointMake(_leftView.sideOffset-translation.x, 0);
        }
     }
    else
    {
        CGPoint translation = [gesture translationInView:gesture.view];
                NSLog(@"wancheng：%@", NSStringFromCGPoint(translation));
 
        if (translation.x<_leftView.sideOffset/2)
        {
            [UIView animateWithDuration:0.3 animations:^{
                _leftView.contentOffset = CGPointMake(_leftView.sideOffset, 0);
            }completion:^(BOOL finished) {
                [_leftView removeFromSuperview];
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
//                [self hideBottomView];
                //                _leftView.contentOffset = CGPointMake(0, 0);
                [_leftView openLeftView:NO];
            }];
        }

     }
}
-(void)setNabBar{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]}];
    [self.rightItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
    [self.rightItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateHighlighted];
 }


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
