//
//  TDNewsFeed.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/5/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDNewsFeed.h"

@implementation TDNewsFeed

-(NSString *)title {
    return _status ? _status.title : _review.title;
}

@end
