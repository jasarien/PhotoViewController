//
//  JSPhoto.h
//  PhotoViewController
//
//  Created by James Addyman on 21/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JSPhoto : NSObject {
    
	NSString *_photoTitle;
	NSString *_photoDescription;
	NSURL *_photoURL;
	NSURL *_photoThumbURL;
	NSString *_photoFilePath;
	NSString *_photoThumbFilePath;
	
}

@property (nonatomic, copy) NSString *photoTitle;
@property (nonatomic, copy) NSString *photoDescription;
@property (nonatomic, retain) NSURL *photoURL;
@property (nonatomic, retain) NSURL *photoThumbURL;
@property (nonatomic, copy) NSString *photoFilePath;
@property (nonatomic, copy) NSString *photoThumbFilePath;

- (id)initWithTitle:(NSString *)title description:(NSString *)description URL:(NSURL *)url thumbURL:(NSURL *)thumbURL;

@end
