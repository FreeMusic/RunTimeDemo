//
//  Person.m
//  RunTime--消息转发
//
//  Created by mic on 2017/12/19.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import "Person.h"

@implementation Person


- (void)eatApple{
    NSLog(@"Person like eat red Apple");
}
/**
 *   如果我们的对象调用了 一个不存在的方法 那么 就会出现类似这样的       crash信息：unrecognized selector sent to instance 0x7fd0a141afd0
 *   但是如果我们用runtime调用resolveInstanceMethod：来进行
 *   动态方法的解析，我们需要用class_addMethod函数完成向特定类添加特定方法的操作
 *   返回NO，则进入下一步forwardingTargetForSelector:
 */
+ (BOOL)resolveClassMethod:(SEL)sel{
    
#if 0
    return NO;
#else
    class_addMethod(self, sel, class_getMethodImplementation(self, sel_registerName("eatApple")), "v@:");
    return [super resolveClassMethod:sel];
#endif
}
/**
 *   在消息转发机制执行前，runtime会再给我们一次重新定向的机会。通过重载forwardingTargetForSelector:方法来替换消息的接收者为其他对象
    返回nil则进行下一步forwardInvocation:
 */
- (id)forwardingTargetForSelector:(SEL)aSelector{
    
#if 0
    return nil;
#else
    return [[Apple alloc] init];
#endif
    
}
/**
 *  获取方法签名(v@:)进入下一步（消息转发）
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}
/**
 *  消息转发
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    return[anInvocation invokeWithTarget:[[Apple alloc] init]];
}
@end
