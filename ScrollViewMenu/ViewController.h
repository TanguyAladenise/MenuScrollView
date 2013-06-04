//
//  ViewController.h
//  ScrollViewMenu
//
//  Created by Tanguy Aladenise on 6/3/13.
//  Copyright (c) 2013 Tanguy Aladenise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuScrollView.h"
#import "ExtendedScrollViewWrapper.h"

// to handle custom action from menu item pressed
@interface ViewController : UIViewController <MenuScrollViewDelegate>

@property (weak, nonatomic) IBOutlet MenuScrollView *menuScrollView;
@property (weak, nonatomic) IBOutlet ExtendedScrollViewWrapper *extendedScrollViewWrapper;
@property (weak, nonatomic) IBOutlet UIView *bigBorderView;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end
