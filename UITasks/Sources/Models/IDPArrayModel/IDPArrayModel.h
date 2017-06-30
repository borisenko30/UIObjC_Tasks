//
//  IDPArrayModel.h
//  UITask01
//
//  Created by Student003 on 6/22/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPModel.h"

typedef NS_ENUM(NSUInteger, IDPArrayModelState) {
    IDPArrayModelDidChange = IDPModelStateCount
};

@interface IDPArrayModel : IDPModel
@property (nonatomic, readonly, copy)   NSArray     *objects;
@property (nonatomic, readonly)         NSUInteger  count;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;

- (void)addObjects:(NSArray *)objects;
- (void)removeObjects:(NSArray *)objects;

- (void)moveObject:(id)object toIndex:(NSUInteger)index;

- (NSUInteger)count;
- (NSUInteger)indexOfObject:(id)object;

- (id)objectAtIndexedSubscript:(NSUInteger)index;

@end
