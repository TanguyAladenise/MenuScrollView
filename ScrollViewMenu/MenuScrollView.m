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
    self.scrollEnabled = YES;
    self.pagingEnabled = YES;
    self.clipsToBounds = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.userInteractionEnabled = YES;
    self.delegate = self;
    
    // calculate widht of item
    [self calculateWidthOfItem];
    // center the scroll view in screen
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
    // TO DO set up properties of the item
    
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
        [self.theDelegate menuItemPressed:item atIndex:indexItemSelected];
    }
    else
    {
        // case when we need to move the item in the center
        [self moveScrollViewToItem:(UIButton *)sender];
    }
}

- (UIButton *)getItemAtPage:(int)index
{
    return [itemsCollection objectAtIndex:index];
}

- (NSArray *)getAllMenuItem {
    return itemsCollection;
}



#pragma mark Scroll View animation methods

- (void)moveScrollViewToItem:(UIButton *)item
{
    [self scrollRectToVisible:item.frame animated:YES];
}

- (void)moveScrollViewToPageIndex:(int)index withAnimation:(BOOL)animation
{
    UIButton *item = [itemsCollection objectAtIndex:index];
    [self scrollRectToVisible:item.frame animated:animation];
}



#pragma calculation methods

// calculate width of item
- (void)calculateWidthOfItem
{
    widthOfItem = self.frame.size.width / NUMBEROFVISIBLEITEM;
}

// calculate contentsize of menu
- (void)calculateContentSize
{
    self.contentSize = CGSizeMake(widthOfItem * ([itemsCollection count] + 1), self.frame.size.height);
}


#pragma mark scroll view delegate methods


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // this code implement a method that is called once a scrollvew really did end animating !!!!
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //ensure that the end of scroll is fired.
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.1];
    
}

// method called when scrollview ended up moving/animating
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    indexItemSelected = lroundf(self.contentOffset.x/self.frame.size.width);
}



#pragma mark extend scrollable action outside of scroll view bounds

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



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
