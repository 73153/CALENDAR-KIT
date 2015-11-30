//
//  ACDViewController.h
//  Calendar
//
//  Created by zhu on 23/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol AutocompletionTableViewDelegate;

@interface ACDViewController : UIViewController <AutocompletionTableViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) NSString* startTime;
@property (strong, nonatomic) NSString* dateStr;
@property (strong, nonatomic) NSString* titleText;
@property (strong, nonatomic) NSString* detailText;
- (IBAction)goBack:(id)sender;
- (IBAction)cancelButton:(id)sender;

@end
