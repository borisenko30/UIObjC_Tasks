//
//  UIWindow+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 6/20/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "UIWindow+IDPExtensions.h"

@implementation UIWindow (IDPExtensions)

+ (instancetype)screenSizeWindow {
    return [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

@end
