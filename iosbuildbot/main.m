/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import "utils.h"
#import "Git.h"
#import "ConfigFile.h"

#import <Foundation/Foundation.h>

static NSString *const EXCEPTION = @"BuildbotException";

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        // TODO: unhardcode
        changeWorkingDirectory(@"/Users/bram/dev/iosbuildbot/work");
        
        NSLog(@"Running ios buildbot at: %@", getWorkingDirectory());
            
        ConfigFile* config = [[ConfigFile alloc] initFromFile:@"config.ini"];
        if (config.isEmpty) {
            @throw [NSException exceptionWithName:EXCEPTION
                                           reason:@"Config file does not list any repos"
                                         userInfo:nil];
        }
        
        NSString* cloneDir = @"cloned";
        createDirectory(cloneDir);
        
        NSString* gitExe = runShellCommand(@"/usr/bin/which", @[@"git"]);
        Git* git = [[Git alloc] init:gitExe];
        
        for (NSString *line in config.repos) {
            struct Repo repo = parseRepoName(line);
            if (directoryExists(repo.name)) {
                NSLog(@"Repo %@ already cloned.", repo.name);
            } else {
                NSLog(@"Cloning repo %@ with tag %@", repo.name, repo.tag);
                // TODO: parse branch
                [git clone:repo branch:@"v3.11.3" outDirParent:cloneDir];
            }
        }
    }
    return 0;
}
