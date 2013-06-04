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
    
    // tells viewcontroller is delegate of the menu
    self.menuScrollView.theDelegate = self;
    // create a border for the menu
    self.bigBorderView.frame = CGRectMake(self.bigBorderView.frame.origin.x, self.bigBorderView.frame.origin.y, self.menuScrollView.frame.size.width, self.bigBorderView.frame.size.height);
    self.bigBorderView.center = CGPointMake(self.menuScrollView.center.x, self.bigBorderView.center.y);
}

- (void)viewWillAppear:(BOOL)animated
{
    // add items to the menu
    [self.menuScrollView addItemWithText:@"Menu item 1"];
    [self.menuScrollView addItemWithText:@"Item 2"];
    [self.menuScrollView addItemWithText:@"Item 3"];
    [self.menuScrollView addItemWithText:@"Item 4"];
    [self.menuScrollView addItemWithText:@"Item 5"];
    
    // moves the menu to item wanted
    // can be use for example when you want to have a specific item focus on initialization
    [self.menuScrollView moveScrollViewToPageIndex:1 withAnimation:NO];
    
    // change textlabel
    self.textLabel.text = @"Item 2 text label";
    [self.textLabel sizeToFit];
    self.textLabel.center = CGPointMake(self.view.center.x, self.textLabel.center.y);
    
    // retrieve each item for customization
    for (UIButton *item in [self.menuScrollView getAllMenuItem]) {
        [item setTitleColor:[UIColor colorWithRed:81/255.0 green:188/255.0 blue:197/255.0 alpha:1] forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont fontWithName:@"System" size:11];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark MenuScrollView Delegate methods

// tell the view controller when the user changes menu item
- (void)menuMovedToItem:(UIButton *)item atIndex:(int)index {
    // update text label depending on menu selection
    self.textLabel.text = item.titleLabel.text;
    [self.textLabel sizeToFit];
    self.textLabel.center = CGPointMake(self.view.center.x, self.textLabel.center.y);
}
@end
