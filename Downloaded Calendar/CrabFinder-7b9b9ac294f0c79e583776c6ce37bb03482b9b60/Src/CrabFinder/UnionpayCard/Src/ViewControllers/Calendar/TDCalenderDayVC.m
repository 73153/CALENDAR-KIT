//
//  TDCalenderDayVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/24/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDCalenderDayVC.h"
#import "TDEvent.h"
#import <MBCalendarKit/CKCalendarEvent.h>
#import "TDDayEventCell.h"
#import "TDMarketDetailVC.h"

#define STR_CELL_ID @"STR_CELL_ID"

@interface TDCalenderDayVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tv;
}

@end

@implementation TDCalenderDayVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Day";
    
    _tv = [UITableView new];
    _tv.dataSource = self;
    _tv.delegate = self;
    [_tv registerClass:[TDDayEventCell class] forCellReuseIdentifier:STR_CELL_ID];
    [self.view addSubview:_tv];
    [_tv alignToView:self.view];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _calendarEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDDayEventCell *cell = [tableView dequeueReusableCellWithIdentifier:STR_CELL_ID forIndexPath:indexPath];
    
    CKCalendarEvent *calendarEvent = _calendarEvents[indexPath.row];
    TDEvent *event = [calendarEvent.info objectForKey:@"info"];
    cell.lblTitle.text = event.name;
    cell.lblMessage.text = event.time.description;
    cell.viewRating.rating = event.rating;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TDDayEventCell cellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TDMarketDetailVC *vc = [TDMarketDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
