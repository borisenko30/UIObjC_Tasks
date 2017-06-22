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
static NSString * const IDPUserKey  = @"name";

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
    self.mutableUsers = [NSMutableArray array];
    
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
    self.state = IDPModelDidChange;
}

- (void)removeUser:(IDPUser *)user {
    [self.mutableUsers removeObject:user];
    self.state = IDPModelDidChange;
}

- (void)swapUserAtIndex:(NSUInteger)userIndex withUserAtIndex:(NSUInteger)anotherUserIndex {
    NSMutableArray *users = self.mutableUsers;
    IDPUser *temporaryUser = users[userIndex];
    
    users[userIndex] = users[anotherUserIndex];
    users[anotherUserIndex] = temporaryUser;
}

- (void)sortUsers {
    // temporary solution! Should make user object Comparable!!!
    [self.mutableUsers sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:IDPUserKey ascending:YES]]];
    self.state = IDPModelDidChange;
}

- (NSUInteger)count {
    return self.mutableUsers.count;
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return self.mutableUsers[index];
}

- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    
}

- (void)saveUsers {
    NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:IDPFileName];
    
    BOOL saved = [NSKeyedArchiver archiveRootObject:self.mutableUsers toFile:url.path];
    if (saved) {
        NSLog(@"file was saved...");
    } else {
        NSLog(@"failed to save the file!");
    }
}

- (void)loadUsers {
    NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:IDPFileName];
    
    NSLog(@"start loading");
    
    self.state = IDPModelWillLoad;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        NSMutableArray *users = [NSKeyedUnarchiver unarchiveObjectWithFile:url.path];
        if (users) {
            self.mutableUsers = users;
        }

        self.state = IDPModelDidLoad;
        NSLog(@"loaded model");
    });
    
    
}

- (void)clearUsers {
    self.mutableUsers = [NSMutableArray array];
}

#pragma mark -
#pragma mark Observable object methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPModelDidLoad:
            return @selector(modelDidLoad:);
        case IDPModelDidUnload:
            return @selector(modelDidUnload:);
        case IDPModelDidFailLoading:
            return @selector(modelDidFailLoading:);
        case IDPModelDidChange:
            return @selector(modelDidChange:);
        case IDPModelWillLoad:
            return @selector(modelWillLoad:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark Private

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
