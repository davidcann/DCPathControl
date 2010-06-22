/*
 * DCPathControl.j
 * dcpathcontrol
 *
 * Created by Cann on June 22, 2010.
 * Copyright 2010, Cann All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "DCPathComponentCell.j"

@implementation DCPathControl : CPControl {
	// public
	CPURL URL @accessors;
	id delegate @accessors;
	CPArray pathComponentCells @accessors;
	DCPathComponentCell clickedPathComponentCell; // read-only
	CPImage dividerImage @accessors;
	int dividerPadding;

	// private
	CPArray dividers;
}

- (void)initWithFrame:(CGRect)theFrame {
	self = [super initWithFrame:theFrame];
	dividerImage = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:@"DCPathControlDivider.png"] size:CPSizeMake(5, 7)];
	dividerPadding = 12.0;
	pathComponentCells = [[CPArray alloc] init];
	dividers = [[CPArray alloc] init];
	return self;
}

// ********************* Managing Path Components *********************

- (DCPathComponentCell)clickedPathComponentCell {
	return clickedPathComponentCell;
}

- (void)setURL:(CPURL)theURL {
	URL = theURL;

	[pathComponentCells makeObjectsPerformSelector:@selector(removeFromSuperview)];
	[pathComponentCells removeAllObjects];
	[dividers makeObjectsPerformSelector:@selector(removeFromSuperview)];
	[dividers removeAllObjects];

	var components = [[URL path] componentsSeparatedByString:"/"];
	var componentCells = [[CPArray alloc] init];

	var lastURL = [CPURL URLWithString:""];
	for (var i = 0; i < [components count]; i++) {
		var component = [components objectAtIndex:i]
		if ([component stringByTrimmingWhitespace] != "") {
			lastURL = [CPURL URLWithString:[lastURL absoluteString] +"/"+ component];
			var componentCell = [[DCPathComponentCell alloc] initWithFrame:CGRectMakeZero()];

			[componentCell setTitle:component];
			[componentCell setTarget:self];
			[componentCell setAction:@selector(didClickPathComponentCell:)];

			[componentCell sizeToFit];
			[componentCell setDelegate:self];
			[componentCell setURL:lastURL];
			[componentCells addObject:componentCell];
		}
	}

	[self setPathComponentCells:componentCells];
}

- (void)setPathComponentCells:(CPArray)theCells {
	pathComponentCells = theCells;

	var x = 0;
	x += dividerPadding / 2;
	for (var i = 0; i < [theCells count]; i++) {
		if (i > 0) {
			x += dividerPadding / 2;
			var divider = [[CPImageView alloc] initWithFrame:CGRectMake(
				x,
				([self frame].size.height / 2) - ([dividerImage size].height / 2),
				[dividerImage size].width,
				[dividerImage size].height)];
			[divider setImage:dividerImage];
			[dividers addObject:divider];
			[self addSubview:divider];
			x += [dividerImage size].width;
			x += dividerPadding / 2;
		}

		var cell = [theCells objectAtIndex:i];
		[cell setFrame:CGRectMake(x, ([self frame].size.height / 2) - ([cell frame].size.height / 2), [cell frame].size.width + dividerPadding, [cell frame].size.height)];
		[self addSubview:cell];
		x += [cell frame].size.width;
	}
}

- (void)didClickPathComponentCell:(DCPathComponentCell)theCell {
	if ([delegate respondsToSelector:@selector(didClickURL:)]) {
		[delegate performSelector:@selector(didClickURL:) withObject:[theCell URL]];
	}
}

@end
