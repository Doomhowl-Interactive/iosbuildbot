/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Git : NSObject

-(nonnull instancetype) init: (nonnull NSString*) gitPath;

-(void) clone: (nonnull NSString*) repo
       branch: (nonnull NSString*) branch
       outDirParent: (nonnull NSString*) outDirParent;

@end

NS_ASSUME_NONNULL_END
