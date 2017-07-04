//
//  IDPInternetImageModel.m
//  UITask01
//
//  Created by Student003 on 7/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPInternetImageModel.h"

#import "IDPGCD.h"
#import "IDPMacro.h"

#import "IDPModel+Extensions.h"

@implementation IDPInternetImageModel

#pragma mark -
#pragma mark Public Methods

//- (void)processLoading {
//    IDPWeakify(self)
//    IDPLoadingBlock block = ^id <NSCoding>{
//        IDPStrongify(self)
//        
//        self.state = IDPModelWillLoad;
//        
//        //self.image = [self imageWithUrl:self.url];
//        
//        return nil;
//    };
//    
//    IDPCompletionBlock completion = ^(id <NSCoding> result) {
//        IDPStrongify(self)
//        
//        IDPDispatchOnMainQueue(^{
//            self.state = self.image ? IDPModelDidLoad : IDPModelDidFailLoading;
//        });
//    };
//    
//    [self loadWithBlock:block completion:completion];
//}


@end
