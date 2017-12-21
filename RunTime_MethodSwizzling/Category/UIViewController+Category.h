//
//  UIViewController+Category.h
//  RunTime_MethodSwizzling
//
//  Created by mic on 2017/12/13.
//  Copyright © 2017年 JZ. All rights reserved.
//
//runtime的黑魔法
//消息转发虽然功能强大，但需要我们了解并且能更改对应类的源代码，因为我们需要实现自己的转发逻辑。当我们无法触碰到某个类的源代码，却想更改这个类某个方法的实现时，该怎么办呢？可能继承类并重写方法是一种想法，但是有时无法达到目的。这里介绍的是 Method Swizzling ，它通过重新映射方法对应的实现来达到“偷天换日”的目的。跟消息转发相比，Method Swizzling 的做法更为隐蔽，甚至有些冒险，也增大了debug的难度。
//
//
#import <UIKit/UIKit.h>

@interface UIViewController (Category)

@end
