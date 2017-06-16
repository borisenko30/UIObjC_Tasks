//
//  IDPObservationController.m
//  IDPUITask1
//
//  Created by Student004 on 6/13/17.
//  Copyright © 2017 Student004. All rights reserved.
//

#import "IDPObservationController.h"

#import "IDPObservationController+IDPPrivate.h"
#import "IDPObservableObject+IDPPrivate.h"

static NSString * const kIDPObservationControllerAllocationException = @"IDPObservationController should never be"
                                                                    @"instantiated directly.";

@interface IDPObservationController()
@property (nonatomic, assign) id    observer;
@property (nonatomic, assign) id    observableObject;

@end

@implementation IDPObservationController

@dynamic valid;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)observationControllerWithObserver:(id)observer
                                 observableObject:(IDPObservableObject *)observableObject
{
    return [[self alloc] initWithObserver:observer
                         observableObject:observableObject];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observableObject = nil;
    
}

- (instancetype)initWithObserver:(id)observer
                observableObject:(IDPObservableObject *)observableObject
{
    NSAssert(nil != observer , NSInvalidArgumentException);
    NSAssert(nil != observableObject , NSInvalidArgumentException);
    
    self = [self init];
    if (self) {
        self.observer = observer;
        self.observableObject = observableObject;
    }
    
    return self;
}


#pragma mark -
#pragma mark Accessors

- (void)setObservableObject:(IDPObservableObject *)observableObject {
    if (nil == _observableObject) {
        [_observableObject invalidateController:self];
    }
    
    _observableObject = observableObject;
}

- (BOOL)isValid {
    return nil != self.observableObject || nil != self.observer;
}

#pragma mark -
#pragma mark Public

- (void)invalidate {
    self.observableObject = nil;
    self.observer = nil;
}

- (NSUInteger)hash {
    return [[self class] hash] ^ [self.observer hash] ^ [self.observableObject hash];
}

- (BOOL)isEqual:(IDPObservationController *)controller {
    if (!controller) {
        return NO;
    }
    
    if (controller == self) {
        return YES;
    }
    
    if ([self isMemberOfClass:[controller class]]) {
        return controller.observer == self.observer
        && controller.observableObject == self.observableObject;
    }
    
    return NO;
}

#pragma mark -
#pragma mark Private

- (void)notifyWithState:(NSUInteger)state {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)notifyWithState:(NSUInteger)state object:(id)object {
    [self doesNotRecognizeSelector:_cmd];
}

@end
