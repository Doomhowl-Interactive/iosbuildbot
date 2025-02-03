/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */
#import "ShellCommandRunner.h"
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

NSString* runShellCommand(NSString* exe, NSArray<NSString*>* args, BOOL silent) {
    ShellCommandRunner *runner = [[ShellCommandRunner alloc] init];
    return [runner runShellCommand:exe args:args silent:silent];
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

NSString* getWorkingDirectory(void)
{
    char cwd[1024];
    if (getcwd(cwd, sizeof(cwd)) != NULL) {
        return [NSString stringWithUTF8String:cwd];
    } else {
        NSString* msg = [NSString stringWithFormat:@"Failed to get working directory, Error: %s", strerror(errno)];
        @throw [NSException exceptionWithName:EXCEPTION reason:msg userInfo:nil];
    }
}

BOOL findProgramInPath(NSString* program, NSString** outExePath)
{
    NSString* exe = runShellCommand(@"/usr/bin/which", @[program], YES);
    exe = [exe stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    if (fileExists(exe)) {
        if (outExePath) {
            *outExePath = exe;
        }
        return YES;
    } else if (outExePath) {
        *outExePath = NULL;
    }
    return NO;
}
