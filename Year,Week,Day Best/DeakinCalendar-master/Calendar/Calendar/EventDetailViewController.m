//
//  EventDetailViewController.m
//  Calendar
//
//  Created by Peng Gao on 29/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "EventDetailViewController.h"
#import "Event.h"
#import "EditViewController.h"
#import "Utilities.h"
#import "DayViewController.h"

@interface EventDetailViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UITextView *eventDesc;

@property (weak, nonatomic) IBOutlet UILabel *eventTime;


@property (weak, nonatomic) IBOutlet UILabel *eventOtherTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherZoneName;
@property (weak, nonatomic) IBOutlet UILabel *otherZonetime;


@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_event) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Event" message:@"Please check detail" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMMM-yyyy hh:mm a"];
    _eventTitle.text = ((Event *)_event).title;
    _eventDesc.text = ((Event *)_event).desc;
    _eventTime.text = [formatter stringFromDate:((Event *)_event).localTime];
    
    if (!((Event *)_event).otherTime) {
        [_eventOtherTimeLabel setHidden:YES];
        [_otherZoneName setHidden:YES];
        [_otherZonetime setHidden:YES];
    }
    else {
        [_otherZonetime setHidden:NO];
        [_otherZoneName setHidden:NO];
        [_eventOtherTimeLabel setHidden:NO];
        NSDate *otherTime = ((Event *)_event).otherTime;
        _otherZonetime.text = [formatter stringFromDate:otherTime];
        _otherZoneName.text = ((Event *)_event).otherName;
    }
    
}


- (IBAction)backToPrevious:(UIButton *)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    DayViewController *dvc = [story instantiateViewControllerWithIdentifier:@"dayViewController"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd-MM-yyyy hh:mm a"];
    dvc.pickedDate = ((Event *)_event).localTime;
    [self presentViewController:dvc animated: YES completion:nil];
    
    // back to year view
}
- (IBAction)editEvent:(UIButton *)sender {
    UIStoryboard *rexStoryboard = [UIStoryboard storyboardWithName:@"Rex" bundle:nil];
    EditViewController *evc = [rexStoryboard instantiateViewControllerWithIdentifier:@"rex.storyboard"];
    evc.createOrUpdate = Update;
    evc.eventNeesToUpdate = _event;
    [self presentViewController:evc animated:YES completion:nil];
    
}
- (IBAction)deleteEvent:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"You want to delete this event?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
        [Utilities deleteEvent:_event];
        
        // should back to year view
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
