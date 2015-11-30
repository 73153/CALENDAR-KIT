//
//  ViewController.m
//  LSWeekView-Example
//
//  Created by Christoph Zelazowski on 6/16/14.
//  Copyright (c) 2014 Lumen Spark. All rights reserved.
//

#import "ViewController.h"
#import "LSWeekView.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet LSWeekView *weekView;
@property (nonatomic, weak) IBOutlet UILabel *selectedDateLabel;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.tintColor = [UIColor redColor];

    self.dateFormatter = [[NSDateFormatter alloc] init];
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEEE MMMM d yyyy" options:0 locale:[NSLocale currentLocale]];
    [self.dateFormatter setDateFormat:dateFormat];

    __weak typeof(self) weakSelf = self;
    self.weekView.didChangeSelectedDateBlock = ^(NSDate *selectedDate)
    {
        [weakSelf updateDateLabel];
    };

    [self updateDateLabel];
}

- (void)updateDateLabel
{
  self.selectedDateLabel.text = [self.dateFormatter stringFromDate:self.weekView.selectedDate];
}

- (IBAction)todayButtonAction:(id)sender
{
    NSDate *date = [NSDate date];

    if ([self.weekView setSelectedDate:date animated:YES] == NO)
    {
      [self.weekView animateSelectedDateMarker];
    }

    [self updateDateLabel];
}

@end
