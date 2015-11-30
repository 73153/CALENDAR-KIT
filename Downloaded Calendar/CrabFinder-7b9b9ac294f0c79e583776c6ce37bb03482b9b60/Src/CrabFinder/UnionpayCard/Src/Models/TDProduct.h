//
//  TDProduct.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/10/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDBaseModel.h"

@interface TDProduct : TDBaseModel
@property (nonatomic, assign) long long     vendorID;
@property (nonatomic, copy) NSString        *category;
@property (nonatomic, copy) NSString        *description;
@property (nonatomic, copy) NSString        *picture;

@end
