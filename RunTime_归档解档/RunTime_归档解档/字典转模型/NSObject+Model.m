//
//  NSObject+Model.m
//  RunTime_归档解档
//
//  Created by mic on 2017/12/18.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (Model)
/**
 *  runtime字典转模型
 *  1.根据字典的key生成setter方法
 *  2.使用objc_mssgSend调用setter方法 为Model的属性赋值(或KVC)
 */
+ (id)objectWithKeyValues:(NSDictionary *)dictionary{
    id objc = [[self alloc] init];
    for (NSString *key in dictionary.allKeys) {
        id value = dictionary[key];
        
        //判断当前属性是不是model
        objc_property_t property = class_getProperty(self, key.UTF8String);
        unsigned int count = 0;
        objc_property_attribute_t *attributeList = property_copyAttributeList(property, &count);
        objc_property_attribute_t attribute = attributeList[0];
        
        NSString *typeString = [NSString stringWithUTF8String:attribute.value];
        if ([typeString isEqualToString:@"@\"SalenOwner\""]) {
            value = [self objectWithKeyValues:value];
        }
        /***********生成setter方法 并用objc_msgSend调用******/
        NSString *methodName = [NSString stringWithFormat:@"set%@%@:", [key substringToIndex:1].uppercaseString, [key substringFromIndex:1]];
        SEL setter = sel_registerName(methodName.UTF8String);
        if ([objc respondsToSelector:setter]) {
            ((void (*) (id,SEL,id)) objc_msgSend) (objc,setter,value);
        }
    }
    
    return objc;
}
/**
*  **********模型转字典的时候****************
*  1.调用class_copyPropertyList方法获取当前Model的所有属性
*  2.调用property_getName获取属性名称
*  3.根据属性名称生成getter方法
*  4.使用objc_msgSend调用getter方法获取属性值(或KVC)
*/
- (NSDictionary *)keyValueWithObject{
    
    unsigned int count = 0;
    objc_property_t *propertyList =class_copyPropertyList([self class], &count);
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        
        //生成getter方法 并用objc_msgSend调用
        const char *propertyName = property_getName(property);
        
        SEL getter = sel_registerName(propertyName);
        if ([self respondsToSelector:getter]) {
            id value = ((id (*) (id, SEL)) objc_msgSend) (self, getter);
            //判断当前属性是不是model
            if ([value isKindOfClass:[self class]] && value) {
                value = [value keyValueWithObject];
            }
            
            if (value) {
                NSString *key = [NSString stringWithUTF8String:propertyName];
                [dictionary setObject:value forKey:key];
            }
        }
    }
    
    return dictionary;
}

@end
