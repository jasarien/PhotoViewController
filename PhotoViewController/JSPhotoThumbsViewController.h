//
//  JSPhotoThumbsViewController.h
//  PhotoViewController
//
//  Created by James Addyman on 21/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

NSInteger const imagesPerCellPortrait;
NSInteger const imagesPerCellLandscape;

@interface JSPhotoThumbsViewController : UITableViewController {
 
	NSArray *_photos;
	
}

@property (nonatomic, copy) NSArray *photos;

- (id)initWithPhotos:(NSArray *)photos;

@end
