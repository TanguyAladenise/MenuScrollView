//
//  ViewController.m
//  MenuScrollView
//
//  Created by Tanguy Aladenise on 28/01/14.
//  Copyright (c) 2014 Tanguy Aladenise. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MenuScrollView *menuScrollView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Example of use
    
    // First be delegate of the MenuScrollView
    self.menuScrollView.theDelegate = self;
    
    // Add items to the menu
    [self.menuScrollView addItemWithTitle:@"Item 1"];
    [self.menuScrollView addItemWithTitle:@"Item 2"];
    [self.menuScrollView addItemWithTitle:@"Item 3"];
    [self.menuScrollView addItemWithTitle:@"Item 4"];
    [self.menuScrollView addItemWithTitle:@"Item 5"];
    
    // Set/Move the menu to desired item
    [self.menuScrollView moveMenuScrollViewToIndex:1 animated:NO];
    
    // Access each menu item for customization or extra manipulation
    for (UIButton *item in self.menuScrollView.itemsCollection) {
        // Customize view as you want
        [item setTitleColor:[UIColor colorWithRed:81/255.0 green:188/255.0 blue:197/255.0 alpha:1] forState:UIControlStateNormal];
    }
    
    // Access a specific item in the menu for customization
    UIButton *menuItem = [self.menuScrollView getItemAtIndex:4];
    [menuItem setBackgroundColor:[UIColor redColor]];
}


#pragma mark - MenuScrollView Delegate methods

// Handle user selecting new menu item
- (void)menuMovedToItem:(UIButton *)item atIndex:(int)index {
    
    // Update text label depending on menu selection
    self.textLabel.text =  [NSString stringWithFormat:@"Menu item selected : %@", item.titleLabel.text];
    [self.textLabel sizeToFit];
    self.textLabel.center = CGPointMake(self.view.center.x, self.textLabel.center.y);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
