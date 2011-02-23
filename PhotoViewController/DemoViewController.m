//
//  PhotoViewControllerViewController.m
//  PhotoViewController
//
//  Created by James Addyman on 21/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DemoViewController.h"
#import "JSPhoto.h"
#import "JSPhotoThumbsViewController.h"
#import "JSON.h"

@implementation DemoViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setTitle:@"Show Thumbs" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(showThumbs:) forControlEvents:UIControlEventTouchUpInside];
	[button sizeToFit];
	[button setCenter:self.view.center];
	
	[self.view addSubview:button];
}


- (void)showThumbs:(id)sender
{	
	NSString *jsonString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"flickr" ofType:@"json"]
													 encoding:NSUTF8StringEncoding
														error:nil];
	SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
	NSDictionary *flickrResults = [jsonParser objectWithString:jsonString];
	[jsonParser release];
	
	NSArray *flickrPhotos = [[flickrResults objectForKey:@"photos"] objectForKey:@"photo"];
	NSMutableArray *photos = [NSMutableArray array];

	for (NSDictionary *photo in flickrPhotos)
	{
		NSString *photoid = [photo objectForKey:@"id"];
		NSString *title = [photo objectForKey:@"title"];
		NSString *secret = [photo objectForKey:@"secret"];
		NSString *server = [photo objectForKey:@"server"];
		NSString *farm = [photo objectForKey:@"farm"];
		
		NSURL *thumbURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", farm, server, photoid, secret]];
		NSURL *fullURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@.jpg", farm, server, photoid, secret]];
		
		JSPhoto *photo = [[JSPhoto alloc] initWithTitle:title
											description:nil
													URL:fullURL
											   thumbURL:thumbURL];
		[photos addObject:photo];
		[photo release];
	}
	
	JSPhotoThumbsViewController *thumbsVC = [[[JSPhotoThumbsViewController alloc] initWithPhotos:photos] autorelease];
	UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:thumbsVC] autorelease];
	[[navController navigationBar] setBarStyle:UIBarStyleBlackTranslucent];
	[self presentModalViewController:navController animated:YES];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
