//
//  UIColor+ProjectColors.m
//  LIYDateTimePickerExample
//
//  Created by Francesco Perrotti-Garcia on 9/27/14.
//  Copyright (c) 2014 Liron Yahdav. All rights reserved.
//

#import "UIColor+ProjectColors.h"
#import "UIColor+HexString.h"

#define COLOR00 @"ffffff"
#define COLOR01 @"fd3935"
#define COLOR02 @"35b1f1"
#define COLOR03 @"21729c"
#define COLOR04 @"d0d0d0"
#define COLOR05 @"000000"
#define COLOR06 @"353535"
#define COLOR07 @"d7d7d7"
#define COLOR08 @"808080"
#define COLOR09 @"eaeaea"
#define COLOR10 @"ff8000"
#define COLOR11 @"59c7f1"
#define COLOR12 @"0000ff"
#define COLOR13 @"007fff"

#define CLEAR_COLOR [UIColor clearColor]

@implementation UIColor (ProjectColors)

#pragma mark - Color 0
+ (UIColor *)currentTimeIndicatorBackgroundColor
{
    return [UIColor colorWithHexString:COLOR00];
}

+ (UIColor *)dayColumnHeaderBackgroundColor
{
    return [UIColor colorWithHexString:COLOR00];
}

+ (UIColor *)eventCellSelectedTextColor
{
    return [UIColor colorWithHexString:COLOR00];
}

+ (UIColor *)saveButtonTitleColor
{
    return [UIColor colorWithHexString:COLOR00];
}

+ (UIColor *)fixedTimeBubbleBackgroundColor
{
    return [UIColor colorWithHexString:COLOR00];
}

#pragma mark - Color 1
+ (UIColor *)currentTimeGridlineBackgroundColor{
    return [UIColor colorWithHexString:COLOR01];
}

+ (UIColor *)currentTimeIndicatorTextColor{
    return [UIColor colorWithHexString:COLOR01];
}

#pragma mark - Color 2
+ (UIColor *)dayColumnHeaderAllDayBackgroundColor{
    return  [[UIColor colorWithHexString:COLOR02] colorWithAlphaComponent:0.2];
}

#pragma mark - Color 3
+ (UIColor *)dayColumnHeaderAllDayEventTextColor{
    return [UIColor colorWithHexString:COLOR03];
}

#pragma mark - Color 4
+ (UIColor *)dayColumnHeaderBottomBorderColor{
    return [UIColor colorWithHexString:COLOR04];
}

#pragma mark - Color 5
+ (UIColor *)eventCellShadowColor
{
    return [UIColor colorWithHexString:COLOR05];
}

#pragma mark - Color 6
+ (UIColor *)eventCellUnselectedTextColor
{
    return [UIColor colorWithHexString:COLOR06];
}

+ (UIColor *)fixedTimeBubbleBorderColor
{
    return [UIColor colorWithHexString:COLOR06];
}

#pragma mark - Color 7
+ (UIColor *)gridlineColor
{
    return [UIColor colorWithHexString:COLOR07];
}

#pragma mark - Color 8
+ (UIColor *)timeRowHeaderTitleColor
{
    return [UIColor colorWithHexString:COLOR08];
}

#pragma mark - Color 9
+ (UIColor *)collectionViewBackground
{
    return [UIColor colorWithHexString:COLOR09];
}

#pragma mark - Color 10
+ (UIColor *)saveButtonBackgroundColor
{
    return [UIColor colorWithHexString:COLOR10];
}

#pragma mark - Color 11
+ (UIColor *)fixedTimeBubbleTextColor
{
    return [UIColor colorWithHexString:COLOR11];
}

#pragma mark - Color 12
+ (UIColor *)dragBackgroundColor
{
    return [UIColor colorWithHexString:COLOR12];
}

+ (UIColor *)dragTextColor
{
    return [UIColor colorWithHexString:COLOR12];
}

#pragma mark - Color 13
+ (UIColor *)fixedTimeLineColor
{
    return  [[UIColor colorWithHexString:COLOR13] colorWithAlphaComponent:0.2];
}

#pragma mark - Clear Color

+ (UIColor *)dayColumnHeaderTitleBackgroundColor
{
    return CLEAR_COLOR;
}

+ (UIColor *)eventCellTitleBackgroundColor
{
    return CLEAR_COLOR;
}

+ (UIColor *)eventCellLocationBackgroundColor
{
    return CLEAR_COLOR;
}

+ (UIColor *)timeRowHeaderTitleBackgroundColor
{
    return CLEAR_COLOR;
}

+ (UIColor *)timeRowHeaderBackgroundColor
{
    return CLEAR_COLOR;
}

#pragma mark - Misc
+ (UIColor *)colorForEventBackgroundWithEvent: (EKEvent *) event selected: (BOOL) selected
{
    UIColor *eventColor = [UIColor colorWithCGColor:event.calendar.CGColor];
    return [eventColor colorWithAlphaComponent: selected ? 1.0 : 0.2];
}

@end
