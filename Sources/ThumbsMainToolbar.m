//
//	ThumbsMainToolbar.m
//	Reader v2.6.0
//
//	Created by Julius Oklamcak on 2011-09-01.
//	Copyright © 2011-2012 Julius Oklamcak. All rights reserved.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//	of the Software, and to permit persons to whom the Software is furnished to
//	do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "ReaderConstants.h"
#import "ThumbsMainToolbar.h"
#import "UIImage+Tint.h"

@implementation ThumbsMainToolbar

#pragma mark Constants

#define BUTTON_X 8.0f
#define BUTTON_Y 8.0f
#define BUTTON_SPACE 8.0f
#define BUTTON_HEIGHT 30.0f

#define DONE_BUTTON_WIDTH 56.0f
#define SHOW_CONTROL_WIDTH 78.0f

#define TITLE_HEIGHT 28.0f

#pragma mark Properties

@synthesize delegate;

#pragma mark ThumbsMainToolbar instance methods

- (id)initWithFrame:(CGRect)frame
{
	return [self initWithFrame:frame title:nil];
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
	if ((self = [super initWithFrame:frame])) {
        
        UIBarButtonItem* flexibleSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem* fixedSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpaceButton.width = 20;
        
        // init
        self.alpha = 1.000;
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        self.barStyle = UIBarStyleBlackOpaque;
        self.clearsContextBeforeDrawing = NO;
        self.clipsToBounds = NO;
        self.contentMode = UIViewContentModeScaleToFill;
        //self.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
        self.hidden = NO;
        self.multipleTouchEnabled = NO;
        self.opaque = NO;
        self.userInteractionEnabled = YES;
                
        // close button
        UIBarButtonItem* closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(doneButtonTapped:)];
        closeButton.enabled = YES;
        closeButton.imageInsets = UIEdgeInsetsZero;
        closeButton.style = UIBarButtonItemStylePlain;
        closeButton.width = 32.000;
        
        // title
        UIButton *titleButton = [[UIButton alloc] initWithFrame:frame];
        [titleButton setTitle:title forState:UIControlStateNormal];
        UIBarButtonItem *titleLabel = [[UIBarButtonItem alloc] initWithCustomView:titleButton];
    
        // switch for thumbnails / bookmarks
		CGFloat viewWidth = self.bounds.size.width;
		CGFloat showControlX = (viewWidth - (SHOW_CONTROL_WIDTH + BUTTON_SPACE));        

        UIImage *thumbsImage = [[UIImage imageNamed:@"Reader-Thumbs"] imageTintedWithColor:[UIColor whiteColor]];
		UIImage *bookmarkImage = [UIImage imageNamed:@"Reader-Mark-Y"];

		NSArray *buttonItems = [NSArray arrayWithObjects:thumbsImage, bookmarkImage, nil];
        
		UISegmentedControl *showControl = [[UISegmentedControl alloc] initWithItems:buttonItems];
        
		showControl.frame = CGRectMake(showControlX, BUTTON_Y, SHOW_CONTROL_WIDTH, BUTTON_HEIGHT);
		showControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		showControl.segmentedControlStyle = UISegmentedControlStyleBar;
		showControl.tintColor = [UIColor darkGrayColor];
		showControl.selectedSegmentIndex = 0; // Default segment index
        
		[showControl addTarget:self action:@selector(showControlTapped:) forControlEvents:UIControlEventValueChanged];
        
        
        UIBarButtonItem *segBarBtn;
        segBarBtn = [[UIBarButtonItem alloc] initWithCustomView:showControl];
        
        
        // add to toolbar
        [self setItems:@[closeButton, flexibleSpaceButton, titleLabel, flexibleSpaceButton, segBarBtn]];
                 
	}

	return self;
}

#pragma mark UISegmentedControl action methods

- (void)showControlTapped:(UISegmentedControl *)control
{
	[delegate tappedInToolbar:self showControl:control];
}

#pragma mark UIButton action methods

- (void)doneButtonTapped:(UIButton *)button
{
	[delegate tappedInToolbar:self doneButton:button];
}

@end
