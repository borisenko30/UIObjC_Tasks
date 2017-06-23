//
//  IDPObservableObject.m
//  Task06_Observer_Objc
//
//  Created by Student003 on 5/26/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPObservableObject.h"

@interface IDPObservableObject ()
@property (nonatomic, retain) NSHashTable *mutableObservers;

@end

@implementation IDPObservableObject

@dynamic observers;

#pragma mark -
#pragma mark Deallocations and initializations

- (instancetype)init {
    self = [super init];
    self.mutableObservers = [NSHashTable weakObjectsHashTable];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(NSUInteger)state {
    @synchronized (self) {
        if (_state != state) {
            _state = state;
            
            [self notifyOfState:state];
        }
    }
}

- (NSSet *)observers {
    @synchronized (self) {
        return [self.mutableObservers copy];
    }
}

#pragma mark -
#pragma mark Public

- (void)addObserver:(id)observer {
    if (!observer) {
        return;
    }
    
    @synchronized (self) {
        [self.mutableObservers addObject:observer];
    }
}

- (void)removeObserver:(id)observer {
    if (!observer) {
        return;
    }
    
    @synchronized (self) {
        [self.mutableObservers removeObject:observer];
    }
}

- (void)addObservers:(NSArray *)observers {
    @synchronized (self) {
        for (id observer in observers) {
            [self addObserver:observer];
        }
    }
}

- (void)removeObservers:(NSArray *)observers {
    @synchronized (self) {
        for (id observer in observers) {
            [self removeObserver:observer];
        }
    }
}

- (SEL)selectorForState:(NSUInteger)state {
    return NULL;
}

- (void)notifyOfState:(NSUInteger)state {
    [self notifyOfStateWithSelector:[self selectorForState:state]];
}

- (void)notifyOfState:(NSUInteger)state withObject:(id)object {
    [self notifyOfStateWithSelector:[self selectorForState:state] withObject:object];
}

#pragma mark -
#pragma mark Private

- (void)notifyOfStateWithSelector:(SEL)selector {
    [self notifyOfStateWithSelector:selector withObject:nil];
}

- (void)notifyOfStateWithSelector:(SEL)selector withObject:(id)object{
    @synchronized (object) {
        NSSet *observers = self.observers;
        for (id observer in observers) {
            if ([observer respondsToSelector:selector]) {
                [observer performSelector:selector withObject:self withObject:object];
            }
        }
    }
}

@end
