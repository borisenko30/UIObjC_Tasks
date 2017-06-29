//
//  IDPUser.h
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPImageModel;

@interface IDPUser : NSObject <NSCoding>
@property (nonatomic, readonly)     NSString        *name;
@property (nonatomic, readonly)     NSString        *imageName;
@property (nonatomic, readonly)     IDPImageModel   *imageModel;

@end
