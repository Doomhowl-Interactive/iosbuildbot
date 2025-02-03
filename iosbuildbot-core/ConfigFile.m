/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import "ConfigFile.h"

static NSString *const EXCEPTION = @"ConfigFileException";

@implementation ConfigFile

- (nonnull instancetype)initFromFile:(nonnull NSString *)path {
    self = [super init];
    if (self) {
        self.content = [self readFile:path];
        self.repos = [self.content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    }
    return self;
}

- (nonnull NSString*) readFile: (nonnull NSString*) filePath
{
    NSError *error = nil;
    
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    
    if (error) {
        @throw [NSException exceptionWithName:EXCEPTION
                                       reason:[NSString stringWithFormat:@"Error reading file at %@: %@", filePath, error.localizedDescription]
                                     userInfo:nil];
    }
    
    return fileContents;
}

- (BOOL) isEmpty
{
    return [self.repos count] == 0;
}

@end
