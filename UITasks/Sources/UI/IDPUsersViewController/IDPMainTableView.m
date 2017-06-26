//
//  IDPMainTableView.m
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPMainTableView.h"

#import "IDPUsersModel.h"

#import "IDPModificationModel.h"
#import "IDPModificationModel+UITableView.h"

#import "UINib+IDPExtensions.h"

#import "IDPMacro.h"

static CGFloat const IDPAnimationDuration = 2.0f;

@interface IDPMainTableView ()
@property (nonatomic, strong) IDPUsersModel *usersModel;

@end

@implementation IDPMainTableView

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    // set to nil to remove observer
    self.usersModel = nil;
}

- (instancetype)init {
    self = [super init];
    [self initMain];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initMain];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self initMain];
    
    return self;
}

- (void)initMain {
    self.usersModel = [IDPUsersModel new];
    IDPPreLaunchView *preLaunchUsersView = [UINib objectWithClass:[IDPPreLaunchView class]];
    
    self.preLaunchUsersView = preLaunchUsersView;
    [self addSubview:preLaunchUsersView];
}

#pragma mark -
#pragma mark Accessors

- (void)setUsersModel:(IDPUsersModel *)usersModel {
    if (usersModel == _usersModel) {
        return;
    }
    
    [_usersModel removeObserver:self];
    
    _usersModel = usersModel;
    
    [_usersModel addObserver:self];
}

#pragma mark -
#pragma mark ModelObserver methods

- (void)modelDidChange:(id)model withModificationModel:(id)modification {
    [modification applyToTableView:self.usersView];
}

- (void)modelWillLoad {
    [self.preLaunchUsersView startLoadingAnimation];
}

- (void)modelDidLoad {
    IDPPreLaunchView *view = self.preLaunchUsersView;
    
    [UIView animateWithDuration:IDPAnimationDuration animations:^{
        view.alpha = 0;
        [view stopLoadingAnimation];
        [self.usersView reloadData];
    }];
}

@end
