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

@end

@implementation IDPUsersModel

#pragma mark -
#pragma mark Accessors

- (instancetype)init {
    self = [super init];
    self.filePath = [NSFileManager localUrlWithFileName:IDPFileName].path;
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)save {
    [self saveObject:self.objects];
}

- (void)performLoading {
    NSLog(@"start loading");
    NSArray *result = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
    
    if (!result) {
        result = [NSArray objectsWithCount:IDPUsersCount factoryBlock:^id{
            return [IDPUser new];
        }];
    }
    
    [self performBlockWithoutNotification:^{
        [self addObjects:(NSArray *)result];
    }];
    
    IDPDispatchOnMainQueue(^{
        self.state = IDPModelDidLoad;
        NSLog(@"loaded model");
    });
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

@end
