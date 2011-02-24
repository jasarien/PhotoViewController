//
//  JSCache.m
//  PhotoViewController
//
//  Created by James Addyman on 21/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSPhotoCache.h"
#import "NSString+Hashing.h"

NSString * const kJSPhotoCachePath = @"JSPhotoCache";

@implementation JSPhotoCache

+ (NSString *)cachePath
{
	NSString *cachePath = nil;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	if ([paths count])
	{
		cachePath = [paths objectAtIndex:0];
	}
	
	cachePath = [cachePath stringByAppendingPathComponent:kJSPhotoCachePath];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath])
	{
		NSError *error = nil;
		[[NSFileManager defaultManager] createDirectoryAtPath:cachePath
								  withIntermediateDirectories:YES
												   attributes:nil
														error:&error];
		if (error)
		{
			NSLog(@"Error creating cache directory at %@: %@", cachePath, [error localizedDescription]);
		}
	}
	
	return cachePath;
}

+ (UIImage *)imageForKey:(NSString *)key
{	
	NSString *cachePath = [self cachePath];	
	NSString *keyHash = [key MD5Hash];
	cachePath = [cachePath stringByAppendingPathComponent:keyHash];
	
	UIImage *image = [UIImage imageWithContentsOfFile:cachePath];
	
	return image;
}

+ (NSString *)imagePathForKey:(NSString *)key
{
	NSString *cachePath = [self cachePath];	
	NSString *keyHash = [key MD5Hash];
	cachePath = [cachePath stringByAppendingPathComponent:keyHash];
	
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:cachePath];
	
	return (fileExists) ? cachePath : nil;
}

+ (NSString *)writeImageToDisk:(UIImage *)image withKey:(NSString *)key
{
	NSString *cachePath = [self cachePath];	
	NSString *keyHash = [key MD5Hash];
	cachePath = [cachePath stringByAppendingPathComponent:keyHash];
	
	NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
	BOOL success = [imageData writeToFile:cachePath atomically:YES];
	
	return (success) ? cachePath : nil;
}

+ (void)emptyCache
{
	NSString *cachePath = [self cachePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath])
	{
		[[NSFileManager defaultManager] removeItemAtPath:cachePath error:nil];
	}
}

@end
