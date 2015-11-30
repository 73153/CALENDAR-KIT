////
////  TBTaskTableView.m
////  ToDoIt
////
////  Created by pin on 13-10-8.
////  Copyright (c) 2013年 dingyi. All rights reserved.
////
//
//#import "TBTaskTableView.h"
//#import "CKCalendarEvent.h"
//#import "TBTaskTableDelegate.h"
//
//#import "NSString+Color.h"
//
//@interface TBTaskTableView () <TBTaskTableDelegate, UITableViewDataSource, UITableViewDelegate>
//    @property (nonatomic, strong) NSMutableDictionary *data;
//    @property (nonatomic, strong) UIButton *doneButton;
//    @property (nonatomic, strong) UIButton *deleteButton;
//    @property (nonatomic, strong) UIButton *cancelButton;
//    @property (nonatomic, strong) UIView *operationView;
//    @property (nonatomic, strong) UITableViewCell *operationCell;
//@end
//
//@implementation TBTaskTableView
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        [self setDelegate:self];
//        [self setDataSource:self];
//        [self initOperateButtonAndView];
//    }
//    return self;
//}
//
//- (void)initOperateButtonAndView
//{
//    int buttonFontSize = 13;
//    int buttonCornerRadius = 8;
//    
//    _doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _doneButton.layer.cornerRadius = buttonCornerRadius;
//    _doneButton.clipsToBounds = YES;
//    _doneButton.titleLabel.font = [UIFont boldSystemFontOfSize: buttonFontSize];
//    [_doneButton setBackgroundColor:[@"#A7C067" toColor]];
//    [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
//    [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    _deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _deleteButton.layer.cornerRadius = buttonCornerRadius;
//    _deleteButton.clipsToBounds = YES;
//    _deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize: buttonFontSize];
//    [_deleteButton setBackgroundColor:[@"#D96C64" toColor]];
//    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
//    [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _cancelButton.layer.cornerRadius = buttonCornerRadius;
//    _cancelButton.clipsToBounds = YES;
//    _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize: buttonFontSize];
//    [_cancelButton setBackgroundColor:[@"#7D7D7B" toColor]];
//    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    _operationView = [UIView new];
//    
//    [[self operationView] addSubview:[self doneButton]];
//    [[self operationView] addSubview:[self deleteButton]];
//    [[self operationView] addSubview:[self cancelButton]];
//}
//
//- (void)cancelClick
//{
//    [UIView transitionWithView:self.operationCell duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^
//     {
//         [[self operationView] removeFromSuperview];
//         
//     } completion:^(BOOL finished){}];
//}
//
//#pragma mark - UITableViewDataSource
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    NSInteger count = [[self events] count];
//    return count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CKCalendarEvent *event = [[self events] objectAtIndex:[indexPath row]];
//    
//    NSString *cellIdentifier = [event title];
//    
//    UITableViewCell *cell = [[self table] dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell != nil) {
//        return cell;
//        
//    }
//    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    
//    [cell setBackgroundColor:[UIColor whiteColor]];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    
//    int cellHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];
//    
//    /** just show demo */
//    UIColor *showColor = [[UIColor alloc]init];
//    NSString *leftDayTitle = @"";
//    if (indexPath.row == 0) {
//        showColor = [@"#EB426B" toColor];
//        leftDayTitle = @"当天截止";
//    }
//    else if (indexPath.row == 1)
//    {
//        showColor = [@"#F7C91E" toColor];
//        leftDayTitle = @"还剩3天";
//    }
//    else
//    {
//        showColor = [@"#63C92D" toColor];
//        leftDayTitle = @"还剩5天";
//    }
//    
//    // 设置主题label
//    int titleLabelFontSize = 15;
//    int titleLabelPadding = 10;
//    int titleLabelX = cell.frame.origin.x+15;
//    int titleLabelY = (cellHeight-titleLabelFontSize)/2-titleLabelPadding;
//    int titleLabelWidth = 3*tableView.frame.size.width/4;
//    int titleLabelHeight = cellHeight-2*titleLabelY-titleLabelPadding;
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelWidth,titleLabelHeight)];
//    [titleLabel setFont:[UIFont systemFontOfSize:titleLabelFontSize]];
//    [titleLabel setTextAlignment:NSTextAlignmentLeft];
//    [titleLabel setTextColor:[UIColor blackColor]];
//    [titleLabel setText:[event title]];
//    
//    // 设置截止日期label
//    int endDateLabelFontSize = 10;
//    int endDateLabelX = titleLabelX+1;
//    int endDateLabelY = titleLabelY+titleLabelFontSize+2;
//    int endDateLabelWidth = tableView.frame.size.width/2;
//    int endDateLabelHeight = cellHeight-2*titleLabelY;
//    UILabel *endDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(endDateLabelX, endDateLabelY, endDateLabelWidth,endDateLabelHeight)];
//    [endDateLabel setFont:[UIFont systemFontOfSize:endDateLabelFontSize]];
//    [endDateLabel setTextAlignment:NSTextAlignmentLeft];
//    [endDateLabel setTextColor:[UIColor colorWithWhite:0.2 alpha:0.5]];
//    [endDateLabel setText:@"截止日期：2013-10-15"];
//    
//    // 设置时间label
//    int dateLabelFontSize = 13;
//    int dateLabelPadding = 3;
//    int dateLabelX = titleLabelX+titleLabelWidth;
//    int dateLabelY = (cellHeight-dateLabelFontSize)/2-dateLabelPadding;
//    int dateLabelWidth = tableView.frame.size.width/4;
//    int dateLabelHeight = cellHeight-2*dateLabelY;
//    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(dateLabelX, dateLabelY, dateLabelWidth,dateLabelHeight)];
//    [dateLabel setFont:[UIFont boldSystemFontOfSize:dateLabelFontSize]];
//    [dateLabel setTextAlignment:NSTextAlignmentLeft];
//    [dateLabel setTextColor:showColor];
//    [dateLabel setText:leftDayTitle];
//    
//    [cell addSubview:titleLabel];
//    [cell addSubview:endDateLabel];
//    [cell addSubview:dateLabel];
//    
//    return cell;
//}
//
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    // no content here
//    if (tableView.contentSize.height == [self tableView:tableView heightForRowAtIndexPath:0]) {
//        return nil;
//    }
//	// create the parent view that will hold header Label
//	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
//	customView.backgroundColor = [@"#F8F6F8" toColor];
//	// create the button object
//	UILabel * headerLabel = [[UILabel alloc] init];
//	headerLabel.textColor = [UIColor blackColor];
//	headerLabel.font = [UIFont boldSystemFontOfSize:13];
//	headerLabel.frame = CGRectMake(15, 5, tableView.frame.size.width, 20);
//	headerLabel.text = [self dateToTitleString:[NSDate date]];
//	[customView addSubview:headerLabel];
//    
//	return customView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 0;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}
//
//- (NSString *)dateToTitleString:(NSDate *)date
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"EEEE, MM月d日, yyyy"];
//    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
//    
//    NSString *dStr = [dateFormatter stringFromDate:date];
//    return dStr;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    if ([[self events] count] == 0) {
//        return;
//    }
//
//    if ([[self delegate] respondsToSelector:@selector(tableView:didSelectEvent:withCell:)]) {
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        [[self delegate] ta calendarView:self didSelectEvent:[self events][[indexPath row]] withCell:cell];
//    }
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
//
//
//@end
