//
//  MenuScrollView.h
//  ScrollViewMenu
//
//  Created by Tanguy Aladenise on 6/3/13.
//  Copyright (c) 2013 Tanguy Aladenise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuScrollView : UIScrollView <UIScrollViewDelegate>

// public method

// add a menu item to the menu
- (void)addItemWithText:(NSString *)text;

// move scroll view to a specific page
- (void)moveScrollViewToPageIndex:(int)index withAnimation:(BOOL)animation;

// get an item at index
- (UIButton *)getItemAtPage:(int)index;

//get all item
- (NSArray *)getAllMenuItem;


@end
