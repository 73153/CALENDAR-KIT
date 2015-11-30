//
//  TDReview.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/4/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDBaseModel.h"

@interface TDReview : TDBaseModel
@property (nonatomic, assign) long long     userID;
@property (nonatomic, copy) NSString        *userPhoto;

@property (nonatomic, assign) long long     vendorID;
@property (nonatomic, copy)     NSString    *title;
@property (nonatomic, copy)     NSString    *content;
@property (nonatomic, assign)   float       rating;
@end
