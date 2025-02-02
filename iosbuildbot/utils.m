/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import "utils.h"

NSString* getWorkingDirectory(void)
{
    return [[NSProcessInfo processInfo] environment][@"PWD"];
}

bool directoryExists(NSString* path)
{
    BOOL isDirectory;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path                                                                                                                isDirectory:&isDirectory];
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
            @throw [NSException exceptionWithName:@"BuildbotException" reason:msg userInfo:nil];
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
            @throw [NSException exceptionWithName:@"BuildbotException" reason:msg userInfo:nil];
        }
        
        NSData *data = [file readDataToEndOfFile];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
}
