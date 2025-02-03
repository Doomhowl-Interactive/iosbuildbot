/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct Repo
{
    NSString* authorAndName;
    NSString* url;
    NSString* _Nullable tag;
};

@interface Git : NSObject

@property NSString* exe;

-(instancetype) init: (NSString*) gitPath;

-(void)            clone: (struct Repo) repo
            outDirParent: (NSString*) outDirParent;

-(void)         cloneRaw: (NSString*) url
                     tag: (nullable NSString*) tag
            outDirParent: (NSString*) outDirParent;

-(struct Repo) parseRepoLine: (NSString*) line;

@end

NS_ASSUME_NONNULL_END
