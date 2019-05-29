//
//  ATViewController.m
//  ATToast
//
//  Created by ablettchen@gmail.com on 05/29/2019.
//  Copyright (c) 2019 ablettchen@gmail.com. All rights reserved.
//

#import "ATViewController.h"
#import <ATCategories/ATCategories.h>
#import <UIView+ATToast.h>

@interface ATViewController ()

@end

@implementation ATViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *showBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:view];
        view.at_size = CGSizeMake(200, 50);
        view.at_top = self.view.at_top + (IS_IPHONE_X?135:100);
        view.at_centerX = self.view.at_centerX;
        [view setTitle:@"show toast" forState:UIControlStateNormal];
        [view setTitleColor:UIColorHex(0x0067d8FF) forState:UIControlStateNormal];
        [view setTitleColor:UIColorHex(0xFFFFFFFF) forState:UIControlStateHighlighted];
        [view setBackgroundImage:[UIImage imageWithColor:UIColorHex(0x0067d8FF)] forState:UIControlStateHighlighted];
        [view.titleLabel setFont:[UIFont systemFontOfSize:18]];
        view.layer.borderWidth = 1.f;
        view.layer.borderColor = UIColorHex(0x0067d8FF).CGColor;
        view.layer.cornerRadius = 5.f;
        view.layer.masksToBounds = YES;
        view;
    });
    
    [showBtn addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAction:(UIButton *)sender {
    
    NSString *string = @"Be sure to run `pod lib lint ATToast.podspec' to ensure this is a valid spec before submitting.";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:@"pod lib lint ATToast.podspec"];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:range];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(1) range:range];
    
    [self.view makeToastAttributed:attributedString];
    
}

@end
