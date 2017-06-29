//
//  IDPImageView.m
//  UITask01
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPImageView.h"

#import "IDPImageModel.h"

#import "IDPGCD.h"

@interface IDPImageView ()

- (void)initSubviews;

@end

@implementation IDPImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.contentImageView = nil;
    self.imageModel = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.contentImageView) {
        [self initSubviews];
    }
}

- (void)initSubviews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleHeight
    | UIViewAutoresizingFlexibleBottomMargin;
    
    self.contentImageView = imageView;
}

#pragma mark -
#pragma mark Accessors

- (void)setContentImageView:(UIImageView *)contentImageView {
    if (contentImageView != _contentImageView) {
        [_contentImageView removeFromSuperview];
        
        _contentImageView = contentImageView;
        
        [self addSubview:contentImageView];
    }
}

- (void)setImageModel:(IDPImageModel *)imageModel {
    if (_imageModel != imageModel) {
        [_imageModel removeObserver:self];
        
        [_imageModel dump];
        
        _imageModel = imageModel;
        
        [_imageModel addObserver:self];
        
        [_imageModel load];
    }
}

#pragma mark -
#pragma mark IDPImageModelObserver

- (void)modelDidUnload:(IDPImageModel *)model {
    
} 

- (void)modelWillLoad:(IDPImageModel *)model {
    self.animatedLoading = YES;
}

- (void)modelDidFailedLoading:(IDPImageModel *)model {
    [self.imageModel load];
}

- (void)modelDidLoad:(IDPImageModel *)model {
    IDPDispatchOnMainQueue(^{
        self.animatedLoading = NO;
        self.contentImageView.image = model.image;
    });

}

@end
