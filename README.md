MenuScrollView
==============

<p>Create a paging swappable menu, easily customizable, with item interactive outside of bounds.</p>

<img alt="ScreenShot Menu" src="https://github.com/TanguyAladenise/MenuScrollView/blob/master/MenuScreenshot.png?raw=true" width="320px"/>


How To Get Started
------------------

Just add "MenuScrollView.h" and "MenuScrollView.m" into your xcodeproject. 
Don't forget to import it wherever you need them :

``` objective-c
#import "MenuScrollView.h"
```

Wheter you use a nib or just hard code your user interface, you just need to create a new view of type MenuScrollView. 
Then, you only need to add items to your menu:

``` objective-c
// Add items to the menu
[self.menuScrollView addItemWithTitle:@"Menu item 1"];
[self.menuScrollView addItemWithTitle:@"Menu item 2"];
[self.menuScrollView addItemWithTitle:@"Menu item 3"];
// and so on
```

Delegate Methods
----------------

The MenuScrollView comes with a delegate protocol in order to handle user interaction with the menu. 
Two optional methods:
    `-menuItemPressed:(UIButton *)item atIndex:(int)index;`
    `-menuMovedToItem:(UIButton *)item atIndex:(int)index;`
    Thanks to those two methods you can actualize your interface or trigger actions when the user changes the menu item selected:

``` objective-c

#pragma mark MenuScrollView Delegate methods

// Handle user selecting new menu item
- (void)menuMovedToItem:(UIButton *)item atIndex:(int)index {
    
    // Update text label depending on menu selection
    self.textLabel.text =  [NSString stringWithFormat:@"Menu item selected : %@", item.titleLabel.text];
    [self.textLabel sizeToFit];
}

// This behavior is less likely to be used. It is used when a menu item on focus is touched. It's just here in case someone may find it useful...
- (void)menuItemPressed:(UIButton *)item atIndex:(int)index {
    self.textLabel.text = item.titleLabel.text;
   [self.textLabel sizeToFit];
}

```

Usefull methods
---------------

<p>Manually change menu focus on item, with animation or not:</p>
``` objective-c
// Set/Move the menu to desired item
// Great for initialization or to switch menu item automatically
[self.menuScrollView  moveMenuScrollViewToIndex:1 animated:NO];
```

<p>Get menu items for manipulations or customizations:</p>
``` objective-c

// Access each menu item for customization or extra manipulation
for (UIButton *item in self.menuScrollView.itemsCollection) {
	// Customise view as you want
    [item setTitleColor:[UIColor colorWithRed:81/255.0 green:188/255.0 blue:197/255.0 alpha:1] forState:UIControlStateNormal];
}

// OR

// Access a specific item in the menu for customization
UIButton *menuItem = [self.menuScrollView getItemAtIndex:4];
[menuItem setBackgroundColor:[UIColor redColor]]

```

More
----

<p>Any suggestions are welcome ! as I am looking to learn good practices, to understand better behaviors and Objective-C in general !
Thank you.</p>

