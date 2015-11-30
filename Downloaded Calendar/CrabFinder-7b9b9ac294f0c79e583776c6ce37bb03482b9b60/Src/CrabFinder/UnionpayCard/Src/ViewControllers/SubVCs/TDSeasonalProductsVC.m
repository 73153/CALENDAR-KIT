//
//  TDSeasonalItemsVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/13/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDSeasonalProductsVC.h"
#import "TDProductDetailVC.h"

#define TABLE_CELL_ID       @"TABLE_CELL_ID"

@interface TDSeasonalProductsVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView     *_tvProducts;
}

@end

@implementation TDSeasonalProductsVC

-(NSArray *)testData {
    static NSArray *testData = nil;
    if (testData == nil) {
        testData = @[@"Apple", @"Orange", @"Bilberry", @"Cherry", @"Damson", @"Honeydew", @"Lemon", @"Persimmon", @"Satsuma"];
    }
    
    return testData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
    [self setupViews];
}

-(void)initViews {
    _tvProducts = [UITableView new];
    _tvProducts.dataSource = self;
    _tvProducts.delegate = self;
    [self.view addSubview:_tvProducts];
    [_tvProducts registerClass:[UITableViewCell class] forCellReuseIdentifier:TABLE_CELL_ID];
}

-(void)setupViews {
    [_tvProducts alignToView:self.view];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self testData].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_CELL_ID forIndexPath:indexPath];
    NSString *name = [self testData][indexPath.row];
    cell.textLabel.text = name;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TDProductDetailVC *vc = [TDProductDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
