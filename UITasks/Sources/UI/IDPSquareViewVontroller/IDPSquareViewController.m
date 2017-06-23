//
//  IDPSquareViewController.m
//  UITask01
//
//  Created by Student003 on 6/12/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPSquareViewController.h"

#import "IDPMainView.h"
#import "IDPSquareView.h"

#import "IDPMacro.h"

IDPViewControllerBaseViewProperty(IDPSquareViewController, mainView, IDPMainView)

@implementation IDPSquareViewController

#pragma mark -
#pragma mark Public

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Private

- (IBAction)onTouchStart:(UIButton *)sender {
    [self.mainView run];
}

- (IBAction)onTouchNext:(UIButton *)sender {
    [self.mainView.squareView moveSquareToNextPosition];
}

@end
