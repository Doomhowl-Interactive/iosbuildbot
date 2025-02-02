/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Git : NSObject

@property NSString* exe;

-(instancetype) init: (NSString*) gitPath;

-(void) clone: (NSString*) repo
       branch: (NSString*) branch
       outDirParent: (NSString*) outDirParent;

@end

NS_ASSUME_NONNULL_END
