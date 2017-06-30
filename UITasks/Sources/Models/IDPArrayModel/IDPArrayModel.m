//
//  IDPArrayModel.m
//  UITask01
//
//  Created by Student003 on 6/22/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPArrayModel.h"

#import "IDPModificationModel.h"

#import "IDPArrayModelObserver.h"

#import "NSMutableArray+IDPExtensions.h"

@interface IDPArrayModel ()
@property (nonatomic, strong) NSMutableArray *mutableObjects;

@end

@implementation IDPArrayModel

@dynamic objects;
@dynamic count;

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.mutableObjects = nil;
}

- (instancetype)init {
    self = [super init];
    self.mutableObjects = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)objects {
    @synchronized (self) {
        return [self.mutableObjects copy];
    }
}

#pragma mark -
#pragma mark Public

- (void)addObject:(id)object {
    if (!object) {
        return;
    }
    
    @synchronized (self) {
        [self.mutableObjects addObject:object];
        
        NSUInteger index = [self indexOfObject:object];
        
        IDPModificationModel *model = [IDPModificationModel insertionModelWithIndex:index];
        
        [self notifyOfChangeWithObject:model];
    }
}

- (void)removeObject:(id)object {
    @synchronized (self) {
        NSUInteger index = [self indexOfObject:object];
        
        [self.mutableObjects removeObject:object];
        
        IDPModificationModel *model = [IDPModificationModel deletionModelWithIndex:index];
        
        [self notifyOfChangeWithObject:model];
    }
}

- (void)addObjects:(NSArray *)objects {
    for (id object in objects) {
        [self addObject:object];
    }
}

- (void)removeObjects:(NSArray *)objects {
    for (id object in objects) {
        [self removeObject:object];
    }
}

- (void)moveObject:(id)object toIndex:(NSUInteger)index {
    @synchronized (self) {
        NSUInteger sourceIndex = [self indexOfObject:object];
        
        [self.mutableObjects moveObject:object toIndex:index];
        
        IDPModificationModel *model = [IDPModificationModel movementModelWithSourceIndex:sourceIndex destinationIndex:index];
        
        [self notifyOfChangeWithObject:model];
    }
}

- (NSUInteger)count {
    @synchronized (self) {
        return self.mutableObjects.count;
    }
}

- (NSUInteger)indexOfObject:(id)object {
    @synchronized (self) {
        return [self.mutableObjects indexOfObject:object];
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    @synchronized (self) {
        return self.mutableObjects[index];
    }
}

#pragma mark -
#pragma mark Observable object methods

- (void)notifyOfChangeWithObject:(id)object {
    [self notifyOfState:IDPArrayModelDidChange withObject:object];
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPArrayModelDidChange:
            return @selector(arrayModelDidChange:withModificationModel:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
