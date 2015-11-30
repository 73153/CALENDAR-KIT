//
//  TDSeasonalItemsVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/10/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDSeasonalCategoriesVC.h"
#import "TDSeasonalProductsVC.h"

#define TABLE_CELL_ID       @"TABLE_CELL_ID"

@interface TDSeasonalCategoriesVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView     *_tvCategories;
}

@end


@implementation TDSeasonalCategoriesVC

-(NSArray *)testData {
    static NSArray *testData = nil;
    if (testData == nil) {
        testData = @[@"Nuts", @"Veggies", @"Fruit", @"Herbs", @"Spreads/Sauces", @"Dairy", @"Grain", @"Crafts", @"Surf n' Turf", @"Plants", @"Baked Goods"];
    }
    
    return testData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Seasonal Food";
    
    [self initViews];
    [self setupViews];
}

-(void)initViews {
    _tvCategories = [UITableView new];
    _tvCategories.dataSource = self;
    _tvCategories.delegate = self;
    [self.view addSubview:_tvCategories];
    [_tvCategories registerClass:[UITableViewCell class] forCellReuseIdentifier:TABLE_CELL_ID];
}

-(void)setupViews {
    [_tvCategories alignToView:self.view];
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
    
    TDSeasonalProductsVC *vc = [TDSeasonalProductsVC new];
    vc.title = [self testData][indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
