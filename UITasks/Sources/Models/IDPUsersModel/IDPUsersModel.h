//
//  IDPUsersModel.h
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPObservableModel.h"

@class IDPUser;

typedef NS_ENUM(NSUInteger, IDPModelState) {
    IDPModelDidLoad,
    IDPModelDidUnload,
    IDPModelDidFailLoading,
    IDPModelDidChange,
    IDPModelWillLoad
};

@interface IDPUsersModel : IDPObservableModel
@property (nonatomic, readonly, copy)   NSArray     *users;
@property (nonatomic, readonly)         NSUInteger  count;

- (void)addUser:(IDPUser *)user;
- (void)removeUser:(IDPUser *) user;

- (void)swapUserAtIndex:(NSUInteger)indexOfUser withUserAtIndex:(NSUInteger)anotherUserIndex;

- (void)sortUsers;

- (NSUInteger)count;
- (NSUInteger)indexOfUser:(IDPUser *)user;

- (id)objectAtIndexedSubscript:(NSUInteger)index;

- (void)saveUsers;
- (void)loadUsers;

@end
