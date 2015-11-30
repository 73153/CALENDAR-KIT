//
//  FDColor.h
//  iBolter
//
//  Created by Dong Yiming on 1/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDColor : NSObject
AS_SINGLETON(FDColor)

@property (nonatomic, strong) UIColor *magicMint;
@property (nonatomic, strong) UIColor *midnightBlue;
@property (nonatomic, strong) UIColor *orangeRed;
@property (nonatomic, strong) UIColor *caribbeanGreen;
@property (nonatomic, strong) UIColor *themeBlue;
@property (nonatomic, strong) UIColor *blueSapphire;


@property (nonatomic, strong) UIColor *desertSand;
@property (nonatomic, strong) UIColor *purpleHeart;

@property (nonatomic, strong) UIColor *black;
@property (nonatomic, strong) UIColor *white;
@property (nonatomic, strong) UIColor *gray;
@property (nonatomic, strong) UIColor *blue;
@property (nonatomic, strong) UIColor *green;
@property (nonatomic, strong) UIColor *red;
@property (nonatomic, strong) UIColor *clear;

@property (nonatomic, strong) UIColor *silver;

@property (nonatomic, strong) UIColor *darkGray;
@property (nonatomic, strong) UIColor *lightGray;

-(UIColor *)random;

@end
