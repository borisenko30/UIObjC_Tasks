//
//  IDPLoadingModel.m
//  UITask01
//
//  Created by Student003 on 6/27/17.
//  Copyright © 2017 Student003. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "IDPLoadingModel.h"

#import "IDPGCD.h"

#import "IDPMacro.h"

static NSString * const IDPFileName = @"model.plist";

@interface IDPLoadingModel ()
//@property (nonatomic, strong) id <NSCoding> model;

- (NSURL *)applicationDocumentsDirectory;

@end

@implementation IDPLoadingModel

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

- (void)loadWithCompletion:(void(^)(id <NSCoding>))completion {
    IDPWeakify(self)
    id <NSCoding>(^block)() = ^id <NSCoding>{
        IDPStrongify(self)
        NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:IDPFileName];
        
        NSLog(@"start loading");
        
        self.state = IDPModelWillLoad;
        
        return [NSKeyedUnarchiver unarchiveObjectWithFile:url.path];
    };
    
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
