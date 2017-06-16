//
//  IDPUserCell.h
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPTableViewCell.h"

@class IDPUser;
@class IDPImageView;

@interface IDPUserCell : IDPTableViewCell
@property (nonatomic, strong) IBOutlet UILabel       *nameLabel;
@property (nonatomic, strong) IBOutlet IDPImageView  *userImageView;

@property (nonatomic, strong) IDPUser *user;

- (void)fillWithUser:(IDPUser *)user;

@end
