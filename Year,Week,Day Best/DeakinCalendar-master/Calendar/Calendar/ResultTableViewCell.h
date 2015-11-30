//
//  ResultTableViewCell.h
//  Calendar
//
//  Created by Peng Gao on 31/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventLocalTime;
@property (weak, nonatomic) IBOutlet UILabel *eventOtherTime;

@end
