# LIYDateTimePicker

[![Version](https://img.shields.io/cocoapods/v/LIYDateTimePicker.svg?style=flat)](http://cocoadocs.org/docsets/LIYDateTimePicker)
[![License](https://img.shields.io/cocoapods/l/LIYDateTimePicker.svg?style=flat)](http://cocoadocs.org/docsets/LIYDateTimePicker)
[![Platform](https://img.shields.io/cocoapods/p/LIYDateTimePicker.svg?style=flat)](http://cocoadocs.org/docsets/LIYDateTimePicker)

<img src="https://raw.githubusercontent.com/lyahdav/LIYDateTimePicker/master/Screens/Screen1.png" alt="Calendar" width="320px"/> 
<img src="https://raw.githubusercontent.com/lyahdav/LIYDateTimePicker/master/Screens/Screen2.png" alt="Calendar" width="320px"/>

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.

All you need to use this in your app is:

    LIYDateTimePickerViewController *vc = [LIYDateTimePickerViewController timePickerForDate:[NSDate date] delegate:self];
    [self.navigationController pushViewController:vc animated:YES];

And implement the `LIYDateTimePickerDelegate`:

    - (void)dateTimePicker:(LIYDateTimePickerViewController *)dateTimePickerViewController didSelectDate:(NSDate *)selectedDate {
        NSLog(@"Selected date: %@", [selectedDate description]);
        [self.navigationController popViewControllerAnimated:YES];
    }


## Requirements

LIYDateTimePicker requires either iOS 7.x and above.

## Installation

Simply add the following lines to your Podfile:

    pod 'JTCalendar', :git => 'https://github.com/kgellci/JTCalendar.git', :branch => 'master' # This must be placed before LIYDateTimePicker
    pod 'LIYDateTimePicker', :git => 'https://github.com/lyahdav/LIYDateTimePicker.git'

## Author

Liron Yahdav

## License

LIYDateTimePicker is available under the MIT license. See the LICENSE file for more info.

## Attribution

Thanks to Icons8 for the <a
href="http://icons8.com/web-app/3979/Checklist">Checklist icon</a>
