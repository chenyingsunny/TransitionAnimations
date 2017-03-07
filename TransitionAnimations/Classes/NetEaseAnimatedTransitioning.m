//
//  AnimaTool.m
//  TransAnimationDemo
//
//  Created by ChenYing on 17/3/1.
//  Copyright © 2017年 ChenYing. All rights reserved.
//

#import "NetEaseAnimatedTransitioning.h"

@implementation NetEaseAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id)transitionContext
{
    return 1.0f;
}

- (void)animateTransition:(id)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView addSubview:toViewController.view];
    
    UIView *snapshotView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = fromViewController.view.frame;
    [containerView addSubview:snapshotView];
    
    [fromViewController.view removeFromSuperview];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    void (^animations)() = ^() {
        int frame = 6;
        for (int i = 0; i < frame; i++) {
            [UIView addKeyframeWithRelativeStartTime:((i/frame) * duration) relativeDuration:duration/frame animations:^{
                snapshotView.transform = CGAffineTransformMakeScale(1, 1 - (i + 1)/frame);
                snapshotView.alpha = 1 - (i + 1)/frame;
            }];
        }
    };
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:animations completion:^(BOOL finished) {
        if (finished) {
            [snapshotView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }
    }];
}

@end
