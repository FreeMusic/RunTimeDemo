//
//  SalenOwner.h
//  RunTime_归档解档
//
//  Created by mic on 2017/12/18.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Model.h"

@interface SalenOwner : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSNumber *age;

@property (nonatomic, copy) NSNumber *phoneNumber;

@property (nonatomic, copy) NSNumber *height;

@property (nonatomic, strong) NSDictionary *info;

@property (nonatomic, copy) NSString *son;

@end
