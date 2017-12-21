//
//  UIButton+ButtonClick.m
//  RunTime_MethodSwizzling
//
//  Created by mic on 2017/12/13.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import "UIButton+ButtonClick.h"

@implementation UIButton (ButtonClick)

static char buttonKey;

+ (UIButton *)setTitle:(NSString *)title titleColor:(UIColor *)color subView:(UIView *)subView addActionBlock:(ButtonBlock)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [subView addSubview:button];
    
    objc_setAssociatedObject(button, &buttonKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);

    [button addTarget:button action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)callActionBlock:(id)sender{
    
    ButtonBlock block = (ButtonBlock)objc_getAssociatedObject(sender, &buttonKey);
    
    if (block) {
        block(sender, RedColor);
    }
}

@end
