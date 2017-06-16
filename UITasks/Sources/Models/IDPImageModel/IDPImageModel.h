//
//  IDPImageModel.h
//  UITask01
//
//  Created by Student003 on 6/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPObservableObject.h"

typedef NS_ENUM(NSUInteger, IDPImageModelState) {
    IDPImageModelUnloaded,
    IDPImageModelLoading,
    IDPImageModelLoaded,
    IDPImageModelFailedLoading
};

@interface IDPImageModel : IDPObservableObject
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSURL   *url;

+ (instancetype)imageWithURL:(NSURL *)url;

- (instancetype)initWithUrl:(NSURL *)url;

- (void)load;
- (void)dump;

@end
