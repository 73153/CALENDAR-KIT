//
//  TDProductVendorCell.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/16/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EDStarRating/EDStarRating.h>

@interface TDProductVendorCell : UITableViewCell

@property (nonatomic, strong) UIImageView     *ivVendorPhoto;
@property (nonatomic, strong) UILabel         *lblVendorName;
@property (nonatomic, strong) EDStarRating     *viewRating;
@property (nonatomic, strong) UIView          *viewPhotoContaner;


+(float)cellHeight;
@end
