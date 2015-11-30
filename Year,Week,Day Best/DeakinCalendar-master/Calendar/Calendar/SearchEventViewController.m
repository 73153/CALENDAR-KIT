//
//  SearchEventViewController.m
//  Calendar
//
//  Created by Peng Gao on 31/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "SearchEventViewController.h"
#import "SearchResultViewController.h"
#import "Utilities.h"
#import "EditViewController.h"

@interface SearchEventViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *eventTitle;
@property (weak, nonatomic) IBOutlet UITextField *eventKeyword;
@property (weak, nonatomic) IBOutlet UIDatePicker *fromDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *toDate;
- (IBAction)backToPrevious:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *fromDateText;
@property (weak, nonatomic) IBOutlet UITextField *endDateText;

@end

@implementation SearchEventViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // initialize all UIs
    // set font color
    [_fromDate setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    [_toDate setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    NSDateFormatter *fmt = [NSDateFormatter new];
    [fmt setDateFormat:@"dd-MMMM-yyyy"];
    
    // default date is today
    [_fromDateText setText:[fmt stringFromDate:[NSDate date]]];
    [_endDateText setText:[fmt stringFromDate:[NSDate date]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add gesture for recognizer for the text field for dismiss keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    _fromDateText.delegate = self;
    _endDateText.delegate = self;
    
}

-(void)dismissKeyboard {
    [_eventTitle resignFirstResponder];
    [_eventKeyword resignFirstResponder];
    [_fromDate setHidden:YES];
    [_toDate setHidden:YES];
}

// search event, if no result fount, gives user a hint, otherwise navigate to result controller
- (IBAction)search:(id)sender {
    
    NSArray *result = [Utilities getEventsWithTitle:_eventTitle.text description:_eventKeyword.text startDate:_fromDate.date andEndDate:_toDate.date];
    if ([result count]) {
        UIStoryboard *krisStory = [UIStoryboard storyboardWithName:@"Kris" bundle:nil];
        SearchResultViewController *svc = [krisStory instantiateViewControllerWithIdentifier:@"searchR"];
        svc.events = result;
        [self presentViewController:svc animated:YES completion:nil];

    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No result" message:@"Can't find any relate event, please check conditions" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

//navigate to result controller
- (IBAction)searchEvent:(UIButton *)sender {
    UIStoryboard *krisStory = [UIStoryboard storyboardWithName:@"Kris" bundle:nil];
    SearchEventViewController *sevc = [krisStory instantiateViewControllerWithIdentifier:@"Search"];
    
    [self presentViewController:sevc animated:YES completion:nil];
}

// add event controller
- (IBAction)addEvent:(UIButton *)sender {
    UIStoryboard *rexStory = [UIStoryboard storyboardWithName:@"Rex" bundle:nil];
    EditViewController *evc = [rexStory instantiateViewControllerWithIdentifier:@"rex.storyboard"];
    evc.createOrUpdate = Create;
    [self presentViewController:evc animated:YES completion:nil];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.fromDateText) {
        self.fromDate.hidden = NO;
        self.toDate.hidden = YES;
    }
    if (textField == self.endDateText) {
        self.toDate.hidden = NO;
        self.fromDate.hidden = YES;
    }
    return TRUE;
}


// if value changes, update text field's value
- (IBAction)fromDateValueChanged:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd-MMMM-yyyy"];
    _fromDateText.text = [formatter stringFromDate:sender.date];
    NSLog(@"Value changed");
}

- (IBAction)endDateValueChanged:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd-MMMM-yyyy"];
    _endDateText.text = [formatter stringFromDate:sender.date];
    NSLog(@"Value changed");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backToPrevious:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
