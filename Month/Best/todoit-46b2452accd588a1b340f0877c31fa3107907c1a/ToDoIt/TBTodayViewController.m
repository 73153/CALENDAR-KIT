//
//  TBTodayViewController.m
//  ToDoIt
//
//  Created by pin on 13-10-8.
//  Copyright (c) 2013年 dingyi. All rights reserved.
//

#import "TBTodayViewController.h"
#import "CKCalendarEvent.h"
#import "TBTaskTableViewController.h"
#import "NSString+Color.h"

@interface TBTodayViewController () <TBTaskTableDataSource>

@end

@implementation TBTodayViewController

// Init from storyboard
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        // Do something
        [super setDataSource:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TBTaskTableDataSource

- (NSArray *)tableViewData
{
    //对date进行过滤判断，只对含有事件的日期添加事件 需要后台请求date下的任务纪录api 此处一定要做缓存！
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    NSString *dStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSMutableArray *muArray = [[NSMutableArray alloc]initWithCapacity:1];
    NSArray *array = [[NSArray alloc]init];
    if ([dStr isEqualToString:[dateFormatter stringFromDate:[NSDate date]]]) {
        for (int i=0; i<4; i++) {
            NSString *title = [NSString stringWithFormat:@"任务中心卖家任务%d",i];
            CKCalendarEvent *event = [CKCalendarEvent eventWithTitle:title andDate:[NSDate date] andInfo:nil];
            [muArray addObject:event];
        }
    }
    array = muArray;
    return array;
}



@end
