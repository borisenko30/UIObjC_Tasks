//
//  IDPImageModel.h
//  IDPUITask1
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student004. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPModel.h"

@class IDPImageCache;

@interface IDPImageModel : IDPModel<NSURLSessionDownloadDelegate>
@property (nonatomic, readonly)     UIImage         *image;
@property (nonatomic, readonly)     NSURL           *url;
@property (nonatomic, readonly)     NSString        *filePath;
@property (nonatomic, readonly)     IDPImageCache   *cache;

+ (instancetype)imageWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

@end
