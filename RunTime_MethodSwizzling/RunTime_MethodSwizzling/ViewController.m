//
//  ViewController.m
//  RunTime_MethodSwizzling
//
//  Created by mic on 2017/12/13.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import "ViewController.h"
//#import "UIViewController+Category.h"
#import "SXYView.h"
#import "UIButton+ButtonClick.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, assign) NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //动态添加方法
    [self dynamicConditionMethod];
}
/**
 *  动态添加方法
 */
- (void)dynamicConditionMethod{
    SXYView *view = [[SXYView alloc] init];
    SEL selector = NSSelectorFromString(@"guess");
    
    Method method = class_getInstanceMethod([view class], selector);
    class_addMethod([view class], selector, (IMP)guessAnswer, method_getTypeEncoding(method));
    if ([view respondsToSelector:selector]) {
        ((void (*)(id, SEL))[view methodForSelector:selector])(view, selector);
    } else{
        NSLog(@"Sorry,I don't know");
    }
}
void guessAnswer(id self,SEL _cmd){
    
    NSLog(@"i am from beijing");
    
}

@end
