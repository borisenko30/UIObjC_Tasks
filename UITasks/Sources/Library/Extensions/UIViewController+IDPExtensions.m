//
//  UIViewController+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 6/20/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "UIViewController+IDPExtensions.h"

@implementation UIViewController (IDPExtensions)

+ (instancetype)defaultViewController {
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
