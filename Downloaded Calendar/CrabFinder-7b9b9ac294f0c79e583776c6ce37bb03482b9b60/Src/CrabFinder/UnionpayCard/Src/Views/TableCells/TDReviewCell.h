//
//  TDReviewCell.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/17/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDReviewCell : UITableViewCell
@property (nonatomic, strong) UIImageView     *ivPhoto;
@property (nonatomic, strong) UILabel         *lblTitle;
@property (nonatomic, strong) UILabel         *lblMessage;
@property (nonatomic, strong) EDStarRating     *viewRating;

+(float)cellHeight;

@end
