//
//  CalendarViewController.m
//  playaround
//
//  Created by Yingang Xue on 6/23/14.
//  Copyright (c) 2014 Yingang Xue. All rights reserved.
//

#import "CalendarViewController.h"
#import "DayCell.h"
#import "MonthCell.h"

#define DAY_VIEW_TAG 1
#define MONTH_VIEW_TAG 0

@interface CalendarViewController ()

@end

@implementation CalendarViewController

@synthesize monthsView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentMonth = 7;
        currentYear = 2014;
        cellViewMonth = currentMonth;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // navi bar
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu)];
    
    [self.navigationItem setLeftBarButtonItem:menuButton];
    
    //months
    float mx = 0;
    float my = 49;
    float mw = 320;
    float mh = 25+25*6;
    CGRect monthRect = CGRectMake(mx, my, mw, mh);
    UICollectionViewFlowLayout *monthFlowlayout = [[UICollectionViewFlowLayout alloc] init];
    [monthFlowlayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    monthsView = [[UICollectionView alloc] initWithFrame:monthRect collectionViewLayout:monthFlowlayout];
    [monthsView registerClass:[MonthCell class] forCellWithReuseIdentifier:@"MonthCell"];
    
    monthsView.backgroundColor=[UIColor whiteColor];
    
    monthsView.delegate=self;
    monthsView.dataSource=self;
    monthsView.pagingEnabled = YES;
    monthsView.tag = MONTH_VIEW_TAG;
    [monthsView setShowsHorizontalScrollIndicator:NO];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [monthsView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    [self.view addSubview:monthsView];
    
    //progress view
    cp = [[CircleProgressView alloc] initWithFrame:CGRectMake(0, 225, 320, 255)];
    [cp setLineWidth:10.0f];
    cp.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openMenu
{}

-(NSDate*)firstDateOfCurrentMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *aDateComp = [[NSDateComponents alloc] init];
    [aDateComp setYear:currentYear];
    [aDateComp setMonth:currentMonth];
    [aDateComp setDay:1];
    NSDate *aDate = [calendar dateFromComponents:aDateComp];
    NSDate *aDateLocale = [aDate dateByAddingTimeInterval:[[NSTimeZone localTimeZone] secondsFromGMTForDate:aDate]];
    
    return aDateLocale;
}

- (NSArray*)getDayCellsOfMonth:(int)year month:(int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *aDateComp = [[NSDateComponents alloc] init];
    [aDateComp setYear:year];
    [aDateComp setMonth:month];
    [aDateComp setDay:1];
    NSDate *aDate = [calendar dateFromComponents:aDateComp];
    NSDate *aDateLocale = [aDate dateByAddingTimeInterval:[[NSTimeZone localTimeZone] secondsFromGMTForDate:aDate]];
    //NSLog(@"%@", [aDateLocale description]);
    int startWeekDay = [calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:aDateLocale];
    //NSLog(@"%d", startWeekDay);
    //获取这一个月的天数
    NSRange dayRange = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:aDateLocale];
    //NSLog(@"%d to %d", dayRange.location, dayRange.length);
   // NSRange weekRange = [calendar rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:aDateLocale];
    //NSLog(@"%d to %d", weekRange.location, weekRange.length);
    
    numberOfDays = dayRange.length;
   // numberOfWeeks = weekRange.length; //定死6周，固定高度
    
    int dayEntriesTotal = 6 * 7;
    NSMutableArray *dayEntries = [[NSMutableArray alloc] init];
    
    int dayEntryCount=0;
    //1号以前
    for(int j=1; j<startWeekDay; j++, dayEntryCount++)//startweekday = 2, 1号是星期一
    {
        NSDate *dayOfPerviousMonth = [aDateLocale dateByAddingTimeInterval:-(24*60*60*(startWeekDay-j))];
        NSMutableDictionary *dayEntryDic = [[NSMutableDictionary alloc] init];
        [dayEntryDic setObject:@"NO" forKey:@"inMonth"];
        [dayEntryDic setObject:dayOfPerviousMonth forKey:@"date"];
        [dayEntries addObject:dayEntryDic];
    }
    //当月
    for(int j=1; j<=numberOfDays; j++, dayEntryCount++)
    {
        NSDateComponents *cellDateComp = [[NSDateComponents alloc] init];
        [cellDateComp setYear:year];
        [cellDateComp setMonth:month];
        [cellDateComp setDay:j];
        NSDate *cellDate = [calendar dateFromComponents:cellDateComp];
        NSDate *cellDateLocale = [cellDate dateByAddingTimeInterval:[[NSTimeZone localTimeZone] secondsFromGMTForDate:cellDate]];
        NSMutableDictionary *dayEntryDic = [[NSMutableDictionary alloc] init];
        [dayEntryDic setObject:@"YES" forKey:@"inMonth"];
        [dayEntryDic setObject:cellDateLocale forKey:@"date"];
        [dayEntries addObject:dayEntryDic];
    }
    //下个月
    for(; dayEntryCount<dayEntriesTotal; dayEntryCount++)
    {
        NSDate *endDay = [[[dayEntries objectAtIndex:(dayEntryCount-1)] objectForKey:@"date"] dateByAddingTimeInterval:(24*60*60)];
        NSMutableDictionary *dayEntryDic = [[NSMutableDictionary alloc] init];
        [dayEntryDic setObject:@"NO" forKey:@"inMonth"];
        [dayEntryDic setObject:endDay forKey:@"date"];
        [dayEntries addObject:dayEntryDic];
    }
    return dayEntries;
}

#pragma mark - UICollectionView Datasource
// number of items
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    if(view.tag == DAY_VIEW_TAG)
    {
        return [cellsInMonth[section] count];
    }else{
        return 3;
    }
}
// 2 sections , 1 for Sun ~ Sat , 1 for day cells
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    if(collectionView.tag == DAY_VIEW_TAG)
    {
        return [cellsInMonth count];
    }else{
        return 1;
    }
}
// 3 显示cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(cv.tag == DAY_VIEW_TAG)
    {
        DayCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"DayCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        
        if(indexPath.section == 0)
        {
            NSString *weekName = [[cellsInMonth objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            [cell setDayLabelText:weekName];
            [cell.dayLabel setBackgroundColor:[UIColor greenColor]];
            cell.validMonthDay = NO;
        }else{
            NSDate *day = [[[cellsInMonth objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"date"];
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"d"];
            [cell setDayLabelText:[format stringFromDate:day]];
            
            NSString *inMonth = [[[cellsInMonth objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"inMonth"];
            if([inMonth isEqualToString:@"NO"]){
                [cell.dayLabel setEnabled:FALSE];
                cell.validMonthDay = NO;
            }else{
                cell.validMonthDay = YES;
            }
        }
        
        return cell;
    }else{
        MonthCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MonthCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        [tmp addObject:[[NSArray alloc] initWithObjects:@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat", nil]];
        [tmp addObject:[self getDayCellsOfMonth:currentYear month:cellViewMonth]];
        cellsInMonth = tmp;
        
        // calendar
        [cell.calendarView registerClass:[DayCell class] forCellWithReuseIdentifier:@"DayCell"];
        
        cell.calendarView.delegate=self;
        cell.calendarView.dataSource=self;
        cell.calendarView.tag = DAY_VIEW_TAG;
        
        //长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressOnDayCell:)];
        longPress.allowableMovement = NO;
        longPress.minimumPressDuration = 0.5f;
        [cell.calendarView addGestureRecognizer:longPress];
        
        
        [cell.contentView addSubview:cell.calendarView];
        //修改导航的title为当月日期
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"YYYY MMM"];
        self.navigationItem.title = [format stringFromDate:[self firstDateOfCurrentMonth]];

        return cell;
    }
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    
    if(collectionView.tag == DAY_VIEW_TAG){
        DayCell *cell = (DayCell*)[collectionView cellForItemAtIndexPath:indexPath];
        if(cell.validMonthDay)
        {
            cell.dayLabel.backgroundColor = [UIColor blueColor];
        }
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Deselect item
    
    if(collectionView.tag == DAY_VIEW_TAG){
        DayCell *cell = (DayCell*)[collectionView cellForItemAtIndexPath:indexPath];
        if(cell.validMonthDay)
        {
            cell.dayLabel.backgroundColor = [UIColor whiteColor];
        }
    }
}
#pragma mark – UICollectionViewDelegateFlowLayout

// set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == DAY_VIEW_TAG)
    {   //天cell的大小
        CGSize retval = CGSizeMake(45, 25);
        if(indexPath.section == 0)
        {
            retval = CGSizeMake(45, 25);
        }
        return retval;
    }else{
        //月cell的大小
        CGSize retval = CGSizeMake(320, 25+25*6);
        return retval;
    }
}

// set margin
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
// column spacing
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0f;
}
// line spacing
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}
//scroll
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //每次滚动前重置判断
    scrollDirectionDetermined = NO;
}
//这个函数一边滚动一边会被调用，所以有个标志去判断是不是已经确定方向
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.tag != MONTH_VIEW_TAG)
        return;
    CGPoint v = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    //Fix me: 这里还是有问题的，先往右拖一点，然后猛的往左滑动，会出现错误
    if(v.x == 0.0f)
    {  
        scrollDirectionDetermined = NO;
        cellViewMonth = currentMonth;
    }
    if(scrollDirectionDetermined == NO){
        //判断滚动方向
        if (v.x > 0.0f) {
            //scrolling rightwards
            cellViewMonth--;
            scrollDirectionDetermined = YES;
        } else if(v.x < 0.0f) {
            //scrolling leftwards
            cellViewMonth++;
            scrollDirectionDetermined = YES;
        }
    }
    
    
}
//滚动完毕调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView.tag != MONTH_VIEW_TAG)
        return;
    //判断是不是切换了cell，如果有，就重新赋值当前月份，否的反过来赋值
    float contentOffsetWhenFullyScrolledRight = monthsView.frame.size.width * (3-1);
    if(scrollView.contentOffset.x==0.0f || scrollView.contentOffset.x == contentOffsetWhenFullyScrolledRight)
    {
        currentMonth = cellViewMonth;
    }else{
        cellViewMonth = currentMonth;
    }
    NSLog(@"current month: %d", currentMonth);
    NSLog(@"cell view month: %d", cellViewMonth);
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    
    [monthsView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    [monthsView reloadData];
    scrollDirectionDetermined = NO;
}

#pragma mark – CircleProgressViewDelegate

- (void)didFinishProgressing:(CircleProgressView*)cpv
{
    NSLog(@"got to add view");
    [cpv removeFromSuperview];
}

#pragma mark – Long press
- (void)longPressOnDayCell:(id)sender
{
    if([(UILongPressGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan)
    {
        MonthCell *cell = (MonthCell*)[monthsView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
        CGPoint p = [(UILongPressGestureRecognizer*)sender locationInView:cell.calendarView];
        
        NSIndexPath *indexPath = [cell.calendarView indexPathForItemAtPoint:p];
        DayCell *day = (DayCell*)[cell.calendarView cellForItemAtIndexPath:indexPath];
        
        int dayInt = [day.dayLabel.text intValue];
        if(dayInt >0 && YES == day.validMonthDay)
        {
            NSLog(@"%d-%d-%d", currentYear, currentMonth, dayInt);
            [self.view addSubview:cp];
            [cp startTimer];
        }
    }
    
    if([(UILongPressGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged ||
       [(UILongPressGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded )
    {
        [cp stopTimer];
        [cp removeFromSuperview];
    }
}



@end
