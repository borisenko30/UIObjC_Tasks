//
//  NSArray+IDPExtensions.h
//  UITask01
//
//  Created by Student003 on 6/26/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (IDPExtensions)

+ (instancetype)objectsWithCount:(NSInteger)count factoryBlock:(id (^)(void))block;

- (id)objectWithClass:(Class)objectClass;

@end
