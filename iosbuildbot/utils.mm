/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import "utils.h"

NSString* getWorkingDirectory()
{
    return [[NSProcessInfo processInfo] environment][@"PWD"];
}

bool directoryExists(NSString* path)
{
    BOOL isDirectory;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path                                                             isDirectory:&isDirectory];
    return exists && isDirectory;
}

void createDirectory(NSString* path)
{
    BOOL success = true;
    if (!directoryExists(path))
    {
        NSError *error = nil;
        
        success = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                                 withIntermediateDirectories:YES
                                                                  attributes:nil
                                                                       error:&error];
        
        if (!success) {
            NSString *msg = [NSString stringWithFormat:@"Failed to create directory: %@, Error: %@", path, error.localizedDescription];
            throw BuildBotError([msg UTF8String]);
        }
    }
}
