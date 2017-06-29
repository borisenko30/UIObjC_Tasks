//
//  IDPImageView.h
//  UITask01
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPLoadingViewContainer.h"
#import "IDPModelObserver.h"

@class IDPImageModel;

@interface IDPImageView : IDPLoadingViewContainer<IDPModelObserver>
@property (nonatomic, strong)   UIImageView     *contentImageView;

@property (nonatomic, strong)   IDPImageModel   *imageModel;

@end
