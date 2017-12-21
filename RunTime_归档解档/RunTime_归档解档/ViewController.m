//
//  ViewController.m
//  RunTime_归档解档
//
//  Created by mic on 2017/12/18.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import "ViewController.h"
#import "SalenOwner.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSDictionary *dictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dictionary = @{
                   @"name":@"Salen",
                   @"age":@24,
                   @"phoneNumber":@138384388,
                   @"height":@190.5,
                   @"info":@{
                           @"address":@"HangZhou",
                           },
                   @"son":@{
                           @"name":@"SalenSon",
                           @"info":@{
                                   @"address":@"HangZhou",
                                   },
                           }
                   };
    //字典转模型
    [self keyValueTest];
    //归档和解档
    [self valuesArachiver];
}
/**
 *   字典转模型
 */
- (void)keyValueTest{
    SalenOwner *salen = [SalenOwner objectWithKeyValues:dictionary];
    NSLog(@"字典转模型    name is %@  son name is %@", salen.name, salen.son);
}
/**
 *  归档和解档
 */
- (void)valuesArachiver{
    SalenOwner *salen = [SalenOwner objectWithKeyValues:dictionary];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    path = [path stringByAppendingPathComponent:@"test"];
    
    [NSKeyedArchiver archiveRootObject:salen toFile:path];
    
    SalenOwner *model = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"归档和解档  %@", model.name);
}


@end
