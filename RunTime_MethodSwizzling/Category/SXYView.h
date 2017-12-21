//
//  SXYView.h
//  RunTime_MethodSwizzling
//
//  Created by mic on 2017/12/13.
//  Copyright © 2017年 JZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SXYBlock)(BOOL hidden);

@interface SXYView : UIView

@property (nonatomic, copy) SXYBlock sxyBlock;

+ (SXYView *)createViewAddSubView:(UIView *)subView color:(UIColor *)color tapBlock:(SXYBlock)tapBlock;

@end
