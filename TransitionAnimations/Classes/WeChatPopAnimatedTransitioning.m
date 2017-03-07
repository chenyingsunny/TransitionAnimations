//
//  WeChatPopAnimatedTransitioning.m
//  TransAnimationDemo
//
//  Created by ChenYing on 17/3/3.
//  Copyright © 2017年 ChenYing. All rights reserved.
//

#import "WeChatPopAnimatedTransitioning.h"
#import "WeChatViewController.h"
#import "WeChatImageViewController.h"

@implementation WeChatPopAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ([fromVC isKindOfClass:[WeChatImageViewController class]] &&
        [toVC isKindOfClass:[WeChatViewController class]]) {
        
        WeChatImageViewController *fromViewController = (WeChatImageViewController *)fromVC;
        WeChatViewController *toViewController = (WeChatViewController *)toVC;
        UIView *containerView = [transitionContext containerView];
        
        toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
       // toViewController.view.alpha = 0;
        [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
        
        
        UIView *snapshotView = [fromViewController.imageView snapshotViewAfterScreenUpdates:NO];
        snapshotView.frame = [containerView convertRect:fromViewController.imageView.frame fromView:fromViewController.imageView.superview];
        [containerView addSubview:snapshotView];
        fromViewController.imageView.hidden = YES;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            UITableViewCell *selectedCell = [toViewController.tableView cellForRowAtIndexPath:toViewController.tableView.indexPathForSelectedRow];
            snapshotView.frame = [containerView convertRect:selectedCell.imageView.frame fromView:selectedCell.imageView.superview];
            //toViewController.view.alpha = 1.0;
            fromViewController.view.alpha = 0;
        } completion:^(BOOL finished) {
            [snapshotView removeFromSuperview];
            fromViewController.imageView.hidden = NO;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

@end
