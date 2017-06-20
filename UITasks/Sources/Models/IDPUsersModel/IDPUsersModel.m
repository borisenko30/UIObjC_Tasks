//
//  IDPUsersModel.m
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUsersModel.h"

#import "IDPUser.h"

@interface IDPUsersModel ()
@property (nonatomic, strong) NSMutableArray *mutableUsers;

@end

@implementation IDPUsersModel

@dynamic users;
@dynamic count;

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.mutableUsers = nil;
}

- (instancetype)init {
    self = [self initWithUsersWithCount:0];
    
    return self;
}

- (instancetype)initWithUsersWithCount:(NSUInteger)count {
    self = [super init];
    
    self.mutableUsers = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [self.mutableUsers addObject:[IDPUser new]];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)users {
    return [self.mutableUsers copy];
}

#pragma mark -
#pragma mark Public

- (void)addUser {
    [self.mutableUsers addObject:[IDPUser new]];
    self.state = IDPUsersModelChanged;
}

- (void)removeUser:(IDPUser *)user {
    [self.mutableUsers removeObject:user];
    self.state = IDPUsersModelChanged;
}

- (void)swapUserAtIndex:(NSUInteger)userIndex withUserAtIndex:(NSUInteger)anotherUserIndex {
    NSMutableArray *users = self.mutableUsers;
    IDPUser *temporaryUser = users[userIndex];
    
    users[userIndex] = users[anotherUserIndex];
    users[anotherUserIndex] = temporaryUser;
}

- (void)sortUsers {
    // temporary solution! Should make user object Comparable!!!
    [self.mutableUsers sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    self.state = IDPUsersModelChanged;
}

- (NSUInteger)count {
    return self.mutableUsers.count;
}

#pragma mark -
#pragma mark Private

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return self.mutableUsers[index];
}

- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    
}

@end
