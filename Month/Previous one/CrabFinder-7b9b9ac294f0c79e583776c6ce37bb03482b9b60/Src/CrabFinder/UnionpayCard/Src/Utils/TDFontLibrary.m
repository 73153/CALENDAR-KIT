//
//  TDFontLibrary.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDFontLibrary.h"

#define FONT_SIZE_TITLE     (15.f)

@implementation TDFontLibrary
DEF_SINGLETON(TDFontLibrary)

-(void)doInit {
    //_fontTileButton = [UIFont fontWithName:FONT_NAME_DUAN_NING_XING size:25.f];
    _fontNormal = [UIFont systemFontOfSize:13.f];
    _fontNormalBold = [UIFont boldSystemFontOfSize:13.f];
    _fontTitle = [UIFont systemFontOfSize:FONT_SIZE_TITLE];
    _fontTitleBold = [UIFont boldSystemFontOfSize:FONT_SIZE_TITLE];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self doInit];
    }
    return self;
}

@end
