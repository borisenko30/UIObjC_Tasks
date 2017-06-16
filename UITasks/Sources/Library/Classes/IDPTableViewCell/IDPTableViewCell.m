//
//  IDPTableViewCell.m
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPTableViewCell.h"

@implementation IDPTableViewCell

#pragma mark -
#pragma mark Accessors

- (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
