//
//  JSPhotoDownloadOperation.h
//  PhotoViewController
//
//  Created by James Addyman on 22/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSPhoto;

@interface JSPhotoDownloadOperation : NSOperation {
 
	JSPhoto *_photo;
	
	NSURLConnection *_connection;
	NSMutableData *_data;
	
	BOOL _isExecuting;
	BOOL _isFinished;
}

@property (nonatomic, retain) JSPhoto *photo;

@end
