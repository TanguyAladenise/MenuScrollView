//
//  MenuScrollView.h
//  ScrollViewMenu
//
//  Created by Tanguy Aladenise on 6/3/13.
//  Copyright (c) 2013 Tanguy Aladenise. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuScrollViewDelegate;

@interface MenuScrollView : UIScrollView <UIScrollViewDelegate>

// Avoid conflict with self.delegate property from UISCrollView
@property (nonatomic, assign) id <MenuScrollViewDelegate> theDelegate;
@property (nonatomic, readonly) NSMutableArray *itemsCollection;


// add a menu item to the menu
- (void)addItemWithTitle:(NSString *)title;

// move scroll view to a specific page
- (void)moveMenuScrollViewToIndex:(int)index animated:(BOOL)animation;

// get an item at index
- (UIButton *)getItemAtIndex:(int)index;

@end

// define MenuScrollViewDelegate
@protocol MenuScrollViewDelegate <NSObject>

@optional
- (void)menuItemPressed:(UIButton *)item atIndex:(int)index;
@optional
- (void)menuMovedToItem:(UIButton *)item atIndex:(int)index;

@end
