//
//  ExtendedScrollViewWrapper.m
//  ScrollViewMenu
//
//  Created by Tanguy Aladenise on 6/4/13.
//  Copyright (c) 2013 Tanguy Aladenise. All rights reserved.
//


// Thanks to this wrapper, the scroll view will respond to touch and swipe out of its own bounds //

#import "ExtendedScrollViewWrapper.h"
#import <QuartzCore/QuartzCore.h>

@implementation ExtendedScrollViewWrapper

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializationCode];

    }
    return self;
}

// called when initialized from a nib
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self initializationCode];
    }
    return self;
}

// code initializing the view
// you can customize this appearance has needed
- (void)initializationCode
{
    self.backgroundColor = [UIColor whiteColor];
    
    // drop shadow effect 
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 1.0;
    self.layer.shadowOffset = CGSizeMake(0,-1);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}


// VERY IMPORTANT TO KEEP THIS IF YOU WANT YOUR MENUSCROLLVIEW TO RESPONDS TOUCHES OUT OF ITS BOUNDS
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == self)
        return [self scrollView];
    
    return view;
}


@end
