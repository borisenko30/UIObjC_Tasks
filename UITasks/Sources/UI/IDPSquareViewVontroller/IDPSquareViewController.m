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

static NSString * const IDPStartButtonTitle = @"Start";
static NSString * const IDPStopButtonTitle  = @"Stop";

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
    IDPSquareView *squareView = self.mainView.squareView;
    squareView.running = !squareView.running;
    [self.mainView.button setTitle:squareView.running ? IDPStopButtonTitle : IDPStartButtonTitle
                          forState:UIControlStateNormal];
}

- (IBAction)onTouchNext:(UIButton *)sender {
    IDPSquareView *squareView = self.mainView.squareView;
    [squareView setSquarePosition:[squareView nextPosition]];
}

@end
