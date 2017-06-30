//
//  IDPUsersModel.m
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUsersModel.h"

#import "IDPMacro.h"

#import "IDPGCD.h"

#import "IDPUser.h"

#import "NSArray+IDPExtensions.h"

static NSString * const IDPFileName     = @"arrayModel.plist";
static NSUInteger const IDPUsersCount   = 10;

@interface IDPUsersModel ()

- (void)saveObject:(id <NSCoding>)object;

- (void)loadWithBlock:(IDPLoadingBlock)block completion:(IDPCompletionBlock)completion;

- (NSURL *)applicationDocumentsDirectory;

@end

@implementation IDPUsersModel

#pragma mark -
#pragma mark Public

- (void)save {
    [self saveObject:self.objects];
}

- (void)processLoading {
    IDPWeakify(self)
    IDPLoadingBlock block = ^id <NSCoding>{
        IDPStrongify(self)
        NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:IDPFileName];
        
        NSLog(@"start loading");
        
        self.state = IDPModelWillLoad;
        
        return [NSKeyedUnarchiver unarchiveObjectWithFile:url.path];
    };
    
    IDPCompletionBlock completion = ^(id <NSCoding> result) {
        IDPStrongify(self)
        if (!result) {
            result = [NSArray objectsWithCount:IDPUsersCount factoryBlock:^id{
                return [IDPUser new];
            }];
        }
        
        [self performBlock:^{
            [self addObjects:(NSArray *)result];
        } shouldNotify:NO];
    };
    
    [self loadWithBlock:block completion:completion];
}

#pragma mark -
#pragma mark Private

- (void)saveObject:(id <NSCoding>)object {
    NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:IDPFileName];
    
    BOOL saved = [NSKeyedArchiver archiveRootObject:object toFile:url.path];
    if (saved) {
        NSLog(@"file was saved...");
    } else {
        NSLog(@"failed to save the file!");
    }
}

- (void)loadWithBlock:(IDPLoadingBlock)block completion:(IDPCompletionBlock)completion {
    IDPDispatchAsyncInBackground(^{
        id result = block();
        
        if (completion) {
            completion(result);
            
            IDPDispatchOnMainQueue(^{
                self.state = IDPModelDidLoad;
                NSLog(@"loaded model");
            });
        }
    });
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
