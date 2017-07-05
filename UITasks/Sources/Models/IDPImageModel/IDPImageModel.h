//
//  IDPImageModel.h
//  IDPUITask1
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student004. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPModel.h"
#import "IDPCache.h"

typedef void(^IDPCompletionBlock)(UIImage *, NSError *);

@interface IDPImageModel : IDPModel
@property (nonatomic, readonly)     UIImage         *image;
@property (nonatomic, readonly)     NSURL           *url;
@property (nonatomic, readonly)     NSURL           *localUrl;
@property (nonatomic, readonly)     IDPCache        *cache;

+ (instancetype)modelWithURL:(NSURL *)url;

@end
