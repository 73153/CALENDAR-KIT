//
//  TDVendorsVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/24/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDVendorsVC.h"
#import "TDDayEventCell.h"

#define STR_CELL_ID @"STR_CELL_ID"

@interface TDVendorsVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tv;
}


@end

@implementation TDVendorsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Vendors";
    
    _tv = [UITableView new];
    _tv.dataSource = self;
    _tv.delegate = self;
    [_tv registerClass:[TDDayEventCell class] forCellReuseIdentifier:STR_CELL_ID];
    [self.view addSubview:_tv];
    [_tv alignToView:self.view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDDayEventCell *cell = [tableView dequeueReusableCellWithIdentifier:STR_CELL_ID forIndexPath:indexPath];
    
    cell.lblTitle.text = @"Vendor's Name";
    cell.lblMessage.text = @"";
    cell.viewRating.rating = 4;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TDDayEventCell cellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
