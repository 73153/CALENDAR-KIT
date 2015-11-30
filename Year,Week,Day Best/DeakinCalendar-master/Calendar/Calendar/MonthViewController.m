//
//  MonthViewController.m
//  Calendar
//
//  Created by RunliSong on 01/02/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "MonthViewController.h"
#import "DayViewController.h"
#import "DaysInMonthCollectionViewCell.h"
#import "YearViewController.h"
#import "Utilities.h"
#import "EditViewController.h"
#import "ResultTableViewCell.h"
#import "EventDetailViewController.h"
#import "SearchEventViewController.h"
#import "EventTableInMonrhAndDayCell.h"

@interface MonthViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *monthCollection;
- (IBAction)backToYear:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)goToToday:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *eventTable;
@property (strong, nonatomic) IBOutlet UILabel *monthTitle;
- (IBAction)addNewEvent:(id)sender;
- (IBAction)searchEvent:(id)sender;
- (IBAction)toLastMonth:(id)sender;
- (IBAction)toNextMonth:(id)sender;
@end

@implementation MonthViewController
{
    NSMutableArray *daysarray;
    NSArray *monthName;
    YearViewController *datesInfor;
    NSString *years;
    NSString *months;
    NSString *days;
    NSDateFormatter *dateInformation;
    NSLocale *location;
    NSArray *events;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //reload collection and table view data every time the view appear
    [self.monthCollection reloadData];
    [self.eventTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // register nib
    [_eventTable registerNib:[UINib nibWithNibName:@"ResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"Result"];
    // Do any additional setup after loading the view.
    //allocte all months' name and weekdays' title into arrays
    daysarray = [[NSMutableArray alloc] init];
    monthName = [[NSArray alloc] initWithObjects:@"JANUARY",@"FEBRUARY",@"MARCH",@"APRIL",@"MAY",@"JUNE",@"JULY",@"AUGUST",@"SEPTEMBER",@"OCTOBER",@"NOVEMBER",@"DECEMBER", nil];
    [daysarray addObject:@"S"];
    [daysarray addObject:@"M"];
    [daysarray addObject:@"T"];
    [daysarray addObject:@"W"];
    [daysarray addObject:@"T"];
    [daysarray addObject:@"F"];
    [daysarray addObject:@"S"];
    dateInformation = [[NSDateFormatter alloc]init];
    [[self monthTitle]setText:monthName[_month - 1]];
    [self getDaysInMonth];
    NSString *yt = [NSString stringWithFormat:@"<%li",(long)_year];
    [_backButton setTitle:yt forState:UIControlStateNormal];
    location = [NSLocale currentLocale];
  
    
    // first date of the month
    NSString *startDateString = [NSString stringWithFormat:@"%i-%i-%i", (int)_year, (int)_month, 1];
    Utilities *ult = [Utilities new];
    
    // last date of the month
    NSString *endDateString = [NSString stringWithFormat:@"%i-%i-%i", (int)_year, (int)_month, (int)[ult getAllDaysOfMonth:(int)_month inYear:(int)_year].count];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [formatter dateFromString:startDateString];
    NSDate *endDate = [formatter dateFromString:endDateString];
    // get all events in this month
    events = [Utilities getEventsBetweenDate:startDate andEndDate:endDate];
    _eventTable.backgroundColor = [UIColor clearColor];
    [[self monthCollection]setDataSource:self];
    [[self monthCollection]setDelegate:self];
    [[self eventTable]setDataSource:self];
    [[self eventTable]setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//get all days in a month and formating them
-(NSMutableArray *)getDaysInMonth {
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:(int)_month inYear:(int)_year];
    NSString *placeHolder = @" ";
    for (int i = 0; i < arr.count; i++) {
        
        NSDateComponents *component = [arr objectAtIndex:i];
        if ((int)component.day == 1) {
            int day = (int)component.weekday;
            
            for (int j = 1; j < day; j++) {
                [daysarray addObject:placeHolder];
            }
            [daysarray addObject:[NSString stringWithFormat:@"%i", (int)component.day]];
        }
        else
            [daysarray addObject:[NSString stringWithFormat:@"%i", (int)component.day]];
        
    }
    
    return daysarray;
}
#pragma mark collection view methods
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:(int)_month inYear:(int)_year];
    NSInteger totalDays = 0;
    totalDays += 7;
    totalDays += [arr count];
    totalDays += ((NSDateComponents *)[arr objectAtIndex:0]).weekday - 1;
    return totalDays;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    DayViewController *dvc = [story instantiateViewControllerWithIdentifier:@"dayViewController"];
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:(int)_month inYear:(int)_year];
    NSInteger selected = indexPath.item - 7 - ((NSDateComponents *)[arr objectAtIndex:0]).weekday +2;
    if(selected >0)
    {
        NSString *selectDateString = [NSString stringWithFormat:@"%i-%i-%i", (int)_year, (int)_month, (int)selected];
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *selectDate = [formatter dateFromString:selectDateString];
        dvc.pickedDate = selectDate;
        [self presentViewController:dvc animated:YES completion:nil];
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cellidentifer = @"day";
    DaysInMonthCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:Cellidentifer forIndexPath:indexPath];
    [[cell dayName]setText:[daysarray objectAtIndex:indexPath.item]];
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((_monthCollection.frame.size.width / 7 - 5), (_monthCollection.frame.size.height / 6));
}

#pragma mark table view methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //should be number of events;
    if(events.count != 0)
        return [events count];
    else
        return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // display all events if there are any events in the month
    if (events.count != 0) {
        
        ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Result" forIndexPath:indexPath];

        cell.backgroundColor = [UIColor clearColor];
        cell.eventTitle.text = ((Event *)[events objectAtIndex:indexPath.row]).title;
        NSDate *localTime = ((Event *)[events objectAtIndex:indexPath.row]).localTime;
        NSDate *otherTime = ((Event *)[events objectAtIndex:indexPath.row]).otherTime;
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MMMM-dd hh:mm a"];
        cell.eventLocalTime.text = [formatter stringFromDate:localTime];
        
        if (otherTime) {
            [cell.eventOtherTime setHidden:NO];
            cell.eventOtherTime.text = [formatter stringFromDate:otherTime];
        }
        else {
            [cell.eventOtherTime setHidden:YES];
        }
        
        return cell;
    }
    else {
        //if no event in the month then just display an empty message
        EventTableInMonrhAndDayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCellMonth" forIndexPath:indexPath];
        
        [[cell myMonthEvent]setText:[NSString stringWithFormat:@"No event has been store yet..." ]];
        
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (events.count != 0) {
        UIStoryboard *krisStoryboard = [UIStoryboard storyboardWithName:@"Kris" bundle:nil];
        EventDetailViewController *edvc = (EventDetailViewController *)[krisStoryboard instantiateViewControllerWithIdentifier:@"EventDetail"];
        edvc.event = [events objectAtIndex:indexPath.row];
        [self presentViewController:edvc animated:YES completion:nil];
    }
    
    
}



//text of back to year button is the year of the month and will be change when month change
- (IBAction)backToYear:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    YearViewController *yvc = [story instantiateViewControllerWithIdentifier:@"yearController"];
    yvc.currentYear = _year;
    [self presentViewController:yvc animated:YES completion:nil];

}
//same function with in YearView
- (IBAction)goToToday:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    DayViewController *dvc = [story instantiateViewControllerWithIdentifier:@"dayViewController"];
    NSDate *sysdate = [NSDate date];
    [dateInformation setDateFormat:@"yyyy"];
    years = [dateInformation stringFromDate:sysdate];
    [dateInformation setDateFormat:@"M"];
    months = [dateInformation stringFromDate:sysdate];
    [dateInformation setDateFormat:@"dd"];
    days = [dateInformation stringFromDate:sysdate];
    NSLog(@"year %@,month%@,day%@",years,months,days);
    NSInteger nowyear = [years integerValue];
    NSInteger nowMonth = [months integerValue];
    NSInteger nowDay = [days integerValue];
    long week;
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:(int)nowMonth inYear:(int)nowyear];
    for (int g = 0; g<arr.count; g++) {
        if(((NSDateComponents *)[arr objectAtIndex:g]).day == nowDay)
        {
            week = ((NSDateComponents *)[arr objectAtIndex:g]).weekday;
        }
        
    }
    dvc.weekdaytitle = week;
    dvc.datenum = nowDay;
    dvc.monthTitle = monthName[nowMonth -1];
    dvc.monthOfTheDay = nowMonth;
    dvc.yearOfTheDay = nowyear;
    [self presentViewController:dvc animated:YES completion:nil];
}

- (IBAction)addNewEvent:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Rex" bundle:nil];
    EditViewController *sevc = [story instantiateViewControllerWithIdentifier:@"rex.storyboard"];
    [self presentViewController:sevc animated:YES completion:nil];
}

- (IBAction)searchEvent:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Kris" bundle:nil];
    SearchEventViewController *sevc = [story instantiateViewControllerWithIdentifier:@"Search"];
    
    [self presentViewController:sevc animated:YES completion:nil];

}
//change month to previous month
- (IBAction)toLastMonth:(id)sender {
    _month = _month - 1;
    if (_month<1)
    {
        _month = 12;
        _year = _year -1;
        NSString *ys = [NSString stringWithFormat:@"%i",(int)_year];
         [_backButton setTitle:ys forState:UIControlStateNormal];
    
    }
    [[self monthTitle]setText:monthName[_month - 1]];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    MonthViewController *mvc = [story instantiateViewControllerWithIdentifier:@"monthViewController"];
    mvc.year = _year;
    mvc.month = _month;
    [self presentViewController:mvc animated:NO completion:nil];
}

- (IBAction)toNextMonth:(id)sender {
    _month = _month + 1;
    if (_month>12)
    {
        _month = 1;
        _year = _year + 1;
        NSString *ys = [NSString stringWithFormat:@"%i",(int)_year];
        [_backButton setTitle:ys forState:UIControlStateNormal];

    }
    [[self monthTitle]setText:monthName[_month - 1]];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    MonthViewController *mvc = [story instantiateViewControllerWithIdentifier:@"monthViewController"];
    mvc.year = _year;
    mvc.month = _month;
    [self presentViewController:mvc animated:NO completion:nil];

}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
