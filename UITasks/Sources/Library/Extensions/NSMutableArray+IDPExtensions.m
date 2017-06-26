//
//  NSMutableArray+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 6/26/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "NSMutableArray+IDPExtensions.h"

@implementation NSMutableArray (IDPExtensions)

- (void)moveObject:(id)object toIndex:(NSUInteger)index {
    [self removeObject:object];
    [self insertObject:object atIndex:index];
}

@end
