//
//  ViewController.m
//  ScrollViewMenu
//
//  Created by Tanguy Aladenise on 6/3/13.
//  Copyright (c) 2013 Tanguy Aladenise. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // MUST TO DO
    // tells the wrapper which scroll view it contains
    self.extendedScrollViewWrapper.scrollView = self.menuScrollView;
    // create a border for the menu
    self.bigBorderView.frame = CGRectMake(self.bigBorderView.frame.origin.x, self.bigBorderView.frame.origin.y, self.menuScrollView.frame.size.width, self.bigBorderView.frame.size.height);
    self.bigBorderView.center = CGPointMake(self.menuScrollView.center.x, self.bigBorderView.center.y);
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.menuScrollView addItemWithText:@"TEST 1"];
    [self.menuScrollView addItemWithText:@"TEST 2"];
    [self.menuScrollView addItemWithText:@"TEST 3"];
    [self.menuScrollView addItemWithText:@"TEST 4"];
    [self.menuScrollView addItemWithText:@"TEST 5"];
    
    [self.menuScrollView moveScrollViewToPageIndex:1 withAnimation:NO];
    
    for (UIButton *item in [self.menuScrollView getAllMenuItem]) {
        [item setTitleColor:[UIColor colorWithRed:81/255.0 green:188/255.0 blue:197/255.0 alpha:1] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
