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
#import "JSLazyImageView.h"

CGFloat const padding = 4.0;

@interface JSPhotoTableViewCell ()

- (void)updateImageViews;
- (void)dimImageView:(JSLazyImageView *)imageView;
- (void)unDimImageView:(JSLazyImageView *)imageView;

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
			JSLazyImageView *imageView = [[[JSLazyImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 75)] autorelease];
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
	
	[self updateImageViews];
}

- (void)prepareForReuse
{
	for (JSLazyImageView *imageView in _imageViews)
	{
		[imageView setImage:nil];
	}
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGFloat xPos = padding;
	
	for (int i = 0; i < [_imageViews count]; i++)
	{
		JSLazyImageView *imageView = [_imageViews objectAtIndex:i];
		CGRect frame = [imageView frame];
		frame.origin.x = xPos;
		xPos += frame.size.width + padding;
		
		[imageView setFrame:frame];
	}
}

- (void)updateImageViews
{
	for (int i = 0; i < [_photos count]; i++)
	{
		JSLazyImageView *imageView = [_imageViews objectAtIndex:i];
		JSPhoto *photo = [_photos objectAtIndex:i];
		
		[imageView setImageURL:[photo photoThumbURL]];
		[imageView startLoad];
	}
}

- (void)dimImageView:(JSLazyImageView *)imageView
{
	[[imageView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	UIView *overlay = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, [imageView frame].size.width, [imageView frame].size.height)] autorelease];
	[overlay setBackgroundColor:[UIColor blackColor]];
	[overlay setAlpha:0.3];
	[overlay setOpaque:NO];
	[imageView addSubview:overlay];
}

- (void)unDimImageView:(JSLazyImageView *)imageView
{
	[[imageView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	
	for (JSLazyImageView *imageView in _imageViews)
	{
		if (CGRectContainsPoint([imageView frame], location) && ([imageView image] != nil))
		{
			_touchedImageIndex = [_imageViews indexOfObject:imageView];
			if (_touchedImageIndex < [self.photos count])
			{
				[self dimImageView:imageView];
				break;
			}
		}
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!_touchedImageIndex)
		return;
	
	JSLazyImageView *imageView = [_imageViews objectAtIndex:_touchedImageIndex];
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	
	if (CGRectContainsPoint([imageView frame], location))
	{
		[self dimImageView:imageView];
	}
	else
	{
		[self unDimImageView:imageView];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self unDimImageView:[_imageViews objectAtIndex:_touchedImageIndex]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (_touchedImageIndex < [self.photos count])
	{
		JSLazyImageView *imageView = [_imageViews objectAtIndex:_touchedImageIndex];
		UITouch *touch = [touches anyObject];
		CGPoint location = [touch locationInView:self];
		
		if (CGRectContainsPoint([imageView frame], location))
		{
			[self unDimImageView:imageView];
//			if ([self.delegate respondsToSelector:@selector(displayScreenshot:)])
//			{
//				[self.delegate displayScreenshot:[self.screenshots objectAtIndex:_touchedImageIndex]];
//			}
		}
		else
		{
			[self unDimImageView:imageView];
		}
	}
}

@end
