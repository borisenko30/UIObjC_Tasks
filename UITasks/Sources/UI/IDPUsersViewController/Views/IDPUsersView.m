//
//  IDPUsersView.m
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUsersView.h"

static const NSUInteger IDPUsersCount = 100;

@interface IDPUsersView ()
@property (nonatomic, strong) IDPUsersTable *table;

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
    IDPUsersTable *table = self.table;
    table = [IDPUsersTable new];
    [table addUsersWithCount:IDPUsersCount];
    self.table = table;
}

#pragma mark -
#pragma mark Public



@end
