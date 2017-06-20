//
//  IDPUsersModel.m
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUsersModel.h"

#import "IDPUser.h"

static NSString * const IDPFileName = @"model.plist";

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
    self = [super init];
    
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

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return self.mutableUsers[index];
}

- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    
}

- (void)saveModel {
    NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:IDPFileName];
    
    BOOL saved = [NSKeyedArchiver archiveRootObject:self.mutableUsers toFile:url.path];
    if (saved) {
        NSLog(@"file was saved...");
    } else {
        NSLog(@"failed to save the file!");
    }
}

- (void)loadModel {
    NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:IDPFileName];
    self.mutableUsers = [NSKeyedUnarchiver unarchiveObjectWithFile:url.path];
    self.state = IDPUsersModelChanged;
    NSLog(@"loaded model");
}

#pragma mark -
#pragma mark Private

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
