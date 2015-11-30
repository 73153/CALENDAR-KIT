//
//  CKAppDelegate.h
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/10/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CalendarKit/CalendarKit.h"
#import "NewCKCalendarEventView.h"


@interface CKAppDelegate : UIResponder <UIApplicationDelegate> {
    NewCKCalendarEventView * eventView;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CKCalendarViewController *viewController;

@end
