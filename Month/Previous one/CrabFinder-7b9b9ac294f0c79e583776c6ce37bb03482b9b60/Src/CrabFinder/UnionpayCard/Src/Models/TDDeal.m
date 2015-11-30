//
//  TDDeal.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/13/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDDeal.h"

@implementation TDDeal

+(NSArray *)testData {
    NSMutableArray *arr = [NSMutableArray array];
    
    TDDeal *deal = [TDDeal new];
    deal.isNearMe = YES;
    deal.isOpenNow = YES;
    deal.discount = .3f;
    deal.price = 500;
    deal.providerName = @"Spock";
    deal.providerPhoto = @"avatar_default";
    deal.providerType = @"Seller";
    deal.desc = @"Closing in 10-50% off all veggies!";
    [arr addObject:deal];
    
    deal = [TDDeal new];
    deal.isNearMe = NO;
    deal.isOpenNow = YES;
    deal.discount = .1f;
    deal.price = 100;
    deal.providerName = @"Safeway";
    deal.providerPhoto = @"avatar_default";
    deal.providerType = @"Farmer market";
    deal.desc = @"Plum have to go -10%";
    [arr addObject:deal];
    
    deal = [TDDeal new];
    deal.isNearMe = YES;
    deal.isOpenNow = NO;
    deal.discount = .5f;
    deal.price = 50;
    deal.providerName = @"Romulan Commander";
    deal.providerPhoto = @"avatar_default";
    deal.providerType = @"Seller";
    deal.desc = @"Last crop of the week, avocados buy one get one.";
    [arr addObject:deal];
    
    deal = [TDDeal new];
    deal.isNearMe = NO;
    deal.isOpenNow = NO;
    deal.discount = .8f;
    deal.price = 200;
    deal.providerName = @"Kirk";
    deal.providerPhoto = @"avatar_default";
    deal.providerType = @"Seller";
    deal.desc = @"Closing in 80% off all Fruit! Closing in 80% off all Fruit! Closing in 80% off all Fruit! Closing in 80% off all Fruit! ";
    [arr addObject:deal];
    
    return arr;
}

@end
