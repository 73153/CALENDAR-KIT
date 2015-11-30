//
//  TBTaskTableDataSource.h
//  ToDoIt
//
//  Created by pin on 13-10-8.
//  Copyright (c) 2013年 dingyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TBTaskTableDataSource <NSObject>

- (NSArray *)tableViewData;

@end
