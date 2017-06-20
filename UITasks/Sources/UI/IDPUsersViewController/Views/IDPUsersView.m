//
//  IDPUsersView.m
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUsersView.h"

#import "IDPBlockObservationController.h"

#import "IDPMacro.h"

static const NSUInteger IDPUsersCount = 5;

@interface IDPUsersView ()
@property (nonatomic, strong) IDPUsersModel *usersModel;
@property (nonatomic, strong) IDPBlockObservationController *observer;

@end

@implementation IDPUsersView

#pragma mark -
#pragma mark Deallocations and initializations

- (instancetype)init {
    self = [super init];
    [self initModel];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initModel];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initModel];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self initModel];
    
    return self;
}

- (void)initModel {
    self.usersModel = [[IDPUsersModel alloc] initWithUsersWithCount:IDPUsersCount];
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
    [observer setHandler:^(IDPBlockObservationController *controller, id userInfo) {
        IDPStrongify(self)
        [self reloadData];
        self.usersModel.state = IDPUsersModelUnchanged;
    } forState:IDPUsersModelChanged];
}

#pragma mark -
#pragma mark Public



@end
