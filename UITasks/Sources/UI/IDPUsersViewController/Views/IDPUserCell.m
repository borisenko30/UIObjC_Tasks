//
//  IDPUserCell.m
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUserCell.h"

#import "IDPImageView.h"

#import "IDPUser.h"

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
    self.userImageView.imageModel = user.imageModel;
}

@end
