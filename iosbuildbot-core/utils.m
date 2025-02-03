/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import "utils.h"

#include <unistd.h>

static NSString *const EXCEPTION = @"UtilsException";

BOOL fileExists(NSString* path)
{
    BOOL isDirectory;
    BOOL exists = [[NSFileManager defaultManager]
                   fileExistsAtPath:path
                        isDirectory:&isDirectory];
    return exists && !isDirectory;
}

BOOL directoryExists(NSString* path)
{
    BOOL isDirectory;
    BOOL exists = [[NSFileManager defaultManager]
                   fileExistsAtPath:path
                        isDirectory:&isDirectory];
    return exists && isDirectory;
}

NSString* getWorkingDirectory(void)
{
    return [[NSProcessInfo processInfo] environment][@"PWD"];
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
            @throw [NSException exceptionWithName:EXCEPTION reason:msg userInfo:nil];
        }
    }
}

NSString* runShellCommand(NSString* exe, NSArray<NSString*>* args) {
    @autoreleasepool {
        NSTask *task = [[NSTask alloc] init];
        task.launchPath = exe;
        task.arguments = args;
        
        NSPipe *pipe = [NSPipe pipe];
        task.standardOutput = pipe;
        
        NSFileHandle *file = [pipe fileHandleForReading];
        
        @try {
            [task launch];
        } @catch (NSException *exception) {
            NSString* msg = [NSString stringWithFormat:@"Failed to launch shell task: %@", exception.reason];
            @throw [NSException exceptionWithName:EXCEPTION reason:msg userInfo:nil];
        }
        
        NSData *data = [file readDataToEndOfFile];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
}

void changeWorkingDirectory(NSString *directoryPath)
{
    const char *path = [directoryPath UTF8String];
    
    if (chdir(path) == 0) {
        NSLog(@"Successfully changed working directory to: %@", directoryPath);
    } else {
        NSString* msg = [NSString stringWithFormat:@"Failed to change working directory to: %@, Error: %s", directoryPath, strerror(errno)];
        @throw [NSException exceptionWithName:EXCEPTION reason:msg userInfo:nil];
    }
}
