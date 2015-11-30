//
//  TDEvent.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/24/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDBaseModel.h"

@interface TDEvent : TDBaseModel
@property (nonatomic, strong) NSDate    *time;
@property (nonatomic, assign) CGFloat    rating;

@end
