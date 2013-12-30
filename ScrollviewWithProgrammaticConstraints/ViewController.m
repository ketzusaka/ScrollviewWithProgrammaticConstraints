//
//  ViewController.m
//  ScrollviewWithProgrammaticConstraints
//
//  Created by James Richard on 12/30/13.
//  Copyright (c) 2013 James Richard. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *mainViewOfScroller;
@property (nonatomic, strong) UIView *topLeft;
@property (nonatomic, strong) UIView *topRight;
@property (nonatomic, strong) UIView *bottomLeft;
@property (nonatomic, strong) UIView *bottomRight;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Instantiate our views
  self.scrollView = [[UIScrollView alloc] init];
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
  self.scrollView.backgroundColor = [UIColor blueColor];
  
  self.mainViewOfScroller = [[UIView alloc] init];
  self.mainViewOfScroller.translatesAutoresizingMaskIntoConstraints = NO;
  self.mainViewOfScroller.backgroundColor = [UIColor redColor];
  
  self.topLeft = [[UIView alloc] init];
  self.topLeft.translatesAutoresizingMaskIntoConstraints = NO;
  self.topLeft.backgroundColor = [UIColor yellowColor];
  
  self.topRight = [[UIView alloc] init];
  self.topRight.translatesAutoresizingMaskIntoConstraints = NO;
  self.topRight.backgroundColor = [UIColor greenColor];
  
  self.bottomLeft = [[UIView alloc] init];
  self.bottomLeft.translatesAutoresizingMaskIntoConstraints = NO;
  self.bottomLeft.backgroundColor = [UIColor purpleColor];
  
  self.bottomRight = [[UIView alloc] init];
  self.bottomRight.translatesAutoresizingMaskIntoConstraints = NO;
  self.bottomRight.backgroundColor = [UIColor blackColor];
  
  // Add subviews
  [self.mainViewOfScroller addSubview:self.topLeft];
  [self.mainViewOfScroller addSubview:self.topRight];
  [self.mainViewOfScroller addSubview:self.bottomLeft];
  [self.mainViewOfScroller addSubview:self.bottomRight];
  [self.scrollView addSubview:self.mainViewOfScroller];
  [self.view addSubview:self.scrollView];
  
  // Add constraints; Just a note, these could be done in a more concise way, but in order to describe what is going on i've broken them out.
  NSDictionary *views = @{
                          @"scrollView": self.scrollView,
                          @"mainViewOfScroller": self.mainViewOfScroller,
                          @"topLeft": self.topLeft,
                          @"topRight": self.topRight,
                          @"bottomLeft": self.bottomLeft,
                          @"bottomRight": self.bottomRight
                          };
  
  // Position topLeft and topRight horizontally in the mainViewOfScroller
  [self.mainViewOfScroller addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"|[topLeft][topRight]|"
                                           options:0
                                           metrics:nil
                                           views:views]];
  
  // Position topLeft and bottomLeft vertically in the mainViewOfScroller
  [self.mainViewOfScroller addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"V:|[topLeft][bottomLeft]|"
                                           options:0
                                           metrics:nil
                                           views:views]];

  // Position bottomLeft and bottomRight horizontally in the mainViewOfScroller
  [self.mainViewOfScroller addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"|[bottomLeft][bottomRight]|"
                                           options:0
                                           metrics:nil
                                           views:views]];
  
  // Position topRight and bottomRight vertically in the mainViewOfScroller
  [self.mainViewOfScroller addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"V:|[topRight][bottomRight]|"
                                           options:0
                                           metrics:nil
                                           views:views]];
  
  // These next lines are VERY important. These views have no intrinsicContentSize, like a label, so for our content size to "expand" they need to have constraints to make them larger.
  [self.topLeft addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.topLeft
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                               toItem:nil
                               attribute:0
                               multiplier:1.0
                               constant:500.0f]];
  
  [self.topLeft addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.topLeft
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                               toItem:nil
                               attribute:0
                               multiplier:1.0
                               constant:500.0f]];
  
  [self.topRight addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.topRight
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                               toItem:nil
                               attribute:0
                               multiplier:1.0
                               constant:500.0f]];
  
  [self.topRight addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.topRight
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                               toItem:nil
                               attribute:0
                               multiplier:1.0
                               constant:500.0f]];
  
  [self.bottomLeft addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.bottomLeft
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                               toItem:nil
                               attribute:0
                               multiplier:1.0
                               constant:500.0f]];
  
  [self.bottomLeft addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.bottomLeft
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                               toItem:nil
                               attribute:0
                               multiplier:1.0
                               constant:500.0f]];
  
  [self.bottomRight addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.bottomRight
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                               toItem:nil
                               attribute:0
                               multiplier:1.0
                               constant:500.0f]];
  
  [self.bottomRight addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.bottomRight
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                               toItem:nil
                               attribute:0
                               multiplier:1.0
                               constant:500.0f]];
  
  // Now our low level views have the sizing, but since our contentSize of the scroll view is only going to be determined by the sizing of it's immediate subviews, we need a way for our mainViewOfScroller to match the size of ITS subviews.
  // This is a bit of a complicated setup, and I'm doing this to show the asker. In practice, it'd be best to completely skip this view and add topLeft, topRight, bottomLeft, and bottomRight directly to the scrollView.
  // Note that in this example the bottom views widths are not considered for the mainViewOfScroller, but they are the same size.
  
  // To start, lets make the left edge of the mainViewOfScroller be equal to the left edge of the topLeft view.
  [self.mainViewOfScroller addConstraint:[NSLayoutConstraint
                                          constraintWithItem:self.mainViewOfScroller
                                          attribute:NSLayoutAttributeLeft
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.topLeft
                                          attribute:NSLayoutAttributeLeft
                                          multiplier:1.0f
                                          constant:0.0f]];
  
  
  // Next we need to define the right edge limits, thus giving our mainViewOfScroller a width.
  [self.mainViewOfScroller addConstraint:[NSLayoutConstraint
                                          constraintWithItem:self.mainViewOfScroller
                                          attribute:NSLayoutAttributeRight
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.topRight
                                          attribute:NSLayoutAttributeRight
                                          multiplier:1.0f
                                          constant:0.0f]];
  
  
  // Now we need to give the mainViewOfScroller a height. We'll use similar logic as above, but on the top and bottom
  [self.mainViewOfScroller addConstraint:[NSLayoutConstraint
                                          constraintWithItem:self.mainViewOfScroller
                                          attribute:NSLayoutAttributeTop
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.topLeft
                                          attribute:NSLayoutAttributeTop
                                          multiplier:1.0f
                                          constant:0.0f]];
  
  
  [self.mainViewOfScroller addConstraint:[NSLayoutConstraint
                                          constraintWithItem:self.mainViewOfScroller
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.bottomLeft
                                          attribute:NSLayoutAttributeBottom
                                          multiplier:1.0f
                                          constant:0.0f]];
  
  
  // Now our mainViewOfScroller will grow to match the size of all it's subviews. Next, we need to say that the mainViewOfScroller's edges match the scrollView's edges.
  [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[mainViewOfScroller]|" options:0 metrics:nil views:views]];
  [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainViewOfScroller]|" options:0 metrics:nil views:views]];
  
  // Lastly, lets make our scroll view's bounds match our views bounds
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:0 metrics:nil views:views]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:views]];
}

@end
