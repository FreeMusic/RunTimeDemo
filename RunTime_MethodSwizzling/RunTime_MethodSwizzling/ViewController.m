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
    
    SXYView *sxyView = [SXYView createViewAddSubView:self.view color:[UIColor redColor] tapBlock:^(BOOL hidden) {
        NSLog(@"%d", hidden);
    }];
    
    sxyView.frame = CGRectMake(100, 250, 100, 100);
    
    self.button.frame = CGRectMake(100, 350, 100, 30);
    
    _index = 11;
}

/**
 *  button
 */
- (UIButton *)button{
    if(!_button){
        _button = [UIButton setTitle:@"我的" titleColor:[UIColor redColor] subView:self.view addActionBlock:^(UIButton *button, ButtonTitleColor color) {
            NSLog(@"%@    %ld", button.titleLabel.text, color);
        }];
    }
    return _button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
