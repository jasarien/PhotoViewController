//
//  JSLazyImageScrollView.h
//  PhotoViewController
//
//  Created by James Addyman on 26/02/2011.
//  Copyright 2011 JamSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSLazyImageView;

@interface JSLazyImageScrollView : UIScrollView <UIScrollViewDelegate> {

    JSLazyImageView *_imageView;
    
}

@property (nonatomic, retain) JSLazyImageView *imageView;

- (id)initWithFrame:(CGRect)frame imageView:(JSLazyImageView *)imageView;

@end
