/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfigFile : NSObject

@property NSArray<NSString*>* lines;
@property NSString* content;

-(instancetype) initFromFile: (NSString*) path;

-(instancetype) initFromBuffer: (NSString*) buffer;

-(NSArray*) parseLines;

-(BOOL) isEmpty;

@end

NS_ASSUME_NONNULL_END
