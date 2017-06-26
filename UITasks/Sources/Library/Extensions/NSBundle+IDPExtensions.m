//
//  NSBundle+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 6/26/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSBundle+IDPExtensions.h"

#import "NSArray+IDPExtensions.h"

@implementation NSBundle (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

- (id)objectWithClass:(Class)class {
    return [self objectWithClass:class owner:nil];
}

- (id)objectWithClass:(Class)class owner:(nullable id)owner {
    return [self objectWithClass:class owner:owner options:nil];
}

- (id)objectWithClass:(Class)class owner:(nullable id)owner options:(nullable NSDictionary *)options {
    NSArray *objects = [self loadNibNamed:NSStringFromClass(class) owner:owner options:options];
    
    return [objects objectWithClass:class];
}

@end

