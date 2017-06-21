//
//  IDPUsersModel.h
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPObservableObject.h"

@class IDPUser;

typedef NS_ENUM(NSUInteger, IDPUsersModelState) {
    IDPUsersModelUnchanged,
    IDPUsersModelChanged
};

@interface IDPUsersModel : IDPObservableObject
@property (nonatomic, readonly, copy)   NSArray     *users;
@property (nonatomic, readonly)         NSUInteger  count;

- (void)addUser;
- (void)removeUser:(IDPUser *) user;

- (void)swapUserAtIndex:(NSUInteger)userIndex withUserAtIndex:(NSUInteger)anotherUserIndex;

- (void)sortUsers;

- (NSUInteger)count;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

- (void)saveModel;
- (void)loadModel;

@end
