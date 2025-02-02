/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import "utils.h"
#import "Git.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"Running ios buildbot at: %@", getWorkingDirectory());
        
        NSString* cloneDir = @"cloned";
        createDirectory(cloneDir);
        
        NSString* gitExe = runShellCommand(@"/usr/bin/which", @[@"git"]);
        Git* git = [[Git alloc] init:gitExe];
        
        [git clone:@"nlohmann/json" branch:@"v3.11.3" outDirParent:cloneDir];
    }
    return 0;
}
