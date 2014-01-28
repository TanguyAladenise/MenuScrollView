//
//  MenuScrollView.m
//  ScrollViewMenu
//
//  Created by Tanguy Aladenise on 6/3/13.
//  Copyright (c) 2013 Tanguy Aladenise. All rights reserved.
//

#import "MenuScrollView.h"

@interface MenuScrollView ()

@property (nonatomic, readwrite) NSMutableArray *itemsCollection;
@property int indexItemSelected;

@end

@implementation MenuScrollView


#pragma mark - Lifecycle

// Called when initialized manually
- (id)initWithFrame:(CGRect)frame
{    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

// Called when initialized from a nib
- (id)initWithCoder:(NSCoder *)aDecoder
{    
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

// Initializing the view
- (void)initView
{
    // Default initialazition pratice
    
    // For extra customization you can change things here
    self.scrollEnabled = YES;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    // ScrollView delegate methods
    self.delegate = self;
    
    // Set clipsToBounds property to YES if you want to hide menu items out of scrollview bounds
    self.clipsToBounds = NO;
    
    // Calculate scroll view contentSize
    [self calculateContentSize];
}

#pragma mark - Public

// Add a new item to the menu
- (void)addItemWithTitle:(NSString *)title
{
    // A menu item is made with an UIButton
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    // Set item title
    [item setTitle:title forState:UIControlStateNormal];
    
    // Add the item inside the menu at the correct position
    int nbOfItem = [self.itemsCollection count];
    item.frame = CGRectMake(nbOfItem * CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    // Add event pressed listener
    [item addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    
    // Recalculate scrollview content size
    [self calculateContentSize];
    
    
    // Add the item to the collection of items for future manipulation
    [self.itemsCollection addObject:item];
}

// Return item at specific index
- (UIButton *)getItemAtIndex:(int)index
{
    return [self.itemsCollection objectAtIndex:index];
}

- (void)moveMenuScrollViewToIndex:(int)index animated:(BOOL)animation
{
    UIButton *item = [self.itemsCollection objectAtIndex:index];
    [self scrollRectToVisible:item.frame animated:animation];
}

#pragma mark - Action

// Handle menu item being pressed by user
- (void)itemPressed:(id)sender
{
    UIButton *item = (UIButton *)sender;
    // We need to diferientiate wheter the button clicked is the current one or one out of bounds
    // If this is the current one we can trigger its action
    // If out of bounds the menu moves the item at the correct position and triggers action
    
    if ([self.itemsCollection indexOfObject:item] == self.indexItemSelected)
    {
        // Case when we can trigger button action
        // This behavior isn't really usefull since the purpose of the menu is to trigger event
        // when the user switched from an item to another.
        // But just in case it's there
        if ([self.theDelegate respondsToSelector:@selector(menuItemPressed:atIndex:)])
        {
            [self.theDelegate menuItemPressed:item atIndex:self.indexItemSelected];
        }
    }
    else
    {
        // Case when we need to move the item in the center
        [self moveScrollViewToItem:(UIButton *)sender withAnimation:YES];
    }
}

#pragma mark ScrollView animation methods

// Move scroll view to specific item
- (void)moveScrollViewToItem:(UIButton *)item withAnimation:(BOOL)animation
{
    [self scrollRectToVisible:item.frame animated:animation];
}

#pragma mark - Delegate

#pragma mark -- ScrollView Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // This code implement a method that is called once a scrollview really did end animating !!!!
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    // Methods triggered when scroll view did end moving
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.1];
}

// Method called when scrollview ended up moving/animating
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    // Save previous index to make sure the user really changed item focus
    int prevIndex = self.indexItemSelected;
    // Calculate new index
    self.indexItemSelected = lroundf(self.contentOffset.x/CGRectGetWidth(self.frame));
    
    // Check if user really moved the menu
    if (prevIndex != self.indexItemSelected) {
        // Trigger delegate method to inform item change
        if ([self.theDelegate respondsToSelector:@selector(menuMovedToItem:atIndex:)]) {
            [self.theDelegate menuMovedToItem:[self.itemsCollection objectAtIndex:self.indexItemSelected] atIndex:self.indexItemSelected];
        }
    }
}

#pragma - Utility

// Calculate contentsize of menu
- (void)calculateContentSize
{
    // The contentsize changes depending on how many items there is in the menu
    // Therefore needs to be recalculated each time an item is added to the menu
    self.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * ([self.itemsCollection count] + 1), CGRectGetHeight(self.frame));
}


#pragma mark - OVERRIDE

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

# pragma mark - Getters

- (NSMutableArray *)itemsCollection
{
    // Lazy instantiate array
    if (!_itemsCollection) {
        _itemsCollection = [[NSMutableArray alloc] init];
    }
    
    return _itemsCollection;
}


@end
