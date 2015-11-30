//
//  CKEventDetailViewController.m
//  MBCalendarKit
//
//  Created by Luis Fernando De Pombo on 12/31/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "CKEventDetailViewController.h"
#import "../Core/CKCalendarEvent.h"
#import "CKEventDetailView.h"


@interface CKEventDetailViewController ()

@property (strong, nonatomic) IBOutlet CKEventDetailView *view;
@property (weak, nonatomic) IBOutlet UILabel *titl;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation CKEventDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (IBAction)exitBttn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil andEvent:(CKCalendarEvent *) event bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.event = event;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:self.event.date];
    self.date.text = dateString;
    self.titl.text = self.event.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
