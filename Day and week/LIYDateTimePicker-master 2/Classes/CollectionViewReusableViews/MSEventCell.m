#import "MSEventCell.h"
#import <EventKit/EventKit.h>
#import "Masonry.h"
#import "UIColor+HexString.h"
#import "NSDate+LIYUtilities.h"

const CGFloat kLIYContentMargin = 2.0;
const CGFloat kLIYBorderWidth = 6.0;
const NSInteger kLIYEventMinutesToMoveEventTimeLabelToTop = 30;
const NSInteger kLIYEventMinutesToShrinkFontSize = 15;

@interface MSEventCell ()

@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UIView *bottomBorderView;
@property (nonatomic, strong) UILabel *eventTimeLabel;
@property (nonatomic, strong) NSArray *eventTimeLabelConstraints;
@property (nonatomic, assign) BOOL eventTimeLabelIsAtTop;

@end

@implementation MSEventCell

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        self.layer.shouldRasterize = YES;
        
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0.0, 4.0);
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.0;
        
        self.borderView = [UIView new];
        [self.contentView addSubview:self.borderView];
        self.bottomBorderView = [UIView new];
        [self.contentView addSubview:self.bottomBorderView];
        
        self.title = [UILabel new];
        self.title.numberOfLines = 0;
        self.title.backgroundColor = [UIColor clearColor];
        [self.title setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self.title setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:self.title];
        
        self.eventTimeLabel = [UILabel new];
        self.eventTimeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.eventTimeLabel];
        
        [self updateColors];
        
        [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height);
            make.width.equalTo(@(kLIYBorderWidth));
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
        }];
        
        [self.bottomBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(kLIYBorderWidth));
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
        
        UIEdgeInsets contentPadding = [self contentPadding];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(contentPadding.top);
            make.left.equalTo(self.mas_left).offset(contentPadding.left);
        }];

        self.eventTimeLabelIsAtTop = YES; // pretend it's at top so next line works
        [self moveEventTimeLabelDown];
    }
    return self;
}

- (UIEdgeInsets)contentPadding {
    return UIEdgeInsetsMake(5.0, (kLIYBorderWidth + 4.0f), 1.0, 4.0);
}

- (void)moveEventTimeLabelToTop {
    if (self.eventTimeLabelIsAtTop) {
        return;
    }
    
    for (MASConstraint *constraint in self.eventTimeLabelConstraints) {
        [constraint uninstall];
    }
    
    self.eventTimeLabel.numberOfLines = 1;
    UIEdgeInsets contentPadding = [self contentPadding];

    self.eventTimeLabelConstraints = [self.eventTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(self.title.mas_baseline);
        make.right.equalTo(self.mas_right).offset(-contentPadding.right);
        make.left.equalTo(self.title.mas_right).offset(5.0);
    }];
    self.eventTimeLabelIsAtTop = YES;
}

- (void)moveEventTimeLabelDown {
    if (!self.eventTimeLabelIsAtTop) {
        return;
    }
   
    for (MASConstraint *constraint in self.eventTimeLabelConstraints) {
        [constraint uninstall];
    }

    self.eventTimeLabel.numberOfLines = 0;
    UIEdgeInsets contentPadding = [self contentPadding];
    
    self.eventTimeLabelConstraints = [self.eventTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(kLIYContentMargin);
        make.left.equalTo(self.mas_left).offset(contentPadding.left);
        make.right.equalTo(self.mas_right).offset(-contentPadding.right);
        make.bottom.lessThanOrEqualTo(self.mas_bottom).offset(-contentPadding.bottom);
    }];
    self.eventTimeLabelIsAtTop = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateColors];
}

#pragma mark - UICollectionViewCell

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected]; // Must be here for animation to fire
}

#pragma mark - MSEventCell

- (NSDate *)selectedDate {
    NSAssert(_selectedDate != nil, @"selectedDate was never set on MSEventCell");
    return _selectedDate;
}

- (void)setEvent:(EKEvent *)event {
    _event = event;
    
    NSString *title = @"[no title]";

    if (self.event.title) {
        title = self.event.title;
    }

    self.title.attributedText = [[NSAttributedString alloc] initWithString:title attributes:[self titleAttributesHighlighted:self.selected]];
    
    
    [self updateEventTimesLabel];
}

- (void)setShowEventTimes:(BOOL)showEventTimes {
    _showEventTimes = showEventTimes;
    [self updateEventTimesLabel];
}

/** Returns the event's duration in minutes in the current day.
 For example, an event from 11:30pm today to 1:00am tomorrow will return 30 minutes if you're looking at today.
*/
- (NSInteger)eventDurationMinutesInSelectedDay {
    NSTimeInterval interval = [self eventTimeIntervalInSelectedDay];
    return (NSInteger)interval / 60;
}

- (void)updateEventTimesLabel {
    if (self.showEventTimes) {
        self.eventTimeLabel.text = [self eventTimesString];
        CGFloat fontSize = [self eventDurationMinutesInSelectedDay] > kLIYEventMinutesToShrinkFontSize ? 9.0f : 7.0f;
        self.eventTimeLabel.font = [UIFont systemFontOfSize:fontSize];

        if ([self eventDurationMinutesInSelectedDay] <= kLIYEventMinutesToMoveEventTimeLabelToTop) {
            [self moveEventTimeLabelToTop];
        } else {
            [self moveEventTimeLabelDown];
        }
    } else {
        self.eventTimeLabel.text = @"";
    }
}

- (NSString *)eventTimesString {
    NSString *startDateString = [self shortStringFromDate:self.event.startDate];
    NSString *endDateString = [self shortStringFromDate:self.event.endDate];
    return [NSString stringWithFormat:@"%@ - %@ (%@)", startDateString, endDateString, [self durationString]];
}

- (NSString *)shortStringFromDate:(NSDate *)date {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"h:mm aa"];
    }
    static NSDateFormatter *shortDateFormatter = nil;
    if (shortDateFormatter == nil) {
        shortDateFormatter = [NSDateFormatter new];
        [shortDateFormatter setDateFormat:@"h aa"];
    }
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSMinuteCalendarUnit fromDate:date];
    if (components.minute == 0) {
        return [shortDateFormatter stringFromDate:date];
    } else {
        return [dateFormatter stringFromDate:date];
    }
}

- (NSTimeInterval)eventTimeInterval {
    return [self.event.endDate timeIntervalSinceDate:self.event.startDate];
}

- (NSTimeInterval)eventTimeIntervalInSelectedDay {
    NSDate *startDateInSelectedDay = self.event.startDate;
    if (![startDateInSelectedDay isSameDayAsDate:self.selectedDate]) {
        startDateInSelectedDay = [self.selectedDate dateAtHour:0 minute:0];
    }
    NSDate *endDateInSelectedDay = self.event.endDate;
    if (![endDateInSelectedDay isSameDayAsDate:self.selectedDate]) {
        endDateInSelectedDay = [[NSDate date] dateAtHour:24 minute:0];
    }
    
    return [endDateInSelectedDay timeIntervalSinceDate:startDateInSelectedDay];
}

- (NSString *)durationString {
    NSTimeInterval interval = [self eventTimeInterval];
    NSInteger remainingMinutes = (NSInteger)(interval / 60) % 60;
    NSInteger hours = (NSInteger)(interval / 3600);
    if (hours < 1) {
        return [NSString stringWithFormat:@"%ld minutes", (long)remainingMinutes];
    } else if (remainingMinutes > 0) {
        return [NSString stringWithFormat:@"%ld:%02ld hours", (long)hours, (long)remainingMinutes];
    } else if (hours == 1) {
        return @"1 hour";
    } else {
        return [NSString stringWithFormat:@"%ld hours", (long)hours];
    }
}

- (void)updateColors {
    self.contentView.backgroundColor = [self backgroundColorHighlighted:self.selected];
    self.borderView.backgroundColor = [self borderColor];
    self.bottomBorderView.backgroundColor = [UIColor colorWithHexString:@"eaeaea"];
    self.title.textColor = [self textColorHighlighted:self.selected];
}

- (NSDictionary *)titleAttributesHighlighted:(BOOL)highlighted {
    CGFloat fontSize = [self eventDurationMinutesInSelectedDay] > kLIYEventMinutesToShrinkFontSize ? 12.0f : 7.0f;
    return [self highlightAttributes:highlighted fontSize:fontSize bold:YES];
}

- (NSDictionary *)highlightAttributes:(BOOL)isHighlighted fontSize:(CGFloat)fontSize bold:(BOOL)bold {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.hyphenationFactor = 1.0;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    UIFont *font = bold ? [UIFont boldSystemFontOfSize:fontSize] : [UIFont systemFontOfSize:fontSize];
    return @{
             NSFontAttributeName : font,
             NSForegroundColorAttributeName : [self textColorHighlighted:isHighlighted],
             NSParagraphStyleAttributeName : paragraphStyle
             };
}

- (UIColor *)backgroundColorHighlighted:(BOOL)selected {
    return selected ? [UIColor colorWithHexString:@"ffffff"] : [[UIColor colorWithHexString:@"ffffff"] colorWithAlphaComponent:1.0];
}

- (UIColor *)textColorHighlighted:(BOOL)selected {
    return selected ? [UIColor whiteColor] : [UIColor colorWithHexString:@"353535"];
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor: self.event.calendar.CGColor];
}


@end
