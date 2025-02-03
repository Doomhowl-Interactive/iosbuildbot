/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 03-02-2025
 */

#import <Foundation/Foundation.h>

@interface ShellCommandRunner : NSObject

/**
 * Runs a shell command with the specified executable and arguments.
 *
 * @param exe The path to the executable.
 * @param args An array of arguments to pass to the executable.
 * @param silent If YES, the output will not be printed live but captured for later use.
 * @return The captured output if silent is NO; otherwise, nil.
 */
- (NSString *)runShellCommand:(NSString *)exe
                          args:(NSArray<NSString *> *)args
                        silent:(BOOL)silent;

@end
