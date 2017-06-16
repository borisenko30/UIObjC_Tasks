//
//  IDPUserCell.m
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUserCell.h"

#import "IDPUser.h"
#import "IDPImageView.h"
#import "IDPImageModel.h"

@implementation IDPUserCell

#pragma mark -
#pragma mark Accessors

- (void)setUser:(IDPUser *)user {
    if (_user == user) {
        return;
    }
    
    _user = user;
    
    [self fillWithUser:user];
}

#pragma mark -
#pragma mark Public

- (void)fillWithUser:(IDPUser *)user {
    self.nameLabel.text = user.name;
    
    
    self.userImageView.contentImageView.image = user.imageModel.image;
    NSLog(@"");
    
//    static dispatch_once_t onceTocken;
//    static dispatch_queue_t queue = nil;
//    dispatch_once(&onceTocken, ^{
//        queue = dispatch_queue_create("asdf", DISPATCH_QUEUE_SERIAL);
//    });
//    
//    dispatch_async(queue, ^{
//        UIImage *image = user.imageModel.image;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.userImageView.contentImageView.image = image;
//        });
//    });
    
}

@end