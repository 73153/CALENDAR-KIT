//
//  TDAlert.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/10/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDBaseModel.h"

@interface TDAlert : TDBaseModel
@property (nonatomic, assign) long long     vendorID;
@property (nonatomic, copy) NSString        *title;
@property (nonatomic, copy) NSString        *content;
@property (nonatomic, strong) NSDate        *createTime;
@end
