//
//  NetEaseViewController.m
//  TransAnimationDemo
//
//  Created by ChenYing on 17/3/1.
//  Copyright © 2017年 ChenYing. All rights reserved.
//

#import "NetEaseViewController.h"
#import "NetEaseDetailViewController.h"

static const CGFloat kTableViewCellHeight = 44.0;

@interface NetEaseViewController ()<UITableViewDataSource, UITableViewDelegate>
{
}

@end

@implementation NetEaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.delegate = self;
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
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = NSLocalizedString(@"net_ease_news", nil);
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NetEaseDetailViewController *viewController = [[NetEaseDetailViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
