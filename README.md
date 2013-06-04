MenuScrollView
==============

<p>Create a paging swappable menu, easily customizable, with item interactive outside of bounds for paging effect.</p>

How To Get Started
------------------

Just add "MenuScrollView.h" and "MenuScrollView.m" in your xcodeproject. If you want the menu to handle touches outside of its bounds you must add "ExtendedScrollViewWrapper.h" and "ExtendedScrollViewWrapper.m" in your xcodeproject as well. Don't forget to import those wherever you need them :

``` objective-c
#import "MenuScrollView.h"
#import "ExtendedScrollViewWrapper.h"
```

Wheter you use a nib or just hard code user interface you just need to create a new view of type MenuScrollView. 
You must add this view inside an ExtendedScrollViewWrapper if you want it to respond to items outside of bounds, which is, at this time, the default behavior.

Then, you only need to add items to your menu :

``` objective-c
// add items to the menu
[self.myMenuScrollView addItemWithText:@"Menu item 1"];
[self.myMenuScrollView addItemWithText:@"Menu item 2"];
[self.myMenuScrollView addItemWithText:@"Menu item 3"];
// and so on
```

<p>By default the menu will display 3 items at a time on screen. The one in the middle being the one having focus. You can easily change this behavior by changing a #define var in "MenuScrollView.m". Also, by default the menu always center itself on the screen.</p>
``` objective-c
//
//  MenuScrollView.m
//  ScrollViewMenu
//
//  Created by Tanguy Aladenise on 6/3/13.
//  Copyright (c) 2013 Tanguy Aladenise. All rights reserved.
//


#define NUMBEROFVISIBLEITEM 3

// ... //

// you can change this to answer your needs (though you should not change frame width)
// centers horizontally the menu in the screen
self.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width / 2) - (widthOfItem/2), self.frame.origin.y, widthOfItem, self.frame.size.height);


```

Delegate Methods
----------------

The class comes with a delegate protocol in order to handle user interaction with the menu. 
Two optional methods :
    `-menuItemPressed:(UIButton *)item atIndex:(int)index;`
    `-menuMovedToItem:(UIButton *)item atIndex:(int)index;`
    Thanks to those two methods you can actualize your interface or trigger actions when the user changes the menu item selected :

``` objective-c

#pragma mark MenuScrolLView Delegate methods

// tell the view controller when the user changes menu item
// this is the method to use to handle user interaction with the menu
- (void)menuMovedToItem:(UIButton *)item atIndex:(int)index {
    // for example update a text label depending on menu selection
    self.textLabel.text = item.titleLabel.text;
    // just in case resize label to fit string
    [self.textLabel sizeToFit];
}

// this behavior is less likely to be used. It is used when a menu item on focus is touch. It's just here in case someone may find it useful...
- (void)menuItemPressed:(UIButton *)item atIndex:(int)index {
    self.textLabel.text = item.titleLabel.text;
   [self.textLabel sizeToFit];
}

```

Usefull methods
---------------

<p>Manually change menu focus on item, with animation or not:</p>
``` objective-c
// moves the menu to the item/page wanted
// can be use for example when you want to have a specific item focus on initialization
[self.myMenuScrollView moveScrollViewToPageIndex:1 withAnimation:NO];
```

<p>Get menu item for manipulations or customizations:</p>
``` objective-c
// retrieve all menu item for customization
for (UIButton *item in [self.myMenuScrollView getAllMenuItem]) {
    [item setTitleColor:[UIColor colorWithRed:81/255.0 green:188/255.0 blue:197/255.0 alpha:1] forState:UIControlStateNormal];
    item.titleLabel.font = [UIFont fontWithName:@"System" size:11];
}

// OR //

// for individual treatment
[self.myMenuScrollView getItemAtPage:1].titleLabel.font = [UIFont fontWithName:@"System" size:11];

```

More
----

<p>Any suggestions are welcome ! as I am looking to learn good practices, to understand better behaviors and Objective-c in general !
Thank you.</p>

