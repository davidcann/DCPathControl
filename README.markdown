DCPathControl
==========

[Example](http://davidcann.com/DCPathControl/index-debug.html)

These classes display a series of buttons representing a file or URL path hierarchy.  It's similar to the Cocoa NSPathControl, but not exactly the same.  It works with [Cappuccino](http://github.com/280North/cappuccino).


## Usage

Copy these files into your app:

* DCPathControl.j
* DCPathComponentCell.j
* DCPathControlDivider.png

Import this:

	@import "DCPathControl.j"

Apply a DCFileDropController to any CPView:

	var pathControl = [[DCPathControl alloc] initWithFrame:CGRectMake(0, 0, 500, 36)];
	[pathControl setDelegate:self];
	[pathControl setURL:[CPURL URLWithString:"/Root/Path/To/Current/Location"]];
	[contentView addSubview:pathControl];

You can detect when a segment is clicked with the delegate method:

	- (void)didClickURL:(CPURL)theURL {
		CPLog("clicked url = "+ theURL);
	}


## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)