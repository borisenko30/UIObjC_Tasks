//
//  IDPMainTableView.m
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPMainTableView.h"

#import "IDPUsersModel.h"

#import "UINib+IDPExtensions.h"

#import "IDPMacro.h"

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
    IDPPreLaunchUsersView *preLaunchUsersView = [UINib objectWithClass:[IDPPreLaunchUsersView class]];
    
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

- (void)modelDidChange:(id)model {
    [self.usersView reloadData];
    //temporary stub - should use transient states
    self.usersModel.state = IDPModelDidUnload;
}

- (void)modelWillLoad:(id)model {
    self.preLaunchUsersView.hidden = NO;
    [self.preLaunchUsersView startLoadingAnimation];
}

- (void)modelDidLoad:(id)model {
    self.preLaunchUsersView.hidden = YES;
    [self.preLaunchUsersView stopLoadingAnimation];
    [self.usersView reloadData];
}

@end
