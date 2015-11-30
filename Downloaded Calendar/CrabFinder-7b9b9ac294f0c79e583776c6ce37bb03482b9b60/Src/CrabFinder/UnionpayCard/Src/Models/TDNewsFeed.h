//
//  TDNewsFeed.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/5/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDBaseModel.h"
#import "TDStatusUpdate.h"
#import "TDReview.h"

@interface TDNewsFeed : TDBaseModel
@property (nonatomic, strong) TDStatusUpdate  *status;
@property (nonatomic, strong) TDReview  *review;

-(NSString *)title;
@end
