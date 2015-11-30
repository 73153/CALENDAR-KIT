//
//  TDCommentCell.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/19/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDCommentCell : UITableViewCell
@property (nonatomic, strong) UILabel       *lblTitle;
@property (nonatomic, strong) UILabel       *lblMessage;
@property (nonatomic, strong) UIImageView   *ivLogo;


+(CGFloat)cellHeight;
@end
