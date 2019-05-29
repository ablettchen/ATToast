//
//  UIView+ATToast.h
//  ATCategories
//
//  Created by ablett on 2019/5/29.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class ATToastStyle;
@interface UIView (ATToast)

- (void)makeToast:(nonnull NSString *)message;
- (void)makeToastAttributed:(nonnull NSAttributedString *)message;
- (void)makeToast:(nonnull NSString *)message completion:(void(^__nullable)(void))completion;
- (void)makeToastAttributed:(nonnull NSAttributedString *)message completion:(void(^__nullable)(void))completion;

@end

@interface ATToastStyle : NSObject

@property (nonatomic, assign) UIEdgeInsets insets;      ///< default is UIEdgeInsetsMake(10, 10, 10, 10).
@property (nonatomic, assign) CGFloat cornerRadius;     ///< default is 5.
@property (nonatomic, strong) UIFont *font;             ///< default is systemFont(14).
@property (nonatomic, strong) UIColor *fontColor;       ///< default is 0xFFFFFFFF.
@property (nonatomic, strong) UIColor *splitColor;      ///< default is 0xCCCCCCFF.
@property (nonatomic, assign) CGFloat splitWidth;       ///< default is 1/[UIScreen mainScreen].scale
@property (nonatomic, strong) UIColor *backgroundColor; ///< default is 0x000000C2.
@property (nonatomic, assign) CGFloat maxWidth;         ///< default is 275.

- (void)reset;

@end

@interface ATToastConfig : NSObject

@property (nonatomic, assign) NSTimeInterval duration; ///< default is 2s.
@property (nonatomic, strong, readonly, nonnull) ATToastStyle *style;
@property (nonatomic, strong, readonly) void(^update)(void(^block)(ATToastStyle *style));

- (void)resetStyle;
+ (instancetype)defaultConfig;

@end

NS_ASSUME_NONNULL_END
