//
//  IDPMainTableView.m
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPMainTableView.h"

#import "IDPUsersModel.h"

#import "IDPBlockObservationController.h"

#import "UINib+IDPExtensions.h"

#import "IDPMacro.h"

@interface IDPMainTableView ()
@property (nonatomic, strong) IDPUsersModel *usersModel;
@property (nonatomic, strong) IDPBlockObservationController *observer;

@end

@implementation IDPMainTableView

#pragma mark -
#pragma mark Deallocations and initializations

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
    
    _usersModel = usersModel;
    
    self.observer = [_usersModel blockObservationControllerWithObserver:self];
}

- (void)setObserver:(IDPBlockObservationController *)observer {
    if (observer == _observer) {
        return;
    }
    
    _observer = observer;
    
    IDPWeakify(self)
    IDPStateChangeHandler handler = ^(IDPBlockObservationController *controller, id userInfo) {
        IDPStrongify(self)
        [self.usersView reloadData];
        self.usersModel.state = IDPUsersModelIdle;
    };
    
    [observer setHandler:handler forState:IDPUsersModelDidChange];
    
    handler = ^(IDPBlockObservationController *controller, id userInfo) {
        IDPStrongify(self)
        self.preLaunchUsersView.hidden = NO;
        [self.preLaunchUsersView modelDidBeginLoading];
        self.usersModel.state = IDPUsersModelIdle;
    };
    
    [observer setHandler:handler forState:IDPUsersModelDidBeginLoading];
    
    
    handler = ^(IDPBlockObservationController *controller, id userInfo) {
        IDPStrongify(self)
        self.preLaunchUsersView.hidden = YES;
        [self.preLaunchUsersView modelDidLoad];
        self.usersModel.state = IDPUsersModelIdle;
    };
    
    [observer setHandler:handler forState:IDPUsersModelDidLoad];
    
}

#pragma mark -
#pragma mark Public


@end
