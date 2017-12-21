//
//  UIButton+ButtonClick.h
//  RunTime_MethodSwizzling
//
//  Created by mic on 2017/12/13.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, ButtonTitleColor) {
    RedColor,
    BlueColor,
    GreenColor
};

typedef void(^ButtonBlock)(UIButton *button, ButtonTitleColor color);

@interface UIButton (ButtonClick)

+ (UIButton *)setTitle:(NSString *)title titleColor:(UIColor *)color subView:(UIView *)subView addActionBlock:(ButtonBlock)action;

@end
