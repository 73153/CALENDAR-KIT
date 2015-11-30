//
//  TBScheduleViewController.m
//  ToDoIt
//
//  Created by pin on 13-10-4.
//  Copyright (c) 2013年 dingyi. All rights reserved.
//

#import "TBScheduleViewController.h"
#import "NSCalendarCategories.h"
#import "NSDate+Components.h"
#import "NSString+Color.h"
#import <QuartzCore/QuartzCore.h>

@interface TBScheduleViewController ()<CKCalendarViewDelegate, CKCalendarViewDataSource>
    @property (nonatomic, strong) NSMutableDictionary *data;
    @property (nonatomic, strong) UIButton *doneButton;
    @property (nonatomic, strong) UIButton *deleteButton;
    @property (nonatomic, strong) UIButton *cancelButton;
    @property (nonatomic, strong) UIView *operationView;
    @property (nonatomic, strong) UITableViewCell *operationCell;
@end

@implementation TBScheduleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 1. Instantiate a CKCalendarView
    CKCalendarView *calendar = [CKCalendarView new];
    
    // 2. Optionally, set up the datasource and delegates
    [calendar setDelegate:self];
    [calendar setDataSource:self];
    
    // 3. Present the calendar
    [[self view] addSubview:calendar];
    
    // 4. Init operate view for table cell
    [self initOperateButtonAndView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initOperateButtonAndView
{
    int buttonFontSize = 13;
    int buttonCornerRadius = 8;
    
    _doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _doneButton.layer.cornerRadius = buttonCornerRadius;
    _doneButton.clipsToBounds = YES;
    _doneButton.titleLabel.font = [UIFont boldSystemFontOfSize: buttonFontSize];
    [_doneButton setBackgroundColor:[@"#A7C067" toColor]];
    [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _deleteButton.layer.cornerRadius = buttonCornerRadius;
    _deleteButton.clipsToBounds = YES;
    _deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize: buttonFontSize];
    [_deleteButton setBackgroundColor:[@"#D96C64" toColor]];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _cancelButton.layer.cornerRadius = buttonCornerRadius;
    _cancelButton.clipsToBounds = YES;
    _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize: buttonFontSize];
    [_cancelButton setBackgroundColor:[@"#7D7D7B" toColor]];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    _operationView = [UIView new];
    
    [[self operationView] addSubview:[self doneButton]];
    [[self operationView] addSubview:[self deleteButton]];
    [[self operationView] addSubview:[self cancelButton]];
}

- (void)cancelClick
{
    [UIView transitionWithView:self.operationCell duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^
     {
         [[self operationView] removeFromSuperview];
         
     } completion:^(BOOL finished){}];
}

#pragma mark - CKCalendarViewDataSource

- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date
{
    //对date进行过滤判断，只对含有事件的日期添加事件 需要后台请求date下的任务纪录api 此处一定要做缓存！
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    NSString *dStr = [dateFormatter stringFromDate:date];

    NSMutableArray *muArray = [[NSMutableArray alloc]initWithCapacity:1];
    NSArray *array = [[NSArray alloc]init];
    if ([dStr isEqualToString:[dateFormatter stringFromDate:[NSDate date]]]) {
        for (int i=0; i<4; i++) {
            NSString *title = [NSString stringWithFormat:@"任务中心卖家任务%d",i];
            CKCalendarEvent *event = [CKCalendarEvent eventWithTitle:title andDate:date andInfo:nil];
            [muArray addObject:event];
        }
    }
    array = muArray;
    return array;
}

#pragma mark - CKCalendarViewDelegate

// Called before/after the selected date changes
- (void)calendarView:(CKCalendarView *)CalendarView willSelectDate:(NSDate *)date
{
    NSLog(@"do 1");
}

- (void)calendarView:(CKCalendarView *)CalendarView didSelectDate:(NSDate *)date
{
    NSLog(@"do 2");
}

//  A row is selected in the events table. (Use to push a detail view or whatever.)
- (void)calendarView:(CKCalendarView *)CalendarView didSelectEvent:(CKCalendarEvent *)event withCell:(UITableViewCell *)cell
{
    // Set operationCell
    _operationCell = cell;
    
    // init operate cell panel
    [self setOperationCellPanel:cell];
    
    // show operate cell with animation
    [UIView transitionWithView:cell duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^
     {
         [cell addSubview:[self operationView]];
         
     } completion:^(BOOL finished){}];
}

- (void) setOperationCellPanel:(UITableViewCell *)cell
{
    CGRect operationFrame = cell.frame;
    operationFrame.origin.x = 0;
    operationFrame.origin.y = -1;
    [self operationView].frame = operationFrame;
    [[self operationView] setBackgroundColor:[UIColor whiteColor]];
    
    int buttonWidth = 50;
    int buttonHeight = 30;
    int vInsets = (cell.frame.size.height-buttonHeight)/2;
    int hInsets = 50;
    // Insets between two buttons
    int buttonInsets = 30;
    
    CGRect doneFrame = CGRectMake(hInsets, vInsets, buttonWidth, buttonHeight);
    [self doneButton].frame = doneFrame;
    
    CGRect deleteFrame = CGRectMake(doneFrame.origin.x+buttonWidth+buttonInsets, vInsets, buttonWidth, buttonHeight);
    [self deleteButton].frame = deleteFrame;
    
    CGRect cancelFrame = CGRectMake(deleteFrame.origin.x+buttonWidth+buttonInsets, vInsets, buttonWidth, buttonHeight);
    [self cancelButton].frame = cancelFrame;
}


@end
