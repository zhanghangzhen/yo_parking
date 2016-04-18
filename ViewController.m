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

@interface ViewController ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_tableView;
}
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
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
     [self.view addSubview:_tableView];
    
    [_tableView reloadData];
    
  }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor purpleColor];
    }
    return  cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //转动特效
    CATransform3D rotation;
    rotation = CATransform3DMakeTranslation(0 ,100 ,20);
//    rotation = CATransform3DScale(rotation, 0.7, .9, 2);
    rotation = CATransform3DScale(rotation, 0.7, .9, 2);

    rotation.m34 = 1.0/ -600;
    /*
     CATransform3D rotation;//3D旋转
     rotation = CATransform3DMakeTranslation(0 ,100 ,20);
     
     rotation = CATransform3DScale(rotation, 0.7, .9, 2);
     rotation.m34 = 5.0/ -600;
     */
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(100, 100);
    cell.alpha = 0;
    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        cell.layer.transform = CATransform3DIdentity;
//        cell.alpha = 1;
//        cell.layer.shadowOffset = CGSizeMake(0, 0);
//    }];
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
