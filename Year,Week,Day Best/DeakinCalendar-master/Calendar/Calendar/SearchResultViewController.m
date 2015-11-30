//
//  SearchResultViewController.m
//  Calendar
//
//  Created by Peng Gao on 4/02/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "SearchResultViewController.h"
#import "ResultTableViewCell.h"
#import "Utilities.h"
#import "EventDetailViewController.h"
#import "EditViewController.h"
#import "SearchEventViewController.h"
#import "DayViewController.h"

@interface SearchResultViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.backgroundColor = [UIColor clearColor];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView setDelegate: self];
    [self.tableView setDataSource: self];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"Result"];
    
    //_events = [Utilities getAllEvents];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_events count];
}
- (IBAction)searchEvent:(UIButton *)sender {
    UIStoryboard *krisStory = [UIStoryboard storyboardWithName:@"Kris" bundle:nil];
    SearchEventViewController *sevc = [krisStory instantiateViewControllerWithIdentifier:@"Search"];
    
    [self presentViewController:sevc animated:YES completion:nil];
}

- (IBAction)addEvent:(UIButton *)sender {
    UIStoryboard *rexStory = [UIStoryboard storyboardWithName:@"Rex" bundle:nil];
    EditViewController *evc = [rexStory instantiateViewControllerWithIdentifier:@"rex.storyboard"];
    evc.createOrUpdate = Create;
    [self presentViewController:evc animated:YES completion:nil];
}

- (IBAction)backToPrevious:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToday:(UIButton *)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    DayViewController *dvc = [story instantiateViewControllerWithIdentifier:@"dayViewController"];
    
    NSDate *sysdate = [NSDate date];
    NSLog(@"%@",sysdate);
    NSDateFormatter *dateInformation = [[NSDateFormatter alloc]init];
    [dateInformation setDateFormat:@"yyyy"];
    NSString* years = [dateInformation stringFromDate:sysdate];
    [dateInformation setDateFormat:@"M"];
    NSString* months = [dateInformation stringFromDate:sysdate];
    [dateInformation setDateFormat:@"dd"];
    NSString* days = [dateInformation stringFromDate:sysdate];
    
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
    dvc.monthOfTheDay = nowMonth;
    dvc.yearOfTheDay = nowyear;
    [self presentViewController:dvc animated:YES completion:nil];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Result" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.eventTitle.text = ((Event *)[_events objectAtIndex:indexPath.row]).title;
    // Configure the cell...
    NSDate *localTime = ((Event *)[_events objectAtIndex:indexPath.row]).localTime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMMM-yyyy hh:mm a"];
    cell.eventLocalTime.text = [formatter stringFromDate:localTime];
    
    NSDate *otherTime = ((Event *)[_events objectAtIndex:indexPath.row]).otherTime;
    if (otherTime) {
        [cell.eventOtherTime setHidden:NO];
        NSString *otherTimeString = [formatter stringFromDate:otherTime];
        NSString *otherName = ((Event *)[_events objectAtIndex:indexPath.row]).otherName;
        if (otherTime) {
            otherTimeString = [otherTimeString stringByAppendingString:[NSString stringWithFormat:@"%c%@", 64, otherName]];
            
        }
        cell.eventOtherTime.text = otherTimeString;
    } else {
        [cell.eventOtherTime setHidden:YES];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"%@", [_events objectAtIndex:indexPath.row]);
    
    UIStoryboard *krisStoryboard = [UIStoryboard storyboardWithName:@"Kris" bundle:nil];
    EventDetailViewController *edvc = (EventDetailViewController *)[krisStoryboard instantiateViewControllerWithIdentifier:@"EventDetail"];
    edvc.event = [_events objectAtIndex:indexPath.row];
    [self presentViewController:edvc animated:YES completion:nil];
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
