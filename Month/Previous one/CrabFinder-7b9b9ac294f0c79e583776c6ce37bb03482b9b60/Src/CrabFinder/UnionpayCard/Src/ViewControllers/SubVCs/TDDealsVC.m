//
//  TDDealsVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/10/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDDealsVC.h"
#import "TDDeal.h"
#import "TDNotificationCell.h"

#define STR_CELL_ID             @"STR_CELL_ID"
#define STR_CELL_FOR_HEIGHT_ID  @"STR_CELL_FOR_HEIGHT_ID"

@interface TDDealsVC () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray      *_deals;
    
    UITableView         *_tvDeals;
    TDNotificationCell      *_cellForHeight;
}

@end

@implementation TDDealsVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Deals";
    
    _deals = [NSMutableArray array];
    [_deals addObjectsFromArray:[TDDeal testData]];
    
    [self initViews];
    [self setupViews];
}

-(void)initViews {
    _tvDeals = [UITableView new];
    _tvDeals.delegate = self;
    _tvDeals.dataSource = self;
    [_tvDeals registerClass:[TDNotificationCell class] forCellReuseIdentifier:STR_CELL_ID];
    [_tvDeals registerClass:[TDNotificationCell class] forCellReuseIdentifier:STR_CELL_FOR_HEIGHT_ID];
    [self.view addSubview:_tvDeals];
    
    _cellForHeight = [_tvDeals dequeueReusableCellWithIdentifier:STR_CELL_FOR_HEIGHT_ID];
}

-(void)setupViews {
    [_tvDeals alignToView:self.view];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:STR_CELL_ID forIndexPath:indexPath];
    
    TDDeal *deal = _deals[indexPath.row];
    cell.lblTitle.text = [NSString stringWithFormat:@"%@(%@)", deal.providerName, deal.providerType];
    cell.lblDescription.text = deal.desc;
    cell.ivPhoto.image = [TDImageLibrary sharedInstance].avatar;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDNotificationCell *cell = _cellForHeight;
    cell.frame = tableView.bounds;
    
    TDDeal *deal = _deals[indexPath.row];
    cell.lblTitle.text = [NSString stringWithFormat:@"%@(%@)", deal.providerName, deal.providerType];
    cell.lblDescription.text = deal.desc;
    cell.ivPhoto.image = [TDImageLibrary sharedInstance].avatar;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

@end
