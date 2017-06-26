//
//  IDPUsersModel.m
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUsersModel.h"

#import "IDPModificationModel.h"

#import "IDPUser.h"

#import "IDPMacro.h"

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

- (void)addUser:(IDPUser *)user {
    [self.mutableUsers addObject:user];
    
    NSUInteger index = [self indexOfUser:user];
    
    IDPModificationModel *model = [IDPModificationModel insertionModelWithIndex:index];
    
    [self notifyOfState:IDPModelDidChange withObject:model];
}

- (void)removeUser:(IDPUser *)user {
    NSUInteger index = [self indexOfUser:user];
    
    [self.mutableUsers removeObject:user];
    
    IDPModificationModel *model = [IDPModificationModel deletionModelWithIndex:index];
    
    [self notifyOfState:IDPModelDidChange withObject:model];
}

- (void)moveUser:(IDPUser *)user toIndex:(NSUInteger)index {
    [self removeUser:user];
    [self.mutableUsers insertObject:user atIndex:index];
    
    IDPModificationModel *model = [IDPModificationModel insertionModelWithIndex:index];
    
    [self notifyOfState:IDPModelDidChange withObject:model];
}

- (void)swapUserAtIndex:(NSUInteger)indexOfUser withUserAtIndex:(NSUInteger)anotherUserIndex {
    NSMutableArray *users = self.mutableUsers;
    IDPUser *temporaryUser = users[indexOfUser];
    
    users[indexOfUser] = users[anotherUserIndex];
    users[anotherUserIndex] = temporaryUser;
}

//- (void)sortUsers {
//    // temporary solution! Should make user object Comparable!!!
//    [self.mutableUsers sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:IDPUserKey ascending:YES]]];
//    self.state = IDPModelDidChange;
//}

- (NSUInteger)count {
    return self.mutableUsers.count;
}

- (NSUInteger)indexOfUser:(IDPUser *)user {
    return [self.mutableUsers indexOfObject:user];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return self.mutableUsers[index];
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
    if (self.mutableUsers.count > 0) {
        self.state = IDPModelDidLoad;
        
        return;
    }
    
    NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:IDPFileName];
    
    NSLog(@"start loading");
    self.state = IDPModelWillLoad;
    
    IDPWeakify(self)
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        IDPStrongify(self)
        NSMutableArray *objects = [NSKeyedUnarchiver unarchiveObjectWithFile:url.path];
        if (objects) {
            self.mutableUsers = objects;
        }

        self.state = IDPModelDidLoad;
        NSLog(@"loaded model");
    });
}

#pragma mark -
#pragma mark Observable object methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPModelDidLoad:
            return @selector(modelDidLoad);
        case IDPModelDidUnload:
            return @selector(modelDidUnload);
        case IDPModelDidFailLoading:
            return @selector(modelDidFailLoading);
        case IDPModelDidChange:
            return @selector(modelDidChange:withModificationModel:);
        case IDPModelWillLoad:
            return @selector(modelWillLoad);
            
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
