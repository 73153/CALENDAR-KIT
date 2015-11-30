//
//  FDColor.m
//  iBolter
//
//  Created by Dong Yiming on 1/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
// Because crayons are fun! Full list of colors:
// http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors
//

#import "FDColor.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation FDColor
DEF_SINGLETON(FDColor)

- (id)init
{
    self = [super init];
    if (self) {
        _magicMint = [UIColor colorWithCrayola:@"Magic Mint"];
        _midnightBlue = [UIColor colorWithCrayola:@"Midnight Blue"];
        _orangeRed = [UIColor colorWithCrayola:@"Orange Red"];
        _themeBlue = [UIColor colorWithRed:(20 / 255.f) green:(155 / 255.f) blue:(201 / 255.f) alpha:1.f];
        _caribbeanGreen = _themeBlue;//[UIColor colorWithCrayola:@"Caribbean Green"];

        _desertSand = [UIColor colorWithCrayola:@"Desert Sand"];
        _purpleHeart = [UIColor colorWithCrayola:@"Purple Heart"];
        _blueSapphire = [UIColor colorWithHexString:@"2D5DA1"];
        
        _black = [UIColor blackColor];
        _white = [UIColor whiteColor];
        _gray = [UIColor grayColor];
        _blue = [UIColor blueColor];
        _green = [UIColor greenColor];
        _red = [UIColor redColor];
        _clear = [UIColor clearColor];
        
        _silver = [UIColor colorWithHexString:@"EFEFEF"];
        
        _darkGray = UIColorFromRGB(0x333333);
        _lightGray = UIColorFromRGB(0x999999);
    }
    return self;
}

-(UIColor *)colorFromR:(int)aRed g:(int)aGreen b:(int)aBlue
{
    return [UIColor colorWithRed:aRed / 255.f green:aGreen / 255.f blue:aBlue / 255.f alpha:1.f];
}

-(UIColor *)random
{
    return [self colorFromR:(arc4random() % 255) g:(arc4random() % 255) b:(arc4random() % 255)];
}

@end
