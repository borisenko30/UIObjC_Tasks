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
    return [self viewControllerWithName:NSStringFromClass([self class])];
}

+ (instancetype)viewControllerWithName:(NSString *)name {
    return [[self alloc] initWithNibName:name bundle:nil];
}

@end
