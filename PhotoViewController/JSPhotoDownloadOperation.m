//
//  JSPhotoDownloadOperation.m
//  PhotoViewController
//
//  Created by James Addyman on 22/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSPhotoDownloadOperation.h"
#import "JSPhoto.h"
#import "JSPhotoCache.h"

@interface JSPhotoDownloadOperation ()

- (void)stopWorking;

@end

@implementation JSPhotoDownloadOperation

@synthesize photo = _photo;

- (void)start
{
	if ([self isCancelled])
	{
		[self stopWorking];
		return;
	}
	
	[self willChangeValueForKey:@"isExecuting"];
	_isExecuting = YES;
	[self didChangeValueForKey:@"isExecuting"];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[_photo photoURL]];
	_connection = [NSURLConnection connectionWithRequest:request delegate:self];
	_data = [[NSMutableData alloc] init];
	
	if ([self isCancelled])
	{
		[self stopWorking];
		return;
	}
}

- (BOOL)isConcurrent
{
	return YES;
}

- (BOOL)isExecuting
{
	return _isExecuting;
}

- (BOOL)isFinished
{
	return _isFinished;
}

#pragma mark -
#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	if ([self isCancelled])
	{
		[self stopWorking];
		return;
	}
	
	[_data appendData:data];
	
	if ([self isCancelled])
	{
		[self stopWorking];
		return;
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if ([self isCancelled])
	{
		[self stopWorking];
		return;
	}
	
	UIImage *image = [[UIImage alloc] initWithData:_data];
	[_data release], _data = nil;
		
	NSString *imagePath = [JSPhotoCache writeImageToDisk:image withKey:[[_photo photoURL] absoluteString]];
	[_photo performSelectorOnMainThread:@selector(setPhotoFilePath:)
							 withObject:imagePath
						  waitUntilDone:NO];
	
	[self willChangeValueForKey:@"isExecuting"];
	_isExecuting = NO;
	[self didChangeValueForKey:@"isExecuting"];
	[self willChangeValueForKey:@"isFinished"];
	_isFinished = YES;
	[self willChangeValueForKey:@"isFinished"];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[_data release], _data = nil;
	
	[self willChangeValueForKey:@"isExecuting"];
	_isExecuting = NO;
	[self didChangeValueForKey:@"isExecuting"];
	[self willChangeValueForKey:@"isFinished"];
	_isFinished = YES;
	[self willChangeValueForKey:@"isFinished"];
}

- (void)stopWorking
{
	
}

@end
