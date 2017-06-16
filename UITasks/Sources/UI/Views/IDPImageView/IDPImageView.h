//
//  IDPImageView.h
//  UITask01
//
//  Created by Student003 on 6/16/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPImageModel;

@interface IDPImageView : UIView
@property (nonatomic, strong) IDPImageModel *imageModel;
@property (nonatomic, strong) UIImageView   *contentImageView;

@end
