//
//  JSPhotoThumbsViewController.m
//  PhotoViewController
//
//  Created by James Addyman on 21/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSPhotoThumbsViewController.h"
#import "JSPhotoTableViewCell.h"

NSInteger const imagesPerCellPortrait = 4;
NSInteger const imagesPerCellLandscape = 6;

@implementation JSPhotoThumbsViewController

@synthesize photos = _photos;

- (id)initWithPhotos:(NSArray *)photos
{
	if ((self = [super initWithStyle:UITableViewStylePlain]))
	{
		self.title = @"Photos";
		self.photos = photos;
		[self setWantsFullScreenLayout:YES];
		[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[self.tableView setRowHeight:79.0];
		[self.tableView setContentInset:UIEdgeInsetsMake(4.0, 0.0, 0.0, 0.0)];
		
		UILabel *footer = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 48)] autorelease];
		[footer setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
		[footer setFont:[UIFont systemFontOfSize:22]];
		[footer setTextColor:[UIColor colorWithRed:128.0/255.0
											 green:136.0/255.0
											  blue:149.0/255.0
											 alpha:1.0]];
		[footer setTextAlignment:UITextAlignmentCenter];
		[footer setText:[NSString stringWithFormat:@"%d Photos", [_photos count]]];
		[self.tableView setTableFooterView:footer];
	}
	
	return self;
}

- (void)dealloc
{
	self.photos = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = 0;
	
	if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
	{
		int remainder = [self.photos count] % imagesPerCellPortrait;
		if (remainder == 0)
		{
			rows = [self.photos count] / imagesPerCellPortrait;
		}
		else
		{
			rows = ([self.photos count] / imagesPerCellPortrait) + 1;
		}
	}
	else if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
	{
		int remainder = [self.photos count] % imagesPerCellLandscape;
		if (remainder == 0)
		{
			rows = [self.photos count] / imagesPerCellLandscape;
		}
		else
		{
			rows = ([self.photos count] / imagesPerCellLandscape) + 1;
		}		
	}
	
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
	JSPhotoTableViewCell *cell = (JSPhotoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[JSPhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	NSInteger numberOfPhotos = (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) ? imagesPerCellPortrait : imagesPerCellLandscape;
	
	NSRange subArrayRange = NSMakeRange([indexPath row] * numberOfPhotos, numberOfPhotos);
	if ((subArrayRange.location + subArrayRange.length) > [_photos count])
	{
		subArrayRange.length = [_photos count] - subArrayRange.location;
	}
	
	NSArray *photos = [_photos subarrayWithRange:subArrayRange];
	[cell setPhotos:photos];
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
