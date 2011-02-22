//
//  JSPhotoTableViewCell.m
//  PhotoViewController
//
//  Created by James Addyman on 21/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSPhotoTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "JSPhoto.h"
#import "JSPhotoCache.h"

CGFloat const padding = 4.0;

@interface JSPhotoTableViewCell ()

- (void)updateImageViews;

@end

@implementation JSPhotoTableViewCell

@synthesize photos = _photos;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		_imageViews = [[NSMutableArray alloc] init];
		
		for (int i = 0; i < 6; i++)
		{
			UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 75)] autorelease];
			[imageView setContentMode:UIViewContentModeScaleAspectFill];
			[imageView setOpaque:YES];
			[imageView setClipsToBounds:YES];
			[[self contentView] addSubview:imageView];
			[_imageViews addObject:imageView];
		}
	}
	
	return self;
}

- (void)dealloc
{
	for (JSPhoto *photo in _photos)
	{
		[photo removeObserver:self forKeyPath:@"photoThumbFilePath"];
	}
	
	self.photos = nil;
	[_imageViews release], _imageViews = nil;
	
	[super dealloc];
}

- (void)setPhotos:(NSArray *)photos
{
	[_photos release];
	_photos = [photos retain];
	
	for (JSPhoto *photo in _photos)
	{
		[photo addObserver:self
				forKeyPath:@"photoThumbFilePath"
				   options:NSKeyValueObservingOptionOld
				   context:nil];
	}
	
	[self updateImageViews];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	JSPhoto *photo = (JSPhoto *)object;
	NSUInteger index = [_photos indexOfObject:photo];
	NSString *filePath = [photo photoThumbFilePath];
	
	UIImageView *imageView = [_imageViews objectAtIndex:index];
	[imageView setImage:[UIImage imageWithContentsOfFile:filePath]];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGFloat xPos = padding;
	
	for (int i = 0; i < [_imageViews count]; i++)
	{
		UIImageView *imageView = [_imageViews objectAtIndex:i];
		CGRect frame = [imageView frame];
		frame.origin.x = xPos;
		xPos += frame.size.width + padding;
		
		[imageView setFrame:frame];
	}
}

- (void)updateImageViews
{
	for (UIImageView *imageView in _imageViews)
	{
		[imageView setImage:nil];
		[[imageView layer] setBorderWidth:0.0];
		[[imageView layer] setBorderColor:NULL];
	}
	
	for (int i = 0; i < [_photos count]; i++)
	{
		JSPhoto *photo = [_photos objectAtIndex:i];
		
		UIImageView *imageView = [_imageViews objectAtIndex:i];
		[[imageView layer] setBorderWidth:1.0];
		[[imageView layer] setBorderColor:[[UIColor blackColor] CGColor]];
		
		if ([[photo photoThumbFilePath] length])
		{
			UIImageView *imageView = [_imageViews objectAtIndex:i];
			[imageView setImage:[UIImage imageWithContentsOfFile:[photo photoThumbFilePath]]];
		}
		else
		{
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
				NSLog(@"About to download image from: %@", [[photo photoThumbURL] absoluteString]);
				UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[photo photoThumbURL]]];
				NSLog(@"Image downloaded: %@", image);
				NSLog(@"Caching image");
				NSString *imagePath = [JSPhotoCache writeImageToDisk:image withKey:[[photo photoThumbURL] absoluteString]];
				NSLog(@"Image cached to: %@", imagePath); 
				[image release];
				dispatch_async(dispatch_get_main_queue(), ^{
					NSLog(@"About to set photo File Path");
					[photo setPhotoThumbFilePath:imagePath];
					NSLog(@"Set photo file path to: %@", imagePath);
				});
			});
		}
	}
}

@end
