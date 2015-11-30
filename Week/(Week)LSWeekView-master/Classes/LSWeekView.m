//
// LSWeekView.m
//
// The MIT License (MIT)
//
// Created by Christoph Zelazowski on 8/25/13.
// Copyright (c) 2012-2014 Lumen Spark LLC ( http://lumenspark.com )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import "LSWeekView.h"

#define kCellDateMarkerTag  1
#define kCellDateLabelTag   2

NSString* const CollectionViewCellId = @"WeekViewCell";


#pragma mark -


@interface LSWeekView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) LSWeekViewStyle style;

@property (nonatomic, readonly) NSArray *weekDayLabels;
@property (nonatomic, strong) UILabel *primaryDateLabel;
@property (nonatomic, strong) UILabel *secondaryDateLabel;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDate *secondarySelectedDate;
@property (nonatomic, strong) UIView *selectedDateMarker;
@property (nonatomic, strong) UILabel *selectedDateLabel;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDate *firstDateInCollectionView;
@property (nonatomic, readonly) NSIndexPath *indexPathToMiddleSection;

@property (nonatomic, strong) UIColor *originalTintColor;

@end

#pragma mark -

@implementation LSWeekView

#pragma mark - Lifecycle

/**
 Common initializer.
 */
- (void)commotInitForLSWeekView
{
    [self sizeToFit];

    // We should always have a valid selected date
    //
    self.selectedDate = [self today];

    // Initialize the collection view
    //
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;

    CGRect frame = CGRectZero;

    frame.size.width = self.collectionViewCellSize.width * 7;
    frame.size.height = self.collectionViewCellSize.height;
    frame.origin.x = (int)(CGRectGetWidth(self.frame) - CGRectGetWidth(frame)) / 2.0;
    frame.origin.y = (self.style & LSWeekViewStyleReversedDayLabels) ? 24 : 10;

    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellId];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.userInteractionEnabled = YES;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

    [self addSubview:self.collectionView];

    // Add weekday labels
    //
    if ((self.style & LSWeekViewStyleWeekDayLabelsHidden) == 0)
    {
        frame.origin.x = self.collectionView.frame.origin.x;
        frame.origin.y = (self.style & LSWeekViewStyleReversedDayLabels) ? 64 : 0;
        frame.size.width = 7 * self.collectionViewCellSize.width;
        frame.size.height = 16;

        UIView *weekDayLabelContainer = [[UIView alloc] initWithFrame:frame];
        weekDayLabelContainer.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

        NSMutableArray *weekDayLabels = [[NSMutableArray alloc] init];

        for (int i=0; i < 7; i++)
        {
            frame.origin.x = i * self.collectionViewCellSize.width;
            frame.origin.y = 0;
            frame.size.width = self.collectionViewCellSize.width;
            frame.size.height = weekDayLabelContainer.frame.size.height;

            UILabel *label = [[UILabel alloc] initWithFrame:frame];
            label.textColor = [self darkTextColor];
            label.textAlignment = NSTextAlignmentCenter;
            [weekDayLabelContainer addSubview:label];

            [weekDayLabels addObject:label];
        }

        _weekDayLabels = [weekDayLabels copy];
        [self addSubview:weekDayLabelContainer];
    }

    // Initialize the date labels
    //
    frame = CGRectMake(0, (self.style & LSWeekViewStyleReversedDayLabels) ? 5 : 54, CGRectGetWidth(self.frame), 24);

    self.primaryDateLabel = [self createDateLabelWithFrame:frame];
    self.secondaryDateLabel = [self createDateLabelWithFrame:frame];

    self.secondaryDateLabel.alpha = 0;

    [self addSubview:self.primaryDateLabel];
    [self addSubview:self.secondaryDateLabel];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [tapGestureRecognizer addTarget:self action:@selector(tapGestureAction:)];
    [self addGestureRecognizer:tapGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData)
        name:NSCurrentLocaleDidChangeNotification object:nil];
}


/**
 Returns an object initialized from data in a given unarchiver.
 */
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];

    if (self)
    {
        _style = LSWeekViewStyleDefault;
        [self commotInitForLSWeekView];
    }
    
    return self;
}


/**
 Initializes and returns a newly allocated week view object with the specified frame rectangle and default style.
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame style:LSWeekViewStyleDefault];
}


/**
 Initializes and returns a newly allocated week view object with the specified frame rectangle and style.
 */
- (instancetype)initWithFrame:(CGRect)frame style:(LSWeekViewStyle)style
{
    self = [super initWithFrame:frame];

    if (self)
    {
        _style = style;
        [self commotInitForLSWeekView];
    }

    return self;
}


/**
 Deallocates the memory occupied by the receiver.
 */
- (void)dealloc
{
    self.collectionView.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Font settings

/**
 The font used for day labels.
 */
- (UIFont *)selectedDateLabelFont
{
    if (_selectedDateLabelFont == nil)
    {
        _selectedDateLabelFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    }
    return _selectedDateLabelFont;
}


/**
 The font used for day labels.
 */
- (UIFont *)dayLabelFont
{
    if (_dayLabelFont == nil)
    {
        _dayLabelFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    }
    return _dayLabelFont;
}


/**
 The font used for weekday labels.
 */
- (UIFont *)weekdayLabelFont
{
    if (_weekdayLabelFont == nil)
    {
        _weekdayLabelFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
    }
    return _weekdayLabelFont;
}

#pragma mark - Color settings

/**
 The color used for weekday labels.
 */
- (UIColor *)darkTextColor
{
    if (_darkTextColor == nil)
    {
        _darkTextColor = [UIColor darkTextColor];
    }
    return _darkTextColor;
}


/**
 The color used for Sat and Sun day labels.
 */
- (UIColor *)grayTextColor
{
    if (_grayTextColor == nil)
    {
        _grayTextColor = [UIColor grayColor];
    }
    return _grayTextColor;
}

#pragma mark - Public methods

/**
 Animates the selected date marker to accentuate date selection.
 */
- (void)animateSelectedDateMarker
{
    UIView *dateMarker = self.selectedDateMarker;
    UILabel *dateLabel = self.selectedDateLabel;

    [UIView animateWithDuration:0.14 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^()
    {
        CATransform3D transform = CATransform3DMakeScale(1.25, 1.25, 1.0);
        dateMarker.layer.transform = transform;
        dateLabel.layer.transform = transform;
    }
    completion:^(BOOL finished)
    {
        CATransform3D transform = CATransform3DMakeScale(1.0, 1.0, 1.0);

        [UIView animateWithDuration:0.14 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^()
        {
            dateMarker.layer.transform = transform;
            dateLabel.layer.transform = transform;
        }
        completion:nil];
    }];
}


/**
 Returns the calendar used for date calculations.
 */
- (NSCalendar *)calendar
{
    if (_calendar == nil)
    {
        return [NSCalendar currentCalendar];
    }
    return _calendar;
}


/**
 Sets the selected date, optionally animating the transition.

 @param selectedDate to be set
 @param animated set to true if the transition should be animated
 @return false if the `newDate` corresponds to the same day that's already been set
 */
- (BOOL)setSelectedDate:(NSDate *)newDate animated:(BOOL)animated
{
    if ([self date:newDate fallsOnSameDayAsDate:self.selectedDate]) return NO;

    [self updateSelectedDateLabelWithDate:newDate animated:animated];

    NSDate *prevDate = self.selectedDate;
    self.selectedDate = newDate;
    self.secondarySelectedDate = nil;

    [self updateFirstDateInCollectionView];

    NSDate *dayBefore = [self dateWithDate:prevDate offsetByDays:-1];
    NSDate *dayAfter = [self dateWithDate:prevDate offsetByDays:1];

    BOOL movedByOneDay = [self date:newDate fallsOnSameDayAsDate:dayBefore] || [self date:newDate fallsOnSameDayAsDate:dayAfter];

    [self.collectionView reloadData];
    NSIndexPath *indexPath = self.indexPathToMiddleSection;

    // Update the collection view
    //
    if (animated && movedByOneDay)
    {
        NSInteger newDateWeekday = [self weekdayComponentFromDate:newDate];

        NSUInteger firstWeekday = self.calendar.firstWeekday;
        NSUInteger lastWeekday = (firstWeekday == 1) ? 7 : (firstWeekday - 1);

        if ([newDate laterDate:prevDate] == newDate && newDateWeekday == firstWeekday)
        {
            indexPath = [NSIndexPath indexPathForRow:0 inSection:self.indexPathToMiddleSection.section - 1];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];

            indexPath = self.indexPathToMiddleSection;
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
        }
        else if ([newDate earlierDate:prevDate] == newDate && newDateWeekday == lastWeekday)
        {
            indexPath = [NSIndexPath indexPathForRow:0 inSection:self.indexPathToMiddleSection.section + 1];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];

            indexPath = self.indexPathToMiddleSection;
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
        }
    }
    else
    {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
    }

    return YES;
}


/**
 Updates the view using current locale and time zone settings.
 */
- (void)reloadData
{
    self.dateFormatter = [[NSDateFormatter alloc] init];

    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEEE MMMM d yyyy" options:0 locale:[NSLocale currentLocale]];

    if ([dateFormat hasPrefix:@"EEEE, "])
    {
        dateFormat = [dateFormat stringByReplacingOccurrencesOfString:@"EEEE, " withString:@"EEEE "];
    }

    if ([dateFormat hasPrefix:@"EEEE "])
    {
        dateFormat = [dateFormat stringByReplacingOccurrencesOfString:@"EEEE " withString:@"EEEE  "];
    }

    [self.dateFormatter setTimeZone:self.calendar.timeZone];
    [self.dateFormatter setDateFormat:dateFormat];

    NSUInteger firstWeekdayIndex = self.calendar.firstWeekday - 1;

    for (int i=0; i < 7; i++)
    {
        UILabel *label = self.weekDayLabels[i];
        NSUInteger index = (i + firstWeekdayIndex) % 7;
        label.text = self.dateFormatter.veryShortStandaloneWeekdaySymbols[index];
        label.textColor = (index == 0 || index == 6) ? [self grayTextColor] : [self darkTextColor];
    }

    self.primaryDateLabel.textColor = [self darkTextColor];
    self.secondaryDateLabel.textColor = [self darkTextColor];

    [self updateSelectedDateLabelWithDate:self.selectedDate animated:NO];

    [self updateFirstDateInCollectionView];

    // Scroll to the middle section so that we can scroll left & right and thus give an illusion of "infinite" scrolling
    //
    [self.collectionView scrollToItemAtIndexPath:self.indexPathToMiddleSection
        atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];

    [self.collectionView reloadData];
}

#pragma mark - Internal methods

/**
 Returns the size of the collection view cells.
 */
- (CGSize)collectionViewCellSize
{
    return CGSizeMake(44.0, 44.0);
}

/**
 Helper method used to create a new date label.
 */
- (UILabel*)createDateLabelWithFrame:(CGRect)frame
{
    UILabel *dateLabel = [[UILabel alloc] init];

    dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.textColor = [self darkTextColor];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.frame = frame;

    return dateLabel;
}


/** 
 Returns the index of the collection view mid section.
 */
- (NSIndexPath *)indexPathToMiddleSection
{
    // We simulate infinite scrolling by setting up a collection view with N sections, where N = 2 * middleSection + 1;
    //
    // We could have a collection view with just 3 sections (middleSection = 1). When the user scrolls to the left, we shift the
    // firstDateInCollectionView by 7 days and set the collection view back to the middle section. This way when the user scrolls
    // to the left again, it gives an illusion of infinite scrolling.
    //
    // The problem with 3 sections is that if the user swipes left twice in succession, they will reach the beginning of the collection
    // view and won't be able to move left until they let go, and we manage to shift the time window.
    //
    // To mitigate this problem, we use a few more sections. The number is arbitrary. The built-in Calendar app has the same problem.
    //
    return [NSIndexPath indexPathForRow:0 inSection:2];
}


/**
 Updates the date used for the first cell in the first section, based on the currently selected date.
 */
- (void)updateFirstDateInCollectionView
{
    // Defense in-depth : we should always have a selectedDate
    //
    if (self.selectedDate == nil)
    {
        self.selectedDate = [self today];
    }

    NSInteger dayOffset = 0;
    NSInteger weekday = [self weekdayComponentFromDate:self.selectedDate];

    if (weekday > self.calendar.firstWeekday)
    {
        dayOffset = self.calendar.firstWeekday - weekday;
    }
    else if (weekday < self.calendar.firstWeekday)
    {
        dayOffset = self.calendar.firstWeekday - weekday - 7;
    }

    // We always display the middle section in the collection view
    //
    dayOffset = dayOffset - 7 * self.indexPathToMiddleSection.section;
    self.firstDateInCollectionView = [self dateWithDate:self.selectedDate offsetByDays:dayOffset];
}


/**
 Updates the selected date label, optionally animating the transition.
 */
- (void)updateSelectedDateLabelWithDate:(NSDate *)date animated:(BOOL)animated
{
    [self.primaryDateLabel setText:[self.dateFormatter stringFromDate:date]];

    if (self.accentuateSelectedDateLabel)
    {
        self.primaryDateLabel.textColor = ([self date:date fallsOnSameDayAsDate:[NSDate date]]) ? self.tintColor : [self darkTextColor];
    }

    // Update the date label
    //
    if (animated)
    {
        BOOL moveFromLeftToRight = ([self.selectedDate earlierDate:date] == date);

        // The secondary label will fade away and slide out; the primary label with the new date will slide in
        //
        [self.secondaryDateLabel setText:[self.dateFormatter stringFromDate:self.selectedDate]];

        CGFloat distance = 50;
        CABasicAnimation *animation = nil;

        animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.duration = 0.4;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.fromValue = [NSNumber numberWithFloat:moveFromLeftToRight ? -distance : distance];
        animation.toValue = [NSNumber numberWithFloat:0];
        animation.fillMode = kCAFillModeForwards;
        [self.primaryDateLabel.layer addAnimation:animation forKey:@"position"];

        animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.duration = 0.4;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.fromValue = [NSNumber numberWithFloat:0];
        animation.toValue = [NSNumber numberWithFloat:moveFromLeftToRight ? distance : -distance];
        animation.fillMode = kCAFillModeForwards;
        [self.secondaryDateLabel.layer addAnimation:animation forKey:@"position"];

        animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.duration = 0.25;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.fromValue = [NSNumber numberWithDouble:0.2];
        animation.toValue = [NSNumber numberWithDouble:0.0];
        animation.fillMode = kCAFillModeForwards;
        [self.secondaryDateLabel.layer addAnimation:animation forKey:@"opacity"];
    }
}

#pragma mark - UITapGestureRecognizer action

/**
 Navigates to a different day in response to a tap gesture.
 */
- (void)tapGestureAction:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint tapLocation = [sender locationInView:self];

        for (int i=0; i < 7; i++)
        {
            CGRect dayRect = CGRectZero;

            dayRect.origin.x = self.collectionView.frame.origin.x + i * [self collectionViewCellSize].width;
            dayRect.origin.y = self.collectionView.frame.origin.y;
            dayRect.size.width = [self collectionViewCellSize].width;
            dayRect.size.height = CGRectGetHeight(self.collectionView.frame);

            if (CGRectContainsPoint(dayRect, tapLocation))
            {
                NSInteger offset = self.indexPathToMiddleSection.section * 7 + i;
                NSDate *newDate = [self dateWithDate:self.firstDateInCollectionView offsetByDays:offset];

                if ([self date:newDate fallsOnSameDayAsDate:self.selectedDate] == NO)
                {
                    [self updateSelectedDateLabelWithDate:newDate animated:YES];
                    self.selectedDate = newDate;
                    self.secondarySelectedDate = nil;
                    [self.collectionView reloadData];

                    if (self.didChangeSelectedDateBlock)
                    {
                        self.didChangeSelectedDateBlock(self.selectedDate);
                    }
                }
                else
                {
                    [self animateSelectedDateMarker];
                }

                break;
            }
        }
    }
}

#pragma mark - NSDate Helpers

/**
 Returns a new date offset by the specified number of days.
 */
- (NSDate *)dateWithDate:(NSDate *)date offsetByDays:(NSInteger)offset
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:offset];
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}


/**
 Returns the day component for the specified date.
 */
- (NSInteger)dayComponentFromDate:(NSDate *)date
{
    NSDateComponents *components = [self.calendar components:NSDayCalendarUnit fromDate:date];
    return components.day;
}


/**
 Returns true if both dates fall on the same day.
 */
- (BOOL)date:(NSDate *)date1 fallsOnSameDayAsDate:(NSDate *)date2
{
    if (date1 == nil || date2 == nil) return NO;

    NSCalendarUnit calendarUnit = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSDateComponents *components1 = [self.calendar components:calendarUnit fromDate:date1];
    NSDateComponents *components2 = [self.calendar components:calendarUnit fromDate:date2];
    return (components1.year == components2.year && components1.month == components2.month && components1.day == components2.day);
}


/**
 Returns today's date, using the current calendar setting.
 */
- (NSDate *)today
{
    NSCalendar *localCalendar = [NSCalendar currentCalendar];

    NSDateComponents *components = [localCalendar components:
        NSDayCalendarUnit | NSMonthCalendarUnit  | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
        fromDate:[NSDate date]];

    NSDate *date = [self.calendar dateFromComponents:components];
    return date;
}


/**
 Returns the weekday component for the specified date.
 */
- (NSInteger)weekdayComponentFromDate:(NSDate *)date
{
    NSDateComponents *components = [self.calendar components:NSWeekdayCalendarUnit fromDate:date];
    return components.weekday;
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

/**
 Asks the delegate for the size of the specified item's cell.
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionViewCellSize;
}


#pragma mark - UICollectionViewDataSource methods


/**
 Asks the data source for the number of sections in the collection view.
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2 * self.indexPathToMiddleSection.section + 1;
}


/**
 Asks the data source for the number of items in the specified section.
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}


/**
 Asks the data source for the cell that corresponds to the specified item in the collection view.
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellId forIndexPath:indexPath];

    UIView *dateMarker = [cell.contentView viewWithTag:kCellDateMarkerTag];
    UILabel *dateLabel = (UILabel*)[cell.contentView viewWithTag:kCellDateLabelTag];

    if (dateLabel == nil && dateMarker == nil)
    {
        CGSize cellSize = self.collectionViewCellSize;
        CGSize markerSize = CGSizeMake(cellSize.height - 10, cellSize.height - 10);

        // Create the date marker
        //
        CGFloat x = (cellSize.width - markerSize.width) / 2.0;
        CGFloat y = (cellSize.height - markerSize.height) / 2.0;

        dateMarker = [[UIView alloc] initWithFrame:CGRectMake(x, y, markerSize.width, markerSize.height)];
        dateMarker.tag = kCellDateMarkerTag;

        if ((self.style & LSWeekViewStyleSquareDateMarkers) == 0)
        {
            dateMarker.layer.cornerRadius = markerSize.width / 2.0;
        }

        [cell.contentView addSubview:dateMarker];

        // Create the date label
        //
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cellSize.width, cellSize.height)];

        dateLabel.tag = kCellDateLabelTag;
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.backgroundColor = [UIColor clearColor];

        [cell.contentView addSubview:dateLabel];
    }

    NSInteger offset = indexPath.section * 7 + indexPath.row;
    NSDate *date = [self dateWithDate:self.firstDateInCollectionView offsetByDays:offset];
    dateLabel.text = [NSString stringWithFormat:@"%ld", (long)[self dayComponentFromDate:date]];
    dateLabel.font = self.dayLabelFont;
    
    dateMarker.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [self darkTextColor];

    NSInteger weekday = [self weekdayComponentFromDate:date];

    // We only support Gregorian calendar
    //
    if (weekday == 1 /*Sun*/ || weekday == 7 /*Sat*/)
    {
        dateLabel.textColor = [self grayTextColor];
    }

    if ([self date:date fallsOnSameDayAsDate:self.selectedDate])
    {
        self.selectedDateMarker = dateMarker;
        self.selectedDateLabel = dateLabel;
    }

    if ([self date:date fallsOnSameDayAsDate:[self today]])
    {
        BOOL isDimmed = (self.tintAdjustmentMode == UIViewTintAdjustmentModeDimmed);

        if ([self date:date fallsOnSameDayAsDate:self.selectedDate] || [self date:date fallsOnSameDayAsDate:self.secondarySelectedDate])
        {
            dateMarker.backgroundColor = isDimmed ? [self darkTextColor] : self.tintColor;
            dateLabel.textColor = [UIColor whiteColor];
        }
        else if (!isDimmed)
        {
            dateLabel.textColor = self.tintColor;
        }
    }
    else if ([self date:date fallsOnSameDayAsDate:self.selectedDate] || [self date:date fallsOnSameDayAsDate:self.secondarySelectedDate])
    {
        dateMarker.backgroundColor = [self darkTextColor];
        dateLabel.textColor = [UIColor whiteColor];
    }

    return cell;
}


#pragma mark - UIScrollViewDelegate methods

/**
 Tells the delegate when the user scrolls the content view within the receiver.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger dayOffset = 0;
    CGFloat sectionWidth = self.collectionView.frame.size.width;

    if (scrollView.contentOffset.x > self.indexPathToMiddleSection.section * sectionWidth)
    {
        dayOffset = 7;
    }
    else if (scrollView.contentOffset.x < self.indexPathToMiddleSection.section * sectionWidth)
    {
        dayOffset = -7;
    }

    NSDate *newDate = [self dateWithDate:self.selectedDate offsetByDays:dayOffset];
    self.secondarySelectedDate = newDate;
}


/**
 Tells the delegate that the scroll view has ended decelerating the scrolling movement.
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSInteger dayOffset = 0;
    CGFloat sectionWidth = self.collectionView.frame.size.width;

    if (targetContentOffset->x > self.indexPathToMiddleSection.section * sectionWidth)
    {
        dayOffset = 7;
    }
    else if (targetContentOffset->x < self.indexPathToMiddleSection.section * sectionWidth)
    {
        dayOffset = -7;
    }

    NSDate *newDate = [self dateWithDate:self.selectedDate offsetByDays:dayOffset];

    if ([self date:newDate fallsOnSameDayAsDate:self.selectedDate] == NO)
    {
        [self updateSelectedDateLabelWithDate:newDate animated:YES];

        self.secondarySelectedDate = self.selectedDate;
        self.selectedDate = newDate;
        [self.collectionView reloadData];

        if (self.didChangeSelectedDateBlock)
        {
            self.didChangeSelectedDateBlock(newDate);
        }
    }
}


/**
 Tells the delegate that the scroll view has ended decelerating the scrolling movement.
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.secondarySelectedDate = nil;
    [self updateFirstDateInCollectionView];

    [self.collectionView scrollToItemAtIndexPath:self.indexPathToMiddleSection
        atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];

    [self.collectionView reloadData];
}

#pragma mark - UIView methods

/**
 Lays out subviews.
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self reloadData];

    self.selectedDateLabel.font = self.dayLabelFont;
    self.primaryDateLabel.font = self.selectedDateLabelFont;
    self.secondaryDateLabel.font = self.selectedDateLabelFont;

    for (UILabel *label in self.weekDayLabels)
    {
        label.font = self.weekdayLabelFont;
    }
}


/**
 Returns a Boolean value indicating whether the receiver contains the specified point.
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (point.y < CGRectGetMaxY(self.collectionView.frame))
    {
        return YES;
    }
    return NO;
}


/**
 Resizes and moves the receiver view so it just encloses its subviews.
 */
- (void)sizeToFit
{
    CGRect frame = self.frame;
    frame.size = CGSizeMake(320.0, 83.0);
    self.frame = frame;
}


/**
 Called by the system when the tintColor property changes.
 */
- (void)tintColorDidChange
{
    [super tintColorDidChange];

    if (self.originalTintColor != self.tintColor)
    {
        self.originalTintColor = self.tintColor;
        [self.collectionView reloadData];
    }
}

@end
