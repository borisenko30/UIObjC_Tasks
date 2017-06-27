//
//  IDPObservableModel.m
//  UITask01
//
//  Created by Student003 on 6/27/17.
//  Copyright © 2017 Student003. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "IDPObservableModel.h"

#import "IDPGCD.h"

#import "IDPMacro.h"

static NSString * const IDPFileName = @"model.plist";

@interface IDPObservableModel ()
//@property (nonatomic, strong) id <NSCoding> model;

- (NSURL *)applicationDocumentsDirectory;

@end

@implementation IDPObservableModel

#pragma mark -
#pragma mark Deallocations and initializations

//- (instancetype)initWithObject:(id <NSCoding>)object {
//    self = [super init];
//    self.model = object;
//    
//    return self;
//}

#pragma mark -
#pragma mark Public

- (void)saveObject:(id <NSCoding>)object {
    NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:IDPFileName];
    
    BOOL saved = [NSKeyedArchiver archiveRootObject:object toFile:url.path];
    if (saved) {
        NSLog(@"file was saved...");
    } else {
        NSLog(@"failed to save the file!");
    }
}

- (void)loadedObject {
    __block id <NSCoding> object;
    
    IDPWeakify(self)

    [self loadBlock:^{
        IDPStrongify(self)
        NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:IDPFileName];
        
        NSLog(@"start loading");
        
        self.state = IDPModelWillLoad;
        
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:url.path];
        
    } completion:^id <NSCoding>(){
        IDPDispatchOnMainQueue(^{
            self.state = IDPModelDidLoad;
        });
        
        NSLog(@"loaded model");
        
        return object;
    }];
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

- (void)loadBlock:(void(^)())block completion:(id <NSCoding>(^)())completion {
    IDPDispatchAsyncInBackground(^{
        block();
        if (completion) {
            completion();
        }
    });
}

@end
