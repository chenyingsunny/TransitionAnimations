//
//  WeChatViewController.m
//  TransAnimationDemo
//
//  Created by ChenYing on 17/3/3.
//  Copyright © 2017年 ChenYing. All rights reserved.
//

#import "WeChatViewController.h"
#import "WeChatImageViewController.h"
#import "WeChatPushAnimatedTransitioning.h"

@interface WeChatViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@end

@implementation WeChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"wechat_detail_title", nil);
    
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [[WeChatPushAnimatedTransitioning alloc] init];
    }
    return nil;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.text = NSLocalizedString(@"wechat_content", nil);
        NSString *imagesBundlePath = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"bundle"];
        NSString *imagePath = [[NSBundle bundleWithPath:imagesBundlePath] pathForResource:@"vegetable" ofType:@"jpg"];
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeChatImageViewController *viewController = [[WeChatImageViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
