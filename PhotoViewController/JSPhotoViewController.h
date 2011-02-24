//
//  JSPhotoViewController.h
//  PhotoViewController
//
//  Created by James on 23/02/2011.
//  Copyright 2011 JamSoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JSPhotoViewController : UIViewController <UIScrollViewDelegate> {
    
	UIScrollView *_scrollView;
	UIToolbar *_toolbar;
	UIBarButtonItem *_previousButton;
	UIBarButtonItem *_nextButton;
	
	NSArray *_photos;
	NSArray *_imageViews;
	NSUInteger _currentPhotoIndex;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *previousButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextButton;
@property (nonatomic, retain) NSArray *photos;

- (id)initWithPhotos:(NSArray *)photos;
- (id)initWithPhotos:(NSArray *)photos intialPhotoIndex:(NSUInteger)index;


- (IBAction)previousPhoto:(id)sender;
- (IBAction)nextPhoto:(id)sender;


@end
