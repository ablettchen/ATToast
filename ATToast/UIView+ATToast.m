//
//  UIView+ATToast.m
//  ATCategories
//
//  Created by ablett on 2019/5/29.
//

#import "UIView+ATToast.h"

#if __has_include(<ATCategories/ATCategories.h>)
#import <ATCategories/ATCategories.h>
#else
#import "ATCategories.h"
#endif

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

@interface UIView ()
@end

@implementation UIView (ATToast)

#pragma mark - privite

- (void)makeToast:(nonnull NSString *)message duration:(NSTimeInterval)duration completion:(void(^__nullable)(void))completion {
    [self makeToastAttributed:[[NSAttributedString alloc] initWithString:message] duration:duration completion:completion];
}

- (void)makeToastAttributed:(nonnull NSAttributedString *)message duration:(NSTimeInterval)duration completion:(void(^__nullable)(void))completion {
    
    ATToastStyle *style = [ATToastConfig defaultConfig].style;
    
    CGFloat messageWidth = [message.string widthForFont:style.font];
    CGFloat estimateWidth = (messageWidth + style.insets.left + style.insets.right);
    CGFloat width = (estimateWidth <= style.maxWidth)?estimateWidth:style.maxWidth;
    
    UIView *contentView = ({
        UIView *view = [UIView new];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(ceilf(width));
        }];
        [self addSubview:view];
        view.layer.cornerRadius = style.cornerRadius;
        view.clipsToBounds = YES;
        view.layer.borderWidth = style.splitWidth;
        view.layer.borderColor = style.splitColor.CGColor;
        view.backgroundColor = style.backgroundColor;
        view.alpha = 0.f;
        view;
    });
    
    [contentView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [contentView setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
    
    UILabel *messageLabel = ({
        UILabel *label = [UILabel new];
        [contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView).inset(style.insets.top);
            make.left.equalTo(contentView).inset(style.insets.left);
            make.right.equalTo(contentView).inset(style.insets.right);
        }];
        label.backgroundColor = [UIColor clearColor];
        label.font = style.font;
        label.textColor = style.fontColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label;
    });
    messageLabel.attributedText = message;
    
    CGSize messageMaxSize = CGSizeMake(width-style.insets.left-style.insets.right, self.bounds.size.height * 0.8);
    CGSize messageExpectedSize = [messageLabel sizeThatFits:messageMaxSize];
    messageExpectedSize = CGSizeMake(MIN(messageMaxSize.width, messageExpectedSize.width), MIN(messageMaxSize.height, messageExpectedSize.height));
    
    [messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ceilf(messageExpectedSize.height));
    }];
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(messageLabel.mas_bottom).offset(style.insets.bottom);
        make.center.equalTo(self);
    }];
    
    [self showToast:contentView duration:duration completion:completion];
}

- (void)showToast:(nonnull UIView *)toast duration:(NSTimeInterval)duration completion:(void(^__nullable)(void))completion {
    [self bringSubviewToFront:toast];
    toast.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.0f);
    [UIView animateWithDuration:0.2f
                          delay:0.f
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.layer.transform = CATransform3DIdentity;
                         toast.alpha = 1.f;
                     }
                     completion:^(BOOL finished) {
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self hideToast:toast completion:completion];
                         });
                     }];
    
}

- (void)hideToast:(nonnull UIView *)toast completion:(void(^__nullable)(void))completion {
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{toast.alpha = 0.f;}
                     completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                         if (completion) {
                             completion();
                         }
                     }];
}

#pragma mark - public

- (void)showToast:(nonnull NSString *)message {
    [self showToastAttributed:[[NSAttributedString alloc] initWithString:message]];
}

- (void)showToastAttributed:(nonnull NSAttributedString *)message {
    [self showToastAttributed:message completion:nil];
}

- (void)showToast:(nonnull NSString *)message completion:(void(^__nullable)(void))completion {
    [self showToastAttributed:[[NSAttributedString alloc] initWithString:message] completion:completion];
}

- (void)showToastAttributed:(nonnull NSAttributedString *)message completion:(void(^__nullable)(void))completion {
    [self makeToastAttributed:message duration:[ATToastConfig defaultConfig].duration completion:completion];
}

@end

@implementation ATToastStyle

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    [self reset];
    return self;
}

- (void)reset {
    _insets = UIEdgeInsetsMake(10, 10, 10, 10);
    _cornerRadius = 5.0;
    _font = [UIFont systemFontOfSize:14];
    _fontColor = UIColorHex(0xFFFFFFFF);
    _splitColor = UIColorHex(0x333333FF);
    _splitWidth = 1/[UIScreen mainScreen].scale;
    _backgroundColor = UIColorHex(0x000000C2);
    _maxWidth = 275.f;
}

@end

@interface ATToastConfig ()
@property (nonatomic, strong, readwrite, nonnull) ATToastStyle *style;
@end
@implementation ATToastConfig

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.style = [ATToastStyle new];
    self.duration = 2.f;
    return self;
}

+ (instancetype)defaultConfig {
    static ATToastConfig *_defaultConfig = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _defaultConfig = [[self alloc] init];
    });
    return _defaultConfig;
}

- (void (^)(void (^ _Nonnull)(ATToastStyle * _Nonnull)))update {
    __weak typeof(self) _self = self;
    return ^void(void(^block)(ATToastStyle *style)) {
        __strong typeof(_self) self = _self;
        if (block) block(self.style);
    };
}

- (void)resetStyle {
    [self.style reset];
}

@end

