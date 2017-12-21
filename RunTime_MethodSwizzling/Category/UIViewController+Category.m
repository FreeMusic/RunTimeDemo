//
//  UIViewController+Category.m
//  RunTime_MethodSwizzling
//
//  Created by mic on 2017/12/13.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import "UIViewController+Category.h"
#import <objc/runtime.h>

@implementation UIViewController (Category)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class aClass = [self class];
        // When swizzling a class method, use the following:
        // Class aClass = object_getClass((id)self);
        
        SEL systemSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(sxy_viewWillAppear:);
        
        Method systemMethod = class_getInstanceMethod(aClass, systemSelector);
        
        Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(aClass, systemSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(aClass, swizzledSelector, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            method_exchangeImplementations(systemMethod, swizzledMethod);
        }
    });
    
}

#pragma mark - Method Swizzling
- (void)sxy_viewWillAppear:(BOOL)animated{
    [self sxy_viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor yellowColor];
    NSLog(@"viewWillAppear: %@", self);
}

@end
