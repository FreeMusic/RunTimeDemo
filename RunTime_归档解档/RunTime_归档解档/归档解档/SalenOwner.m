//
//  SalenOwner.m
//  RunTime_归档解档
//
//  Created by mic on 2017/12/18.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import "SalenOwner.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation SalenOwner

///**
// *  使用runTime之前的 归档解档写法
// */
//- (id)initWithCoder:(NSCoder *)aDecoder{
//
//    if (self = [super init]) {
//
//        self.ID = [aDecoder decodeObjectForKey:@"ID"];
//        self.name = [aDecoder decodeObjectForKey:@"name"];
//    }
//
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder{
//    [aCoder encodeObject:self.name forKey:@"name"];
//    [aCoder encodeObject:self.ID forKey:@"ID"];
//}
/**
 *  使用runTime之后的归档解档写法
 *  实现原理：
 *  1.使用class_copyInvarList方法获取Model的所有成员变量
 *  2.使用ivar_getName方法获取成员变量的名称
 *  3.通过KVC来读取Model的属性值(encodeWithCoder)，以及给Model的属性赋值
 */

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int outCount = 0;
    Ivar *ivar = class_copyIvarList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Ivar var = ivar[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:name];
        // 注意kvc的特性是，如果能找到key这个属性的setter方法，则调用setter方法
        // 如果找不到setter方法，则查找成员变量key或者成员变量_key，并且为其赋值
        // 所以这里不需要再另外处理成员变量名称的“_”前缀
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivar = class_copyIvarList([self class], &count);
        
        for (int i = 0; i < count; i++) {
            Ivar var = ivar[i];
            const char *name = ivar_getName(var);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        
        free(ivar);
    }
    
    return self;
}

@end
