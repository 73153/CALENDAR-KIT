//
//  TDDayEventCell.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/24/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDDayEventCell : UITableViewCell

@property (nonatomic, strong) UILabel         *lblTitle;
@property (nonatomic, strong) UILabel         *lblMessage;
@property (nonatomic, strong) EDStarRating     *viewRating;

+(float)cellHeight;

@end
