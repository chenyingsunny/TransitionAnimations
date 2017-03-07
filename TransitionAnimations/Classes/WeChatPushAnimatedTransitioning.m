//
//  WeChatPushAnimatedTransitioning.m
//  TransAnimationDemo
//
//  Created by ChenYing on 17/3/3.
//  Copyright © 2017年 ChenYing. All rights reserved.
//

#import "WeChatPushAnimatedTransitioning.h"
#import "WeChatViewController.h"
#import "WeChatImageViewController.h"

@implementation WeChatPushAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([fromVC isKindOfClass:[WeChatViewController class]] &&
        [toVC isKindOfClass:[WeChatImageViewController class]]) {
        
        WeChatViewController *fromViewController = (WeChatViewController *)fromVC;
        WeChatImageViewController *toViewController = (WeChatImageViewController *)toVC;
        UIView *containerView = [transitionContext containerView];
        
        toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
        toViewController.view.alpha = 0;
        [containerView addSubview:toViewController.view];
        
        UITableViewCell *selectedCell = [fromViewController.tableView cellForRowAtIndexPath:fromViewController.tableView.indexPathForSelectedRow];
        UIView *snapshotView = [selectedCell.imageView snapshotViewAfterScreenUpdates:NO];
        snapshotView.frame = [containerView convertRect:selectedCell.imageView.frame fromView:selectedCell.imageView.superview];
        [containerView addSubview:snapshotView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapshotView.frame = [containerView convertRect:toViewController.imageView.frame fromView:toViewController.imageView.superview];
            toViewController.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            [snapshotView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
