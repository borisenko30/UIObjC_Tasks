//
//  IDPArrayModel.m
//  UITask01
//
//  Created by Student003 on 6/22/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPArrayModel.h"

#import "IDPModificationModel.h"

#import "IDPObservableModel+Extension.h"

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
    NSMutableArray *objects = [NSMutableArray array];
    self.mutableObjects = objects;
    self = [super initWithObject:objects];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)objects {
    return [self.mutableObjects copy];
}

//the kostyl epta!
- (void)setState:(NSUInteger)state {
    if (state == IDPModelDidLoad) {
        [self.mutableObjects addObjectsFromArray:(NSMutableArray *)self.model];
        self.model = self.mutableObjects;
    }
    
    [super setState:state];
}

#pragma mark -
#pragma mark Public

- (void)addObject:(id)object {
    [self.mutableObjects addObject:object];
    
    NSUInteger index = [self indexOfObject:object];
    
    IDPModificationModel *model = [IDPModificationModel insertionModelWithIndex:index];
    
    [self notifyOfState:IDPModelDidChange withObject:model];
}

- (void)removeObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    
    [self.mutableObjects removeObject:object];
    
    IDPModificationModel *model = [IDPModificationModel deletionModelWithIndex:index];
    
    [self notifyOfState:IDPModelDidChange withObject:model];
}

- (void)addObjects:(NSArray *)objects {
    [self performBlock:^{
        for (id object in objects) {
            [self addObject:object];
        }
    } shouldNotify:NO];
}

- (void)removeObjects:(NSArray *)objects {
    [self performBlock:^{
        for (id object in objects) {
            [self removeObject:object];
        }
    } shouldNotify:NO];
}

- (void)moveObject:(id)object toIndex:(NSUInteger)index {
    NSUInteger sourceIndex = [self indexOfObject:object];
    
    [self.mutableObjects moveObject:object toIndex:index];
    
    IDPModificationModel *model = [IDPModificationModel movementModelWithSourceIndex:sourceIndex destinationIndex:index];
    
    [self notifyOfState:IDPModelDidChange withObject:model];
}

- (void)swapObjectAtIndex:(NSUInteger)indexOfObject withObjectAtIndex:(NSUInteger)anotherObjectIndex {
    NSMutableArray *objects = self.mutableObjects;
    id temporaryObject = objects[indexOfObject];
    
    objects[indexOfObject] = objects[anotherObjectIndex];
    objects[anotherObjectIndex] = temporaryObject;
}

- (NSUInteger)count {
    return self.mutableObjects.count;
}

- (NSUInteger)indexOfObject:(id)object {
    return [self.mutableObjects indexOfObject:object];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return self.mutableObjects[index];
}

@end
