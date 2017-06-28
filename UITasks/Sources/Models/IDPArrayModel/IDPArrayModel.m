//
//  IDPArrayModel.m
//  UITask01
//
//  Created by Student003 on 6/22/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPArrayModel.h"

#import "IDPModificationModel.h"

#import "NSMutableArray+IDPExtensions.h"

#import "IDPMacro.h"

#import "IDPGCD.h"

static NSString * const IDPFileName = @"arrayModel.plist";

@interface IDPArrayModel ()
@property (nonatomic, strong) NSMutableArray *mutableObjects;

- (void)saveObject:(id <NSCoding>)object;

- (void)loadWithBlock:(IDPLoadingBlock)block completion:(IDPCompletionBlock)completion;

- (NSURL *)applicationDocumentsDirectory;

@end

@implementation IDPArrayModel

@dynamic objects;
@dynamic count;

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.mutableObjects = nil;
}

- (instancetype)init {
    self = [super init];
    self.mutableObjects = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)objects {
    return [self.mutableObjects copy];
}

#pragma mark -
#pragma mark Public

- (void)save {
    [self saveObject:self.mutableObjects];
}

- (void)load {
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
        [self.mutableObjects addObjectsFromArray:(NSArray *)result];
    };
    
    [self loadWithBlock:block completion:completion];
}

- (void)addObject:(id)object {
    [self.mutableObjects addObject:object];
    
    NSUInteger index = [self indexOfObject:object];
    
    IDPModificationModel *model = [IDPModificationModel insertionModelWithIndex:index];
    
    [self notifyOfState:IDPArrayModelDidChange withObject:model];
}

- (void)removeObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    
    [self.mutableObjects removeObject:object];
    
    IDPModificationModel *model = [IDPModificationModel deletionModelWithIndex:index];
    
    [self notifyOfState:IDPArrayModelDidChange withObject:model];
}

- (void)addObjects:(NSArray *)objects {
    [self performBlock:^{
        for (id object in objects) {
            [self addObject:object];
        }
    } shouldNotify:NO];
}

- (void)removeObjects:(NSArray *)objects {
    [self performBlock:^{
        for (id object in objects) {
            [self removeObject:object];
        }
    } shouldNotify:NO];
}

- (void)moveObject:(id)object toIndex:(NSUInteger)index {
    NSUInteger sourceIndex = [self indexOfObject:object];
    
    [self.mutableObjects moveObject:object toIndex:index];
    
    IDPModificationModel *model = [IDPModificationModel movementModelWithSourceIndex:sourceIndex destinationIndex:index];
    
    [self notifyOfState:IDPArrayModelDidChange withObject:model];
}

- (void)swapObjectAtIndex:(NSUInteger)indexOfObject withObjectAtIndex:(NSUInteger)anotherObjectIndex {
    NSMutableArray *objects = self.mutableObjects;
    id temporaryObject = objects[indexOfObject];
    
    objects[indexOfObject] = objects[anotherObjectIndex];
    objects[anotherObjectIndex] = temporaryObject;
}

- (NSUInteger)count {
    return self.mutableObjects.count;
}

- (NSUInteger)indexOfObject:(id)object {
    return [self.mutableObjects indexOfObject:object];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return self.mutableObjects[index];
}

#pragma mark -
#pragma mark Observable object methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPArrayModelDidChange:
            return @selector(modelDidChange:withModificationModel:);
            
        default:
            return [super selectorForState:state];
    }
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
