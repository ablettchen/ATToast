# ATToast

[![CI Status](https://img.shields.io/travis/ablettchen@gmail.com/ATToast.svg?style=flat)](https://travis-ci.org/ablettchen@gmail.com/ATToast)
[![Version](https://img.shields.io/cocoapods/v/ATToast.svg?style=flat)](https://cocoapods.org/pods/ATToast)
[![License](https://img.shields.io/cocoapods/l/ATToast.svg?style=flat)](https://cocoapods.org/pods/ATToast)
[![Platform](https://img.shields.io/cocoapods/p/ATToast.svg?style=flat)](https://cocoapods.org/pods/ATToast)

## Example

![](https://github.com/ablettchen/ATToast/blob/master/Example/images/toast.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```Objective-C
NSString *string = @"Be sure to run `pod lib lint ATToast.podspec' to ensure this is a valid spec before submitting.";
NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
NSRange range = [string rangeOfString:@"pod lib lint ATToast.podspec"];
[attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
[attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:range];
[attributedString addAttribute:NSUnderlineStyleAttributeName value:@(1) range:range];

[self.view showToastAttributed:attributedString];
```

## Requirements

## Installation

ATToast is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ATToast'
```

## Author

ablett, ablett.chen@gmail.com

## License

ATToast is available under the MIT license. See the LICENSE file for more info.
