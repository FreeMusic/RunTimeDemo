//
//  SXYView.m
//  RunTime_MethodSwizzling
//
//  Created by mic on 2017/12/13.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import "SXYView.h"
#import <objc/runtime.h>

@implementation SXYView

static char tapKey;

+ (SXYView *)createViewAddSubView:(UIView *)subView color:(UIColor *)color tapBlock:(SXYBlock)tapBlock{
    SXYView *view = [[SXYView alloc] init];
    
    [subView addSubview:view];
    
    view.backgroundColor = color;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapClick:)];
    
    [view addGestureRecognizer:tap];
    
    objc_setAssociatedObject(tap, &tapKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return view;
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    SXYBlock block = objc_getAssociatedObject(tap, &tapKey);
    
    if (block) {
        block(YES);
    }
    
}

@end
