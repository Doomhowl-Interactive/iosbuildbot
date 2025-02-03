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
        self.lines = [self parseLines];
    }
    return self;
}

- (nonnull instancetype)initFromBuffer:(nonnull NSString *)buffer
{
    self = [self init];
    if (self) {
        self.content = buffer;
        self.lines = [self parseLines];
    }
    return self;
}

-(NSArray*) parseLines
{
    return [[self.content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
        return [[((NSString*)object) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0;
    }]];
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
    return [self.lines count] == 0;
}

@end
