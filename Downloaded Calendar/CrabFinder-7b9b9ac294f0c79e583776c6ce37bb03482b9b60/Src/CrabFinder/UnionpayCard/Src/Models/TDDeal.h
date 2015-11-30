//
//  TDDeal.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/13/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDBaseModel.h"

@interface TDDeal : TDBaseModel
@property (nonatomic, assign) BOOL      isNearMe;
@property (nonatomic, assign) BOOL      isOpenNow;
@property (nonatomic, assign) float     discount;
@property (nonatomic, assign) float     price;
@property (nonatomic, copy) NSString    *providerName;
@property (nonatomic, copy) NSString    *providerPhoto;
@property (nonatomic, copy) NSString    *providerType;
@property (nonatomic, copy) NSString    *desc;

+(NSArray *)testData;

@end
