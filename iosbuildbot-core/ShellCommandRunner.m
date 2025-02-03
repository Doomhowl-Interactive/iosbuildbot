/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 03-02-2025
 */

#import "ShellCommandRunner.h"

@interface ShellCommandRunner ()
@property (nonatomic, strong) NSTask *task;
@property (nonatomic, strong) NSPipe *pipe;
@property (nonatomic, assign) BOOL silent;
@property (nonatomic, strong) NSMutableString *outputString; // To capture output when silent
@end

@implementation ShellCommandRunner

- (NSString *)runShellCommand:(NSString *)exe args:(NSArray<NSString *> *)args silent:(BOOL)silent {
    self.silent = silent;
    self.outputString = [NSMutableString string]; // Initialize output string

    self.task = [[NSTask alloc] init];
    self.task.launchPath = exe;
    self.task.arguments = args;

    self.pipe = [NSPipe pipe];
    self.task.standardOutput = self.pipe;
    self.task.standardError = self.pipe;

    NSFileHandle *file = [self.pipe fileHandleForReading];

    // Set up a notification to read output as it becomes available
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleOutput:)
                                                 name:NSFileHandleReadCompletionNotification
                                               object:file];

    [file readInBackgroundAndNotify];

    @try {
        [self.task launch];
        [self.task waitUntilExit];
    } @catch (NSException *exception) {
        NSString *msg = [NSString stringWithFormat:@"Failed to launch task: %@",
                         exception.reason];
        @throw [NSException exceptionWithName:@"TaskException"
                                       reason:msg
                                     userInfo:nil];
    }

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    return [self.outputString copy];
}

- (void)handleOutput:(NSNotification *)notification {
    NSFileHandle *file = notification.object;
    NSData *data = notification.userInfo[NSFileHandleNotificationDataItem];

    if (data.length > 0) {
        NSString *output = [[NSString alloc] initWithData:data
                                                  encoding:NSUTF8StringEncoding];
        if (!self.silent) {
            NSLog(@"%@", output); // Print output live
        }
        [self.outputString appendString:output]; // Capture output
        [file readInBackgroundAndNotify]; // Continue reading
    }
}

@end
