//
//  MenuScrollView.m
//  ScrollViewMenu
//
//  Created by Tanguy Aladenise on 6/3/13.
//  Copyright (c) 2013 Tanguy Aladenise. All rights reserved.
//

#define NUMBEROFVISIBLEITEM 3

#import "MenuScrollView.h"

@implementation MenuScrollView
{
    NSMutableArray *itemsCollection;
    float widthOfItem;
    UIEdgeInsets responseInsets;
    int indexItemSelected;
}


#pragma mark initialization methods

// called when initialized manually
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
- (void)initializationCode
{    
    self.backgroundColor = [UIColor clearColor];
    
    // Default initialazition pratice
    // for extra customization you can change things here
    self.scrollEnabled = YES;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.userInteractionEnabled = YES;
    self.delegate = self;
    
    // change clipsToBounds property if you want to hide/see menu items out of scrolliview bounds
    self.clipsToBounds = NO;
    
    // calculate widht of item
    [self calculateWidthOfItem];
    
    // center the scroll view in screen
    // you can change this to answer your needs
    self.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width / 2) - (widthOfItem/2), self.frame.origin.y, widthOfItem, self.frame.size.height);
    // sets scroll view contentSize
    [self calculateContentSize];
}

#pragma mark set up public methods

// add a new item to our menu
- (void)addItemWithText:(NSString *)text
{
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    // set item title
    [item setTitle:text forState:UIControlStateNormal];
    
    // add the item inside the menu at correct position
    int nbOfItem = [itemsCollection count];
    item.frame = CGRectMake(nbOfItem * widthOfItem, 0, widthOfItem, self.frame.size.height);
    
    // add event pressed listener
    [item addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    
    [self calculateContentSize];
    
    // add the item to the collection of items for future manipulation
    // make sure the array is existing otherwise instanciate it
    if (!itemsCollection) {
        itemsCollection = [[NSMutableArray alloc] init];
    }
    
    [itemsCollection addObject:item];
}



#pragma mark item methods

- (void)itemPressed:(id)sender
{
    UIButton *item = (UIButton *)sender;
    // we need to diferientiate wheter the button clicked is the current one or one out of bounds
    // if this is the current one we can trigger its action
    // if out of bounds the menu moves the item at the correct position
    
    if ([itemsCollection indexOfObject:item] == indexItemSelected)
    {
        // case when we can trigger button action
        // this behavior is not the best to detect when the user changes menu item focus
        // better take a look at -(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
        if ([self.theDelegate respondsToSelector:@selector(menuItemPressed:atIndex:)])
        {
            [self.theDelegate menuItemPressed:item atIndex:indexItemSelected];
        }
    }
    else
    {
        // case when we need to move the item in the center
        [self moveScrollViewToItem:(UIButton *)sender withAnimation:YES];
    }
}

// return item at specific index
- (UIButton *)getItemAtPage:(int)index
{
    return [itemsCollection objectAtIndex:index];
}

// return an array of all menu items
- (NSArray *)getAllMenuItem {
    return itemsCollection;
}


#pragma mark ScrollView animation methods

// move scroll view to specific item
- (void)moveScrollViewToItem:(UIButton *)item withAnimation:(BOOL)animation
{
    [self scrollRectToVisible:item.frame animated:animation];
}

- (void)moveScrollViewToPageIndex:(int)index withAnimation:(BOOL)animation
{
    UIButton *item = [itemsCollection objectAtIndex:index];
    [self scrollRectToVisible:item.frame animated:animation];
}


#pragma mark scroll view delegate methods


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // this code implement a method that is called once a scrollvew really did end animating !!!!
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    // methods triggered when scroll view did end moving
    // great to tell for sure if a user selected a new item
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.1];

}

// method called when scrollview ended up moving/animating
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // save previous index to make sure the user really changed item focus
    int prevIndex = indexItemSelected;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    indexItemSelected = lroundf(self.contentOffset.x/self.frame.size.width);
    
    if (prevIndex != indexItemSelected) {
        // trigger delegate method to inform item change
        if ([self.theDelegate respondsToSelector:@selector(menuMovedToItem:atIndex:)]) {
            [self.theDelegate menuMovedToItem:[itemsCollection objectAtIndex:indexItemSelected] atIndex:indexItemSelected];
        }
    }
}

#pragma calculation methods

// calculate width of item
- (void)calculateWidthOfItem
{
    // width of each item depends on numberofvisibleitem on screen
    widthOfItem = self.frame.size.width / NUMBEROFVISIBLEITEM;
}

// calculate contentsize of menu
- (void)calculateContentSize
{
    // the contentsize changes depending on how many items there is
    self.contentSize = CGSizeMake(widthOfItem * ([itemsCollection count] + 1), self.frame.size.height);
}


#pragma mark extend scrollable action outside of scroll view bounds

// Thanks to those two override methods we can tell when a user touches a button OUTSIDE of the MenuScrollView bounds
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    // Always return us.
    return view ;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // We want EVERYTHING!
    return YES;
}



@end
