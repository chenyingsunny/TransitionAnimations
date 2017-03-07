//
//  ZDMDetailViewController.m
//  TransAnimationDemo
//
//  Created by ChenYing on 17/3/2.
//  Copyright © 2017年 ChenYing. All rights reserved.
//

#import "ZDMDetailViewController.h"
#import "ZDMCommentViewController.h"

@interface ZDMDetailViewController () <UIGestureRecognizerDelegate>
{
    BOOL _gestureflag;
}

@end

@implementation ZDMDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"zdm_detail_title", nil);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0.0, self.view.frame.size.width - 2 * 15.0, 30.0)];
    label.center = self.view.center;
    label.font = [UIFont systemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = NSLocalizedString(@"zdm_tip", nil);
    [self.view addSubview:label];
    
    //注释的这段代码，是实现划动右边缘来完成页面跳转，类似于系统的左划返回上一页
    /*
    UIScreenEdgePanGestureRecognizer *edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePan:)];
    edgePanGesture.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:edgePanGesture];
    */
    
    //这个手势实现了全屏左划，页面跳转
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _gestureflag = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

#pragma mark - Gesture Event

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    float x = [gestureRecognizer translationInView:self.view].x;
    float progress = x/self.view.bounds.size.width;
    if (progress < -0.3 && !_gestureflag) {
        _gestureflag = YES;
        ZDMCommentViewController *viewController = [[ZDMCommentViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)handleEdgePan:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer
{
    float x = fabs([gestureRecognizer translationInView:self.view].x);
    float progress = x/self.view.bounds.size.width;
    if (progress > 0.3 && !_gestureflag) {
        _gestureflag = YES;
        ZDMCommentViewController *viewController = [[ZDMCommentViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
