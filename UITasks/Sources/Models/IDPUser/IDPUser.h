//
//  IDPUser.h
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDPUser : NSObject <NSCoding>
@property (nonatomic, readonly) NSString        *name;
@property (nonatomic, strong) NSURL           *imageURL;
@property (nonatomic, readonly) UIImage         *image;

@end
