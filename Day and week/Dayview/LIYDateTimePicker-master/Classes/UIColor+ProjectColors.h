//
//  UIColor+ProjectColors.h
//  LIYDateTimePickerExample
//
//  Created by Francesco Perrotti-Garcia on 9/27/14.
//  Copyright (c) 2014 Liron Yahdav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface UIColor (ProjectColors)

+ (UIColor *)currentTimeIndicatorBackgroundColor;
+ (UIColor *)dayColumnHeaderBackgroundColor;
+ (UIColor *)eventCellSelectedTextColor;
+ (UIColor *)saveButtonTitleColor;
+ (UIColor *)fixedTimeBubbleBackgroundColor;

+ (UIColor *)currentTimeGridlineBackgroundColor;
+ (UIColor *)currentTimeIndicatorTextColor;
+ (UIColor *)dayColumnHeaderAllDayBackgroundColor;
+ (UIColor *)dayColumnHeaderAllDayEventTextColor;
+ (UIColor *)dayColumnHeaderBottomBorderColor;
+ (UIColor *)eventCellShadowColor;
+ (UIColor *)eventCellUnselectedTextColor;
+ (UIColor *)fixedTimeBubbleBorderColor;
+ (UIColor *)gridlineColor;
+ (UIColor *)timeRowHeaderTitleColor;
+ (UIColor *)collectionViewBackground;
+ (UIColor *)saveButtonBackgroundColor;
+ (UIColor *)fixedTimeBubbleTextColor;
+ (UIColor *)dragBackgroundColor;
+ (UIColor *)dragTextColor;
+ (UIColor *)fixedTimeLineColor;

+ (UIColor *)dayColumnHeaderTitleBackgroundColor;
+ (UIColor *)eventCellTitleBackgroundColor;
+ (UIColor *)eventCellLocationBackgroundColor;
+ (UIColor *)timeRowHeaderTitleBackgroundColor;
+ (UIColor *)timeRowHeaderBackgroundColor;

+ (UIColor *)colorForEventBackgroundWithEvent: (EKEvent *) event selected: (BOOL) selected;


@end
