//
//  IDPUsersTable.h
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPObservableObject.h"

@class IDPUser;

typedef NS_ENUM(NSUInteger, IDPUsersTableState) {
    IDPUsersTableUnchanged,
    IDPUsersTableChanged
};

@interface IDPUsersTable : IDPObservableObject
@property (nonatomic, readonly, copy)   NSArray     *users;
@property (nonatomic, readonly)         NSUInteger  count;

- (instancetype)initWithUsersWithCount:(NSUInteger)count;

- (void)addUser;
- (void)removeUser:(IDPUser *) user;

- (void)sortUsers;

- (NSUInteger)count;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

@end
