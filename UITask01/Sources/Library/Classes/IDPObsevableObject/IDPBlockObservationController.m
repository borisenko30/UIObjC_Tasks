//
//  IDPBlockObservationController.m
//  IDPUITask1
//
//  Created by Student004 on 6/13/17.
//  Copyright © 2017 Student004. All rights reserved.
//

#import "IDPBlockObservationController.h"

#include <stdarg.h>

#import "IDPObservationController+IDPPrivate.h"

@interface IDPBlockObservationController ()
@property (nonatomic, retain) NSMutableDictionary   *stateDictionary;

@end

@implementation IDPBlockObservationController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.stateDictionary = nil;
}

- (instancetype)initWithObserver:(id)observer
                observableObject:(IDPObservableObject *)observableObject
{
    self = [super initWithObserver:observer observableObject:observableObject];
    if (self) {
        self.stateDictionary = [NSMutableDictionary dictionary];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)setHandler:(IDPStateChangeHandler)handler
          forState:(NSUInteger)state
{
    [self.stateDictionary setObject:[handler copy] forKey:@(state)];
}

- (void)removeHandlerForState:(NSUInteger)state {
    [self.stateDictionary removeObjectForKey:@(state)];
}

- (IDPStateChangeHandler)handlerForState:(NSUInteger)state {
    return [self.stateDictionary objectForKey:@(state)];
}

- (BOOL)containsHandlerForState:(NSUInteger)state {
    return nil != [self handlerForState:state];
}

// states require termination with -1 or NSUIntegerMax
- (void)setHandler:(IDPStateChangeHandler)handler
         forStates:(NSUInteger)state, ...
{
    va_list argumentList;
    va_start(argumentList, state);
    
    while (state != NSUIntegerMax) {
        self[state] = handler;
        state = va_arg(argumentList, NSUInteger);
    }
    
    va_end(argumentList);
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self handlerForState:index];
}

- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    return [self setHandler:object forState:index];
}

#pragma mark -
#pragma mark Public

- (void)notifyWithState:(NSUInteger)state {
    [self notifyWithState:state object:nil];
}

- (void)notifyWithState:(NSUInteger)state object:(id)object {
    IDPStateChangeHandler handler = self[state];
    if (handler) {
        handler(self, object);
    }
}

@end
