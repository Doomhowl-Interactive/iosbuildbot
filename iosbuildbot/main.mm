/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import "utils.h"

#import <iostream>
#import <string>
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"Running ios buildbot at: %@", getWorkingDirectory());
        createDirectory(@"cloned");
    }
    return 0;
}
