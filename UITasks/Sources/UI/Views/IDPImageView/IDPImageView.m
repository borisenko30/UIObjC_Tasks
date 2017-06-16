//
//  IDPImageView.m
//  UITask01
//
//  Created by Student003 on 6/16/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPImageView.h"

#import "IDPImageModel.h"

#import "IDPBlockObservationController.h"

#import "IDPMacro.h"

@interface IDPImageView ()
@property (nonatomic, strong) IDPBlockObservationController *observer;

- (void)initSubviews;

@end

@implementation IDPImageView

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    
}

- (instancetype)init {
    self = [super init];
    [self initSubviews];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initSubviews];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.contentImageView) {
        [self initSubviews];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self initSubviews];
    
    return self;
}

- (void)initSubviews {
    UIImageView *view = [[UIImageView alloc] initWithFrame:self.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleHeight;
    
    self.contentImageView = view;
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
    if (imageModel != _imageModel) {
        [_imageModel dump];
        _imageModel = imageModel;
        
        self.observer = [_imageModel blockObservationControllerWithObserver:self];
        [imageModel load];
    }
}

- (void)setObserver:(IDPBlockObservationController *)observer {
    if (observer != _observer) {
        _observer = observer;
        
        [self prepareObserver:observer];
    }
}

#pragma mark -
#pragma mark View Lifecycle


#pragma mark -
#pragma mark Private

- (void)prepareObserver:(IDPBlockObservationController *)observer {
    IDPWeakify(self)
    id handler = ^(IDPBlockObservationController *controller, id userInfo) {
        void(^block)(void) = ^{
            IDPStrongifyAndReturnIfNil(self)
            
            IDPImageModel *model = controller.observableObject;
            self.contentImageView.image = model.image;
        };
        
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_sync(dispatch_get_main_queue(), block);
        }
    };
    
    [observer setHandler:handler forState:IDPImageModelUnloaded];
    [observer setHandler:handler forState:IDPImageModelUnloaded];
    
    handler = ^(IDPBlockObservationController *controller, id userInfo){
        IDPStrongifyAndReturnIfNil(self)
        
        [self.imageModel load];
    };
    
    [observer setHandler:handler forState:IDPImageModelFailedLoading];
}


@end
