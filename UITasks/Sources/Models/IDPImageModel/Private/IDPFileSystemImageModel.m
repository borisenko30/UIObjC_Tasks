//
//  IDPFileSystemImageModel.m
//  UITask01
//
//  Created by Student003 on 7/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPFileSystemImageModel.h"

@implementation IDPFileSystemImageModel

#pragma mark -
#pragma mark Public Methods

- (void)loadWithCompletion:(IDPCompletionBlock)block {
    UIImage *image = [UIImage imageWithContentsOfFile:self.url.path];
    block(image, nil);
}

@end
