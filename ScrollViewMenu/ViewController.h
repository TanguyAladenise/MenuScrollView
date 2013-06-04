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

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MenuScrollView *menuScrollView;
@property (weak, nonatomic) IBOutlet ExtendedScrollViewWrapper *extendedScrollViewWrapper;
@property (weak, nonatomic) IBOutlet UIView *bigBorderView;

@end
