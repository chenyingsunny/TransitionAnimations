//
//  NetEaseDetailViewController.m
//  TransAnimationDemo
//
//  Created by ChenYing on 17/3/1.
//  Copyright © 2017年 ChenYing. All rights reserved.
//

#import "NetEaseDetailViewController.h"
#import "NetEaseAnimatedTransitioning.h"

static const CGFloat kPullCloseOffset = 90;

@interface NetEaseDetailViewController ()<UINavigationControllerDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    BOOL _shouldClose;
    UILabel *_releaseLabel;
}

@end

@implementation NetEaseDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 15.0, scrollView.frame.size.width - 2 * 15.0, 0)];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14.0];
    [scrollView addSubview:label];
    label.text = NSLocalizedString(@"news_content", nil);
    CGRect rect = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:label.font} context:nil];
    CGRect frame = label.frame;
    frame.size.height = rect.size.height;
    label.frame = frame;
    
    if (label.frame.size.height < scrollView.frame.size.height) {
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height + 50);
    }
    else {
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, label.frame.size.height + 50);
    }
    
    UIView *releaseView = [[UIView alloc] initWithFrame:CGRectMake(0, scrollView.contentSize.height, scrollView.frame.size.width, 50)];
    [scrollView addSubview:releaseView];
    
    _releaseLabel = [[UILabel alloc] initWithFrame:releaseView.bounds];
    _releaseLabel.textAlignment = NSTextAlignmentCenter;
    _releaseLabel.font = [UIFont systemFontOfSize:14.0];
    _releaseLabel.textColor = [UIColor grayColor];
    [releaseView addSubview:_releaseLabel];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [scrollView addGestureRecognizer:panGesture];
}

#pragma mark - Gesture Event

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded && _shouldClose) {
        self.navigationController.delegate = self;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return [[NetEaseAnimatedTransitioning alloc] init];
    }
    return nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{    
    if (scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height > kPullCloseOffset) {
        _shouldClose = YES;
        _releaseLabel.text = NSLocalizedString(@"release_close_page", nil);
    }
    else {
        _shouldClose = NO;
        _releaseLabel.text = NSLocalizedString(@"pull_close_page", nil);
    }
}

@end
