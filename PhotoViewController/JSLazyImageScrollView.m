//
//  JSLazyImageScrollView.m
//  PhotoViewController
//
//  Created by James Addyman on 26/02/2011.
//  Copyright 2011 JamSoft. All rights reserved.
//

#import "JSLazyImageScrollView.h"
#import "JSLazyImageView.h"

@implementation JSLazyImageScrollView

@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame imageView:(JSLazyImageView *)imageView
{
	if ((self = [super initWithFrame:frame]))
	{
		self.imageView = imageView;
		
		[self setDelegate:self];
		[self setMinimumZoomScale:1.0];
		[self setMaximumZoomScale:2.0];
		[self setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
		[self setContentSize:[self.imageView frame].size];
		
		[self addSubview:self.imageView];
	}
	
	return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self.imageView;
}

@end
