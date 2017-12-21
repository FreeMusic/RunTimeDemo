//
//  ViewController.m
//  RunTime--消息转发
//
//  Created by mic on 2017/12/19.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //消息的转发
    [self messageForwarding];
}
/**
 *  消息的转发
 */
- (void)messageForwarding{
    Person *person = [[Person alloc] init];
    
    ((void (*) (id, SEL)) objc_msgSend) (person , sel_registerName("appleColor"));
}

@end
