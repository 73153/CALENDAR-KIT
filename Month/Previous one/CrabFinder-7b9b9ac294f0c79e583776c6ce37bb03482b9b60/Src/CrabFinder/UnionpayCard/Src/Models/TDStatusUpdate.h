//
//  TDStatus.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/4/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDBaseModel.h"

@interface TDStatusUpdate : TDBaseModel
@property (nonatomic, assign) long long         userID;
@property (nonatomic, copy) NSString            *userName;
@property (nonatomic, copy) NSString            *userPhoto;
@property (nonatomic, copy) NSString            *title;
@property (nonatomic, copy) NSString            *content;
@property (nonatomic, strong) NSMutableArray    *photos;
@property (nonatomic, strong) NSDate            *date;
@end

