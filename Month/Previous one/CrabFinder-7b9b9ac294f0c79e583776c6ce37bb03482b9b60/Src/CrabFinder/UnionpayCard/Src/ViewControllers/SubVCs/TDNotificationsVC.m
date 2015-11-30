//
//  TDNotificationsVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/10/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDNotificationsVC.h"
#import "TDNotificationCell.h"

#define STR_CELL_ID             @"STR_CELL_ID"
#define STR_CELL_FOR_HEIGHT_ID  @"STR_CELL_FOR_HEIGHT_ID"

@interface TDNotificationsVC () <UITableViewDelegate, UITableViewDataSource> {
    UIButton      *_cbWeather;
    UIButton      *_cbAttendance;
    UIButton      *_cbInventory;
    
    UITableView             *_tvNotifications;
    TDNotificationCell      *_cellForHeight;
}

@end

@implementation TDNotificationsVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Notifications";
    
    [self initViews];
    [self setupViews];
}

-(void)initViews {
    _cbWeather = [self checkBoxWithTitle:@"Weather" action:@selector(weatherBoxCheckAction:)];
    [self.view addSubview:_cbWeather];
    
    _cbAttendance = [self checkBoxWithTitle:@"Attendance" action:@selector(attendanceBoxCheckAction:)];
    [self.view addSubview:_cbAttendance];
    
    _cbInventory = [self checkBoxWithTitle:@"Inventory" action:@selector(inventoryBoxCheckAction:)];
    [self.view addSubview:_cbInventory];
    
    _cbWeather.selected = _cbAttendance.selected = _cbInventory.selected = YES;
    
    _tvNotifications = [UITableView new];
    _tvNotifications.delegate = self;
    _tvNotifications.dataSource = self;
    [_tvNotifications registerClass:[TDNotificationCell class] forCellReuseIdentifier:STR_CELL_ID];
    [_tvNotifications registerClass:[TDNotificationCell class] forCellReuseIdentifier:STR_CELL_FOR_HEIGHT_ID];
    [self.view addSubview:_tvNotifications];
    
    _cellForHeight = [_tvNotifications dequeueReusableCellWithIdentifier:STR_CELL_FOR_HEIGHT_ID];
}

-(UIButton *)checkBoxWithTitle:(NSString *)aTitle action:(SEL)anAction {
    UIButton *btn = [UIButton new];
    //btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:aTitle forState:UIControlStateNormal];
    [btn setImage:[TDImageLibrary sharedInstance].boxUnchecked forState:UIControlStateNormal];
    [btn setImage:[TDImageLibrary sharedInstance].boxChecked forState:UIControlStateSelected];
    [btn addTarget:self action:anAction forControlEvents:UIControlEventTouchUpInside];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [btn setTitleColor:[FDColor sharedInstance].black forState:UIControlStateNormal];
    
    return btn;
}

-(void)setupViews {
    [_cbWeather constrainWidth:@"85"];
    [_cbWeather alignTop:@"15" leading:@"15" toView:self.view];
    
    [_cbAttendance alignTopEdgeWithView:_cbWeather predicate:nil];
    [_cbAttendance constrainWidth:@"100"];
    
    [_cbInventory alignTopEdgeWithView:_cbWeather predicate:nil];
    [_cbInventory constrainWidth:@"100"];
    
    NSArray *checkBoxes = @[_cbWeather, _cbAttendance, _cbInventory];
    [UIView spaceOutViewsHorizontally:checkBoxes predicate:@"10"];
    
    [_tvNotifications alignLeading:@"0" trailing:@"0" toView:self.view];
    [_tvNotifications constrainTopSpaceToView:_cbWeather predicate:@"10"];
    [_tvNotifications alignBottomEdgeWithView:self.view predicate:nil];
}

#pragma mark - actions
-(void)weatherBoxCheckAction:(id)sender {
    _cbWeather.selected = !_cbWeather.selected;
}

-(void)attendanceBoxCheckAction:(id)sender {
    _cbAttendance.selected = !_cbAttendance.selected;
}

-(void)inventoryBoxCheckAction:(id)sender {
    _cbInventory.selected = !_cbInventory.selected;
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


#define TEST_DESC @"Unfortunately we had a flat, so we can't show up.Unfortunately we had a flat, so we can't show up."
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:STR_CELL_ID forIndexPath:indexPath];
    cell.lblTitle.text = @"Safeway (Farmer Market)";
    cell.lblDescription.text = TEST_DESC;
    cell.ivPhoto.image = [TDImageLibrary sharedInstance].avatar;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDNotificationCell *cell = _cellForHeight;
    cell.frame = tableView.bounds;
    cell.lblTitle.text = @"Safeway (Farmer Market)";
    cell.lblDescription.text = TEST_DESC;
    cell.ivPhoto.image = [TDImageLibrary sharedInstance].avatar;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

@end
