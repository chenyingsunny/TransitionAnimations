//
//  WeChatImageViewController.m
//  TransAnimationDemo
//
//  Created by ChenYing on 17/3/3.
//  Copyright © 2017年 ChenYing. All rights reserved.
//

#import "WeChatImageViewController.h"
#import "WeChatPopAnimatedTransitioning.h"

@interface WeChatImageViewController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
{
    UIPercentDrivenInteractiveTransition *_dirvenTransition;
}

@end

@implementation WeChatImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method

- (void)setupView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    NSString *imagesBundlePath = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"bundle"];
    NSString *imagePath = [[NSBundle bundleWithPath:imagesBundlePath] pathForResource:@"vegetable" ofType:@"jpg"];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
   
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [imageView addGestureRecognizer:panGesture];
    
    _imageView = imageView;
}

#pragma mark - Gesture Event

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    float y = [gestureRecognizer translationInView:self.view].y;
    float progress = y/_imageView.frame.size.height;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _dirvenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        self.navigationController.delegate = self;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        [_dirvenTransition updateInteractiveTransition:progress];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded ||
             gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.3) {
            [_dirvenTransition finishInteractiveTransition];
        }
        else {
            _imageView.hidden = NO;
            [_dirvenTransition cancelInteractiveTransition];
        }
        _dirvenTransition = nil;
    }
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return [[WeChatPopAnimatedTransitioning alloc] init];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if ([animationController isKindOfClass:[WeChatPopAnimatedTransitioning class]]) {
        return _dirvenTransition;
    }
    return nil;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

@end
