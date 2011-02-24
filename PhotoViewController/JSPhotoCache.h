//
//  JSCache.h
//  PhotoViewController
//
//  Created by James Addyman on 21/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kJSPhotoCachePath;

@interface JSPhotoCache : NSObject {
    
}

+ (NSString *)cachePath;
+ (UIImage *)imageForKey:(NSString *)key;
+ (NSString *)imagePathForKey:(NSString *)key;
+ (NSString *)writeImageToDisk:(UIImage *)image withKey:(NSString *)key;
+ (void)emptyCache;

@end
