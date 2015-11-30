//
//  CKCalendarEventViewController.m
//  MBCalendarKit
//
//  Created by Luis Fernando De Pombo on 12/3/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "NewCKCalendarEventViewController.h"
#import "CKCalendarViewControllerInternal.h"
#import "NewCKCalendarEventView.h"
#import "NSDate+Components.h"

@interface NewCKCalendarEventViewController ()


@property (weak, nonatomic) IBOutlet UILabel *date;
- (IBAction)postButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *titl;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *description;
@property (strong, nonatomic) IBOutlet NewCKCalendarEventView *view;



@end


@implementation NewCKCalendarEventViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         }
    return self;
}

- (IBAction)exitBttn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil NSDate:(NSDate *)date bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:kCFCalendarUnitDay | kCFCalendarUnitMonth | kCFCalendarUnitYear fromDate:date];
        NSInteger day = [components day];
        NSInteger month = [components month];
        NSInteger year = [components year];
        self.eventDate = [NSDate dateWithDay:day month:month year:year];
        // Custom initialization
//        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

UIGestureRecognizer *tap;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:self.eventDate];
    self.date.text = dateString;
    NSLog(@"loaded");
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
	// Do any additional setup after loading the view.
}

- (void) dismissKeyboard {
    [self.view endEditing:YES];
}


-(IBAction)postButton:(id)sender
{
    NSLog(@"post button pressed");
    //if (![self.location.text isEqualToString:@""] && ![self.description.text isEqualToString:@""]){
        
   // }
   // else if(![self])
    NSDictionary * info = [[NSDictionary alloc] initWithObjectsAndKeys:@"location",self.location.text, @"description", self.description.text, nil];
    
    self.event = [CKCalendarEvent eventWithTitle:self.titl.text andDate:self.eventDate andInfo: info];

    [self dismissViewControllerAnimated:YES completion:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SecondViewControllerDismissed"
                                                        object:nil
                                                      userInfo:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
