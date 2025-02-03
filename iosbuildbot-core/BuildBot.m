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
    changeWorkingDirectory(@"/Users/bram/dev/iosbuildbot");
    
    NSLog(@"Running ios buildbot at: %@", getWorkingDirectory());
        
    ConfigFile* config = [[ConfigFile alloc] initFromFile:@"config.ini"];
    if (config.isEmpty) {
        @throw [NSException exceptionWithName:EXCEPTION
                                       reason:@"Config file does not list any repos"
                                     userInfo:nil];
    }
    
    NSString* workDir = @"work";
    createDirectory(workDir);
    
    NSString* cloneDir = [NSString pathWithComponents:@[workDir, @"cloned"]];
    createDirectory(cloneDir);
    
    NSString* buildDir = [NSString pathWithComponents:@[workDir, @"build"]];
    createDirectory(cloneDir);
    
    // Check if tooling is present
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
        [git cloneIfNotAlready:repo outDirParent:cloneDir];
        
        // configure cmake
        let sourceDir = [git formOutputPath:cloneDir repo:repo];
        let fullBuildDir = [git formOutputPath:buildDir repo:repo];
        createDirectory(fullBuildDir);
        
        runShellCommand(cmakeExe, @[@"-S", sourceDir, @"-B", fullBuildDir, @"-G Xcode"], NO);
    }
}

@end
