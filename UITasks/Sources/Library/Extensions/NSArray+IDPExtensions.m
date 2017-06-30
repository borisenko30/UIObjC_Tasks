//
//  NSArray+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 6/26/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "NSArray+IDPExtensions.h"

@implementation NSArray (IDPExtensions)

+ (instancetype)objectsWithCount:(NSInteger)count factoryBlock:(id(^)(void))block {
    if (!block) {
        return nil;
    }
    
    NSMutableArray *objects = [NSMutableArray new];
    for (int i = 0; i < count; i++) {
        [objects addObject:block()];
    }
    
    return objects;
}

- (id)objectWithClass:(Class)objectClass {
    for (id object in self) {
        if ([object isKindOfClass:objectClass]) {
            return object;
        }
    }
    
    return nil;
}

@end
