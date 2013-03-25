//
//	ReaderMainToolbar.m
//	Reader v2.6.1
//
//	Created by Julius Oklamcak on 2011-07-01.
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
#import "ReaderMainToolbar.h"
#import "ReaderDocument.h"

#import <MessageUI/MessageUI.h>

@implementation ReaderMainToolbar {
    UIColor *markColorN;
    UIColor *markColorY;
}

#pragma mark Constants

#define BUTTON_WIDTH 32.0f

#pragma mark Properties

@synthesize delegate;

#pragma mark ReaderMainToolbar instance methods

- (id)initWithFrame:(CGRect)frame
{
	return [self initWithFrame:frame document:nil];
}

- (id)initWithFrame:(CGRect)frame document:(ReaderDocument *)object
{
	assert(object != nil); // Must have a valid ReaderDocument

	if ((self = [super initWithFrame:frame])) {

        UIBarButtonItem* flexibleSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem* fixedSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpaceButton.width = 20;
        
        markColorN = [UIColor whiteColor]; // N color
		markColorY = [UIColor blueColor]; // Y color
/*
        
#if (READER_ENABLE_MAIL == TRUE) // Option

		if ([MFMailComposeViewController canSendMail] == YES) // Can email
		{
			unsigned long long fileSize = [object.fileSize unsignedLongLongValue];

			if (fileSize < (unsigned long long)15728640) // Check attachment size limit (15MB)
			{
				rightButtonX -= (EMAIL_BUTTON_WIDTH + BUTTON_SPACE);

				UIButton *emailButton = [UIButton buttonWithType:UIButtonTypeCustom];

				emailButton.frame = CGRectMake(rightButtonX, BUTTON_Y, EMAIL_BUTTON_WIDTH, BUTTON_HEIGHT);
				[emailButton setImage:[UIImage imageNamed:@"Reader-Email"] forState:UIControlStateNormal];
				[emailButton addTarget:self action:@selector(emailButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
				[emailButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
				[emailButton setBackgroundImage:buttonN forState:UIControlStateNormal];
				emailButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;

				[self addSubview:emailButton]; titleWidth -= (EMAIL_BUTTON_WIDTH + BUTTON_SPACE);
			}
		}

#endif // end of READER_ENABLE_MAIL Option

#if (READER_ENABLE_PRINT == TRUE) // Option

		if (object.password == nil) // We can only print documents without passwords
		{
			Class printInteractionController = NSClassFromString(@"UIPrintInteractionController");

			if ((printInteractionController != nil) && [printInteractionController isPrintingAvailable])
			{
				rightButtonX -= (PRINT_BUTTON_WIDTH + BUTTON_SPACE);

				UIButton *printButton = [UIButton buttonWithType:UIButtonTypeCustom];

				printButton.frame = CGRectMake(rightButtonX, BUTTON_Y, PRINT_BUTTON_WIDTH, BUTTON_HEIGHT);
				[printButton setImage:[UIImage imageNamed:@"Reader-Print"] forState:UIControlStateNormal];
				[printButton addTarget:self action:@selector(printButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
				[printButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
				[printButton setBackgroundImage:buttonN forState:UIControlStateNormal];
				printButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;

				[self addSubview:printButton]; titleWidth -= (PRINT_BUTTON_WIDTH + BUTTON_SPACE);
			}
		}

#endif // end of READER_ENABLE_PRINT Option
    */

        // init
        self.alpha = 1.000;
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        self.barStyle = UIBarStyleBlackTranslucent;
        self.clearsContextBeforeDrawing = NO;
        self.clipsToBounds = NO;
        self.contentMode = UIViewContentModeScaleToFill;
        //self.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
        self.hidden = NO;
        self.multipleTouchEnabled = NO;
        self.opaque = NO;
        self.userInteractionEnabled = YES;
        
        // close button
        UIBarButtonItem* closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)];
        closeButton.enabled = YES;
        closeButton.imageInsets = UIEdgeInsetsZero;
        closeButton.style = UIBarButtonItemStylePlain;
        closeButton.width = BUTTON_WIDTH;
        
        // thumbs button
        UIBarButtonItem* thumbsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Reader-Thumbs"] style:UIBarButtonItemStylePlain target:self action:@selector(thumbsButtonTapped:)];
        thumbsButton.enabled = YES;
        thumbsButton.imageInsets = UIEdgeInsetsZero;
        thumbsButton.width = BUTTON_WIDTH;

        // mark button
        self.markButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Reader-Mark-N"] style:UIBarButtonItemStylePlain target:self action:@selector(markButtonTapped:)];
        self.markButton.enabled = NO;
        self.markButton.tag = NSIntegerMin;
        self.markButton.width = BUTTON_WIDTH;
        
        // title
        UIButton *titleButton = [[UIButton alloc] initWithFrame:frame];
        [titleButton setTitle:[object.fileName stringByDeletingPathExtension] forState:UIControlStateNormal];
        UIBarButtonItem *titleLabel = [[UIBarButtonItem alloc] initWithCustomView:titleButton];
        
        // add to toolbar
        [self setItems:@[closeButton, thumbsButton, flexibleSpaceButton, titleLabel, flexibleSpaceButton, self.markButton]];

    }

    return self;
}

- (void) setBookmarkState:(BOOL)state {

	if (state != self.markButton.tag) {
		if (!self.hidden)
			[self.markButton setTintColor:(state ? markColorY : markColorN)];
		self.markButton.tag = state; // Update bookmarked state tag
	}

	if (!self.markButton.enabled)
        self.markButton.enabled = YES;

}

- (void) updateBookmarkImage {
    
	if (self.markButton.tag != NSIntegerMin)
		[self.markButton setTintColor:(self.markButton.tag ? markColorY : markColorN)];

	if (!self.markButton.enabled)
        self.markButton.enabled = YES;
}

- (void)hideToolbar {
	if (!self.hidden) {
		[UIView animateWithDuration:0.25 delay:0.0
			options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
			animations:^(void) {
				self.alpha = 0.0f;
                }
			completion:^(BOOL finished) {
				self.hidden = YES;
			}
		];
	}
}

- (void)showToolbar {
	if (self.hidden) {
		[self updateBookmarkImage]; // First

		[UIView animateWithDuration:0.25 delay:0.0
			options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
			animations:^(void) {
				self.hidden = NO;
				self.alpha = 1.0f;
			}
			completion:NULL
		];
	}
}

#pragma mark UIButton action methods

- (void)doneButtonTapped:(UIButton *)button {
	[delegate tappedInToolbar:self doneButton:button];
}

- (void)thumbsButtonTapped:(UIButton *)button {
	[delegate tappedInToolbar:self thumbsButton:button];
}

- (void)printButtonTapped:(UIButton *)button {
	[delegate tappedInToolbar:self printButton:button];
}

- (void)emailButtonTapped:(UIButton *)button {
	[delegate tappedInToolbar:self emailButton:button];
}

- (void)markButtonTapped:(UIButton *)button {
	[delegate tappedInToolbar:self markButton:button];
}

@end
