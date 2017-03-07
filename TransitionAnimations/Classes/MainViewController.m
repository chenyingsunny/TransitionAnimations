//
//  ViewController.m
//  TransAnimationDemo
//
//  Created by ChenYing on 17/2/28.
//  Copyright © 2017年 ChenYing. All rights reserved.
//

#import "MainViewController.h"
#import "NetEaseViewController.h"
#import "ZDMDetailViewController.h"
#import "WeChatViewController.h"

static const NSString *kTitle = @"title";
static const NSString *kViewController = @"viewController";
static const CGFloat kTableViewCellHeight = 44.0;

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_dataArray;
}

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"transition_animation", nil);
    _dataArray = @[@{kTitle:NSLocalizedString(@"net_ease_list_title", nil), kViewController: [NetEaseViewController class]},
                   @{kTitle:NSLocalizedString(@"zdm_list_title", nil), kViewController: [ZDMDetailViewController class]},
                   @{kTitle:NSLocalizedString(@"wechat_list_title", nil), kViewController: [WeChatViewController class]}];
    [self setupView];
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
    tableView.rowHeight = kTableViewCellHeight;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *item = _dataArray[indexPath.row];
    cell.textLabel.text = item[kTitle];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *item = _dataArray[indexPath.row];
    Class vcClass = item[kViewController];
    UIViewController *viewController = [[vcClass alloc] init];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
