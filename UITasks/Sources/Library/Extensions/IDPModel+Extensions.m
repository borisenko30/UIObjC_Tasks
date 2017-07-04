//
//  IDPModel+Extensions.m
//  UITask01
//
//  Created by Student003 on 7/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPModel+Extensions.h"

#import "IDPGCD.h"

@implementation IDPModel (Extensions)

- (void)loadWithBlock:(IDPLoadingBlock)block completion:(IDPCompletionBlock)completion {
    if (!block) {
        return;
    }
    
    IDPDispatchAsyncInBackground(^{
        id result = block();
        
        if (completion) {
            completion(result);
        }
    });
}

@end
