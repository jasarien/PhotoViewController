//
//  JSPhotoViewController.m
//  PhotoViewController
//
//  Created by James on 23/02/2011.
//  Copyright 2011 JamSoft. All rights reserved.
//

#import "JSPhotoViewController.h"
#import "JSPhoto.h"
#import "JSPhotoCache.h"
#import "JSLazyImageView.h"

@interface JSPhotoViewController ()

- (void)layoutImageViews;
- (void)displayPhotoAtCurrentIndex;

@end

@implementation JSPhotoViewController

@synthesize scrollView = _scrollView;
@synthesize toolbar = _toolbar;
@synthesize previousButton = _previousButton;
@synthesize nextButton = _nextButton;
@synthesize photos = _photos;

- (id)initWithPhotos:(NSArray *)photos
{
	return [self initWithPhotos:photos intialPhotoIndex:0];
}

- (id)initWithPhotos:(NSArray *)photos intialPhotoIndex:(NSUInteger)index
{
	if ((self = [super initWithNibName:@"JSPhotoViewController" bundle:nil]))
	{
		self.wantsFullScreenLayout = YES;
		
		self.photos = photos;
		_currentPhotoIndex = index;
	}
	
	return self;
}

- (void)dealloc
{
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
	
	CGFloat xPos = 0.0;
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width * [self.photos count], height)];
	[contentView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	[self.scrollView addSubview:contentView];
	[contentView release];
	[self.scrollView setContentSize:[contentView frame].size];
	[self.scrollView setPagingEnabled:YES];
	
	NSMutableArray *imageViews = [NSMutableArray array];
	
	for (JSPhoto *photo in self.photos)
	{
		JSLazyImageView *imageView = [[JSLazyImageView alloc] initWithFrame:CGRectMake(xPos, 0, width, height)
																   imageURL:[photo photoURL]];
		[imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
		[imageView setClipsToBounds:YES];
		[imageView setOpaque:YES];
		[imageView setShowBorder:NO];
		[imageView setShowSpinner:YES];
		[imageView setContentMode:UIViewContentModeScaleAspectFit];
		xPos += width;
		[contentView addSubview:imageView];
		[imageViews addObject:imageView];
		[imageView release];
	}
	
	_imageViews = [[NSArray alloc] initWithArray:imageViews];
	
	[self.scrollView scrollRectToVisible:CGRectMake(width * _currentPhotoIndex, 0, width, height)
								animated:NO];
	[self displayPhotoAtCurrentIndex];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	[_imageViews release], _imageViews = nil;
	self.scrollView = nil;
	self.toolbar = nil;
	self.previousButton = nil;
	self.nextButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self layoutImageViews];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	_currentPhotoIndex = [self.scrollView contentOffset].x / self.view.frame.size.width;
	[self displayPhotoAtCurrentIndex];
}

- (void)layoutImageViews
{
	CGFloat xPos = 0.0;
	for (JSLazyImageView *imageView in _imageViews)
	{
		CGRect frame = [imageView frame];
		frame.origin.x = xPos;
		[imageView setFrame:frame];
		
		xPos += self.view.frame.size.width;
	}
	
	[self.scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width * _currentPhotoIndex, 0, self.view.frame.size.width, self.view.frame.size.height)
								animated:NO];
	[self displayPhotoAtCurrentIndex];
}

- (void)displayPhotoAtCurrentIndex
{
	NSInteger previousIndex, nextIndex;
	previousIndex = _currentPhotoIndex - 1;
	nextIndex = _currentPhotoIndex + 1;
	
	JSLazyImageView *imageView = [_imageViews objectAtIndex:_currentPhotoIndex];
	[imageView startLoad];
	
	if (previousIndex >= 0)
	{
		JSLazyImageView *previousImageView = [_imageViews objectAtIndex:_currentPhotoIndex - 1];
		[previousImageView startLoad];
	}
	
	if (nextIndex < [self.photos count])
	{
		JSLazyImageView *nextImageView = [_imageViews objectAtIndex:_currentPhotoIndex + 1];
		[nextImageView startLoad];		
	}
	
	for (int i = 0; i < [self.photos count]; i++)
	{
		if ((i == _currentPhotoIndex) || (i == _currentPhotoIndex - 1) || (i == _currentPhotoIndex + 1))
		{
			continue;
		}
		
		JSLazyImageView *imageView = [_imageViews objectAtIndex:i];
		[imageView cancelLoad];
	}
}

- (IBAction)previousPhoto:(id)sender
{
	
}

- (IBAction)nextPhoto:(id)sender
{
	
}

@end
