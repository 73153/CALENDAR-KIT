//
//  TDSettingCell.h
//  UnionpayCard
//
//  Created by Dong Yiming on 2/23/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kTDCellStyleTop = 0
    , kTDCellStyleMiddle
    , kTDCellStyleBottom
    , kTDCellStyleRound
}ETDCellStyle;

@interface TDSettingCell : UITableViewCell
@property (nonatomic, strong) UILabel         *lblTitle;
+(float)HEIGHT;

-(void)setStyle:(ETDCellStyle)aStyle;

+(ETDCellStyle)cellStyleWithIndexPath:(NSIndexPath *)aIndexPath
                            tableView:(UITableView *)aTableView
                  tableViewDataSource:(id<UITableViewDataSource>)aTableViewDataSource;

@end
