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

#import "IDPGCD.h"

#import "IDPMacro.h"

static NSString * const IDPFileName = @"model.plist";

@interface IDPUsersModel ()
@property (nonatomic, strong) NSMutableArray *mutableObjects;

- (NSURL *)applicationDocumentsDirectory;

@end

@implementation IDPUsersModel

- (void)saveUsers {
    NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:IDPFileName];
    
    BOOL saved = [NSKeyedArchiver archiveRootObject:self.mutableObjects toFile:url.path];
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
    
    IDPWeakify(self)
    IDPDispatchAsyncInBackground(^{
        IDPStrongify(self)
        NSMutableArray *objects = [NSKeyedUnarchiver unarchiveObjectWithFile:url.path];

        [self.mutableObjects addObjectsFromArray:objects];
        
        IDPDispatchOnMainQueue(^{
            self.state = IDPModelDidLoad;
        });

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
