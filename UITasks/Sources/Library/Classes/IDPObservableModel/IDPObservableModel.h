//
//  IDPObservableModel.h
//  UITask01
//
//  Created by Student003 on 6/22/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPObservableObject.h"

@class IDPUser;

typedef NS_ENUM(NSUInteger, IDPModelState) {
    IDPModelDidLoad,
    IDPModelDidUnload,
    IDPModelDidFailLoading,
    IDPModelDidChange,
    IDPModelWillLoad
};

@interface IDPObservableModel : IDPObservableObject
@property (nonatomic, readonly, copy)   NSArray     *objects;
@property (nonatomic, readonly)         NSUInteger  count;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;

- (void)moveObject:(id)object toIndex:(NSUInteger)index;

- (void)swapObjectAtIndex:(NSUInteger)indexOfObject withObjectAtIndex:(NSUInteger)anotherObjectIndex;

//- (void)sortUsers;

- (NSUInteger)count;
- (NSUInteger)indexOfObject:(id)object;

- (id)objectAtIndexedSubscript:(NSUInteger)index;

@end
