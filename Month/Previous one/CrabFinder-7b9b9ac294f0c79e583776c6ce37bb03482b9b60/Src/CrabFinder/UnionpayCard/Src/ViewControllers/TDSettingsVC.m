//
//  TDSettingsVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDSettingsVC.h"
#import "TDSettingCell.h"

const NSString *strSettingCellID = @"strSettingCellID";

@interface TDSettingsVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tvSettings;
}

@end

@implementation TDSettingsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Settings";
    
    self.navigationItem.rightBarButtonItem = nil;
    
    [self createViews];
    [self layoutViews];
}

-(NSArray *)settingItems {
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:@[@"Notifications", @"Share this app"]];
    [items addObject:@[@"Feedback", @"Help", @"Version", @"About"]];
    
    return items;
}

-(void)createViews {
    _tvSettings = [UITableView new];//[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tvSettings.backgroundColor = [UIColor clearColor];
    _tvSettings.delegate = self;
    _tvSettings.dataSource = self;
    _tvSettings.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tvSettings registerClass:[TDSettingCell class] forCellReuseIdentifier:(NSString *)strSettingCellID];
    [self.view addSubview:_tvSettings];
    
}

-(void)layoutViews {
    [_tvSettings alignToView:self.view];
}



#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self settingItems].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *items = [self settingItems][section];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TDSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)strSettingCellID];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    ETDCellStyle cellStyle = [TDSettingCell cellStyleWithIndexPath:indexPath tableView:tableView tableViewDataSource:self];
    [cell setStyle:cellStyle];
    cell.lblTitle.text = [self settingItems][section][row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TDSettingCell HEIGHT];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

@end
