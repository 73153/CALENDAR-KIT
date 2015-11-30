//
//  TBTaskTableViewController.h
//  ToDoIt
//
//  Created by pin on 13-10-8.
//  Copyright (c) 2013年 dingyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBTaskTableDelegate.h"
#import "TBTaskTableDataSource.h"

@interface TBTaskTableViewController : UITableViewController

@property (nonatomic, strong) id<TBTaskTableDataSource> dataSource;

@end
