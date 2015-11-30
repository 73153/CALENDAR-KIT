//
//  TDProfileHeaderView.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/25/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDProfileHeaderView : UIView
@property (nonatomic, strong) UILabel       *lblTitle;
@property (nonatomic, strong) UIButton       *btnMore;

+(CGFloat)viewHeight;
@end
