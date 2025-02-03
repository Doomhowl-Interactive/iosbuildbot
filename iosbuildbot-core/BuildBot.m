/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 03-02-2025
 */

#import "BuildBot.h"
#import "utils.h"
#import "Git.h"
#import "ConfigFile.h"

static NSString *const EXCEPTION = @"BuildbotException";

@implementation BuildBot

-(void) run
{
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
    
    NSString* gitExe;
    if (!findProgramInPath(@"git", &gitExe)) {
        @throw [NSException exceptionWithName:EXCEPTION
                                       reason:@"Git could not be found."
                                     userInfo:nil];
    }
    
    NSString* cmakeExe;
    if (!findProgramInPath(@"cmake", &cmakeExe)) {
        @throw [NSException exceptionWithName:EXCEPTION
                                       reason:@"CMake could not be found."
                                     userInfo:nil];
    }
    
    Git* git = [[Git alloc] init:gitExe];
    
    for (NSString *line in config.lines) {
        struct Repo repo = [git parseRepoLine:line];
        if (directoryExists(repo.authorAndName)) {
            NSLog(@"Repo %@ already cloned.", repo.authorAndName);
        } else {
            NSLog(@"Cloning repo %@ with tag %@", repo.authorAndName, repo.tag);
        }
    }
}

@end
