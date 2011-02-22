//
//  JSPhoto.m
//  PhotoViewController
//
//  Created by James Addyman on 21/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSPhoto.h"
#import "JSPhotoCache.h"

@implementation JSPhoto

@synthesize  photoTitle = _photoTitle;
@synthesize photoDescription = _photoDescription;
@synthesize photoURL = _photoURL;
@synthesize photoThumbURL = _photoThumbURL;
@synthesize photoFilePath = _photoFilePath;
@synthesize photoThumbFilePath = _photoThumbFilePath;

- (id)initWithTitle:(NSString *)title description:(NSString *)description URL:(NSURL *)URL thumbURL:(NSURL *)thumbURL
{
	if ((self = [super init]))
	{
		self.photoTitle = title;
		self.photoDescription = description;
		self.photoURL = URL;
		self.photoThumbURL = thumbURL;
	}
	
	return self;
}

- (void)dealloc
{
	self.photoTitle = nil;
	self.photoDescription = nil;
	self.photoThumbURL = nil;
	self.photoURL = nil;
	self.photoFilePath = nil;
	[super dealloc];
}

- (void)setPhotoURL:(NSURL *)photoURL
{
	[_photoURL release];
	_photoURL = [photoURL retain];
	
	self.photoFilePath = [JSPhotoCache imagePathForKey:[_photoURL absoluteString]];
}

- (void)setPhotoThumbURL:(NSURL *)photoThumbURL
{
	[_photoThumbURL release];
	_photoThumbURL = [photoThumbURL retain];
	
	self.photoThumbFilePath = [JSPhotoCache imagePathForKey:[_photoThumbURL absoluteString]];
}

@end
