//
//  IDPObservableModel.m
//  UITask01
//
//  Created by Student003 on 6/22/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPObservableModel.h"

#import "IDPModificationModel.h"

#import "IDPMacro.h"

//static NSString * const IDPUserKey  = @"name";

@interface IDPObservableModel ()
@property (nonatomic, strong) NSMutableArray *mutableObjects;

@end

@implementation IDPObservableModel

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
    return [self.mutableObjects copy];
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

- (void)moveObject:(id)object toIndex:(NSUInteger)index {
    NSUInteger sourceIndex = [self indexOfObject:object];
    
    [self.mutableObjects removeObject:object];
    [self.mutableObjects insertObject:object atIndex:index];
    
    IDPModificationModel *model = [IDPModificationModel movementModelWithSourceIndex:sourceIndex destinationIndex:index];
    
    [self notifyOfState:IDPModelDidChange withObject:model];
}

- (void)swapObjectAtIndex:(NSUInteger)indexOfObject withObjectAtIndex:(NSUInteger)anotherObjectIndex {
    NSMutableArray *objects = self.mutableObjects;
    IDPUser *temporaryObject = objects[indexOfObject];
    
    objects[indexOfObject] = objects[anotherObjectIndex];
    objects[anotherObjectIndex] = temporaryObject;
}

//- (void)sortUsers {
//    // temporary solution! Should make user object Comparable!!!
//    [self.mutableObjects sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:IDPUserKey ascending:YES]]];
//    self.state = IDPModelDidChange;
//}

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
