//
//  NSObject+Model.h
//  RunTime_归档解档
//
//  Created by mic on 2017/12/18.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

+ (id)objectWithKeyValues:(NSDictionary *)dictionary;

- (NSDictionary *)keyValueWithObject;

@end
