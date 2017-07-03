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
#import "NSFileManager+IDPExtensions.h"

static NSString * const IDPFileName     = @"arrayModel.plist";
static NSUInteger const IDPUsersCount   = 10;

@interface IDPUsersModel ()
@property (nonatomic, strong) NSString *filePath;

- (void)saveObject:(id <NSCoding>)object;

- (void)loadWithBlock:(IDPLoadingBlock)block completion:(IDPCompletionBlock)completion;

@end

@implementation IDPUsersModel

#pragma mark -
#pragma mark Accessors

- (instancetype)init {
    self = [super init];
    self.filePath = [NSFileManager pathWithFileName:IDPFileName];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)save {
    [self saveObject:self.objects];
}

- (void)processLoading {
    IDPWeakify(self)
    IDPLoadingBlock block = ^id <NSCoding>{
        IDPStrongify(self)
        
        NSLog(@"start loading");
        
        self.state = IDPModelWillLoad;
        
        return [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
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
    BOOL saved = [NSKeyedArchiver archiveRootObject:object toFile:self.filePath];
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

@end
