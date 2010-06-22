/*
 * DCPathComponentCell.j
 * dcpathcontrol
 *
 * Created by Cann on June 22, 2010.
 * Copyright 2010, Cann All rights reserved.
 */

@import <Foundation/CPObject.j>

@implementation DCPathComponentCell : CPButton {
	CPURL URL @accessors;
	id delegate @accessors;
}

- (void)initWithFrame:(CGRect)theFrame {
	self = [super initWithFrame:theFrame];

	[self setBordered:NO];
	[self setFont:[CPFont systemFontOfSize:12.0]];
	[self setHighlighted:NO];
	self._DOMElement.style.setProperty("-webkit-border-radius", "6px", null);

	return self;
}

- (void)setHighlighted:(BOOL)yesNo {
	[super setHighlighted:yesNo];
	if (yesNo) {
		[self setBackgroundColor:[CPColor colorWithWhite:0.0 alpha:0.3]];
		[self setTextColor:[CPColor whiteColor]];
		[self setTextShadowColor:[CPColor colorWithWhite:0.0 alpha:0.85]];
		[self setTextShadowOffset:CGSizeMake(0, -1)];
	} else {
		[self setBackgroundColor:[CPColor clearColor]];
		[self setTextColor:[CPColor blackColor]];
		[self setTextShadowColor:[CPColor colorWithWhite:1.0 alpha:0.85]];
		[self setTextShadowOffset:CGSizeMake(0, 1)];
	}
}

@end
