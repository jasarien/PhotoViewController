//
//  JSPhotoTableViewCell.h
//  PhotoViewController
//
//  Created by James Addyman on 21/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

CGFloat const padding;

@interface JSPhotoTableViewCell : UITableViewCell {
 
	NSArray *_photos;
	NSMutableArray *_imageViews;
	
}

@property (nonatomic, retain) NSArray *photos;

@end
