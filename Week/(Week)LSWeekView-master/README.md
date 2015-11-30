# LSWeekView

iOS week view control, similar to the one used in the iOS 7 Calendar app (day view). 

The control is used in production in our [Lumen Trails](http://www.lumentrails.com) app, with over million downloads to date.

<p align="left">
  <img src="https://github.com/LumenSpark/LSWeekView/raw/master/Screenshot.png" alt="Screenshot" width='320px'/>
</p>

## Usage

Run the example project to see it in action, or here's the snippet you can add to your view controller's `viewDidLoad` method:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.weekView = [[LSWeekView alloc] initWithFrame:CGRectZero style:LSWeekViewStyleDefault];
    self.weekView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.weekView.calendar = [NSCalendar currentCalendar];
    self.weekView.selectedDate = [NSDate date];

    __weak typeof(self) weakSelf = self;
    self.weekView.didChangeSelectedDateBlock = ^(NSDate *selectedDate) 
    {
        [weakSelf doSomethingUseful];
    };

    [self.view addSubview:self.weekView];
}
```

## Requirements

iOS 7, ARC

## Installation

LSWeekView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "LSWeekView"

## Author

Christoph Zelazowski, Lumen Spark LLC, Seattle, WA chrisze@lumenspark.com

## License

LSWeekView is available under the MIT license. See the LICENSE file for more info.

