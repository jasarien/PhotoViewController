//
//  PhotoViewControllerViewController.m
//  PhotoViewController
//
//  Created by James Addyman on 21/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewControllerViewController.h"
#import "JSPhoto.h"
#import "JSPhotoThumbsViewController.h"

@implementation PhotoViewControllerViewController

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
	
	JSPhoto *photo1 = [[[JSPhoto alloc] initWithTitle:@"Gundam"
										 description:@"A Gundam Model"
												 URL:nil
											thumbURL:[NSURL URLWithString:@"http://farm3.static.flickr.com/2668/3876871180_817aaa1f23_m.jpg"]] autorelease];
	JSPhoto *photo2 = [[[JSPhoto alloc] initWithTitle:@"Sheep"
										  description:@"A Sheep"
												  URL:nil
											 thumbURL:[NSURL URLWithString:@"http://farm1.static.flickr.com/129/413037689_d46d48be63_o.jpg"]] autorelease];
	JSPhoto *photo3 = [[[JSPhoto alloc] initWithTitle:@"Cat"
										  description:@"A cat with big eyes"
												  URL:nil
											 thumbURL:[NSURL URLWithString:@"http://farm5.static.flickr.com/4066/4535174486_5759dd82d4_m.jpg"]] autorelease];
	JSPhoto *photo4 = [[[JSPhoto alloc] initWithTitle:@"Dog"
										  description:@"A Snowwy dog"
												  URL:nil
											 thumbURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3052/3086132328_e2041be795_m.jpg"]] autorelease];
	JSPhoto *photo5 = [[[JSPhoto alloc] initWithTitle:@"Apple"
										  description:@"An apple"
												  URL:nil
											 thumbURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3030/2825802176_a3f7b1525f_m.jpg"]] autorelease];
	JSPhoto *photo6 = [[[JSPhoto alloc] initWithTitle:@"Indiana Jones"
										  description:@"Lego Indiana Jones"
												  URL:nil
											 thumbURL:[NSURL URLWithString:@"http://farm2.static.flickr.com/1007/573291733_0ff7cd2cd3_o.gif"]] autorelease];
	JSPhoto *photo7 = [[[JSPhoto alloc] initWithTitle:@"Lightsabre"
										  description:@"A lightsabre"
												  URL:nil
											 thumbURL:[NSURL URLWithString:@"http://farm1.static.flickr.com/27/53037800_4e297fbb94_m.jpg"]] autorelease];
	JSPhoto *photo8 = [[[JSPhoto alloc] initWithTitle:@"Sword"
										  description:@"A Kit Rae Sword"
												  URL:nil
											 thumbURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3203/2832586449_f2d85070aa_m.jpg"]] autorelease];
	JSPhoto *photo9 = [[[JSPhoto alloc] initWithTitle:@"Strike Gundam"
										  description:@"Strike Gundam Model"
												  URL:nil
											 thumbURL:[NSURL URLWithString:@"http://farm1.static.flickr.com/148/356006952_c66bd760c1_m.jpg"]] autorelease];
	NSArray *photos = [NSArray arrayWithObjects:photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8, photo9, nil];
	
	JSPhotoThumbsViewController *thumbsVC = [[[JSPhotoThumbsViewController alloc] initWithPhotos:photos] autorelease];
	UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:thumbsVC] autorelease];
	[[navController navigationBar] setBarStyle:UIBarStyleBlackTranslucent];
	[self presentModalViewController:navController animated:YES];
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
