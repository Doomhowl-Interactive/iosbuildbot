/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import "Git.h"
#import "utils.h"

static NSString *const EXCEPTION = @"GitException";

@implementation Git

- (nonnull instancetype)init:(nonnull NSString *)gitPath
{
    self = [super init];
    if (self) {
        self.exe = gitPath;
    }
    return self;
}

- (void)        cloneRaw:(nonnull NSString *)url
                     tag:(nullable NSString *)tag
                 destDir:(nonnull NSString *)destDir
{
    NSMutableArray<NSString*>* args = [NSMutableArray<NSString*> arrayWithCapacity:10];
    [args addObjectsFromArray:@[@"clone", url]];
    if (tag != NULL) {
        [ args addObjectsFromArray:@[@"-b", tag] ];
    }
    [args addObjectsFromArray:@[destDir]];
    [args addObjectsFromArray:@[@"--depth", @"1"]];
    runShellCommand(self.exe, args, NO);
}

-(NSString*) formOutputPath: (NSString*)outDirParent repo: (struct Repo) repo
{
    return [NSString pathWithComponents:@[outDirParent, repo.authorAndName]];
}

-(void)         clone: (struct Repo) repo
         outDirParent: (NSString*) outDirParent
{
    [ self cloneRaw:repo.url
                tag:repo.tag
            destDir:[self formOutputPath:outDirParent repo:repo] ];
}

-(void)  cloneIfNotAlready: (struct Repo) repo
              outDirParent: (NSString*) outDirParent
{
    if (directoryExists([self formOutputPath:outDirParent repo:repo])) {
        NSLog(@"Already cloned repo %@", repo.authorAndName);
    } else {
        [self clone:repo outDirParent:outDirParent];
    }
}

-(struct Repo) parseRepoLine: (NSString*) line
{
    struct Repo r;
    @autoreleasepool {
        void (^throwParseError)(NSString*) = ^(NSString* msg) {
            @throw [NSException exceptionWithName:EXCEPTION
                                           reason:msg
                                         userInfo:nil];
        };
        
        BOOL (^isFullLink)(NSString*) = ^(NSString* url) {
            return (BOOL) ([line containsString:@"@"] || [line hasPrefix:@"http://"] || [line hasPrefix:@"https://"]);
        };
        
        // sanity checks
        let trimmed = [line componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        if ([trimmed count] > 1) {
            throwParseError(@"Input must be one line");
        }
        
        if ([[line componentsSeparatedByString:@":"] count] > 2) {
            throwParseError([NSString stringWithFormat:@"Unexpected amount of ':' in %@", line]);
        }
        if (!isFullLink(line)) {
            if ([[line componentsSeparatedByString:@"/"] count] != 2) {
                throwParseError([NSString stringWithFormat:@"Line '%@' must have <author>/<repo> format", line]);
            }
        }
        
        // parse tag
        NSArray<NSString*>* comps = [line componentsSeparatedByString:@" "];
        switch ([comps count]) {
            case 1: {
                r.tag = nil;
                break;
            }
            case 2: {
                r.tag = comps[1];
                break;
            }
            default: {
                throwParseError([NSString stringWithFormat:@"Unexpected amount of segments in line '%@'", line]);
            }
        }
        
        // parse authorAndName
        NSArray<NSString*>* colonParts = [ line componentsSeparatedByString:@":" ];
        NSArray<NSString*>* parts = [ [colonParts lastObject] componentsSeparatedByString:@"/" ];
        if ([colonParts count] == 0) {
            throwParseError([NSString stringWithFormat:@"Unexpected amount of ':' in %@", line]);
        }
        
        if ([parts count] < 2) {
            throwParseError([NSString stringWithFormat:@"Could not infer <author>/<repo> from %@", line]);
        }
        r.authorAndName = [NSString stringWithFormat:@"%@/%@", parts[[parts count]-2], [parts lastObject] ];
        if ([r.authorAndName hasSuffix:@".git"]) {
            r.authorAndName = [r.authorAndName substringToIndex:([r.authorAndName length] - [@".git" length])];
        }
        
        // parse url
        if (isFullLink(line)) {
            r.url = line;
        } else {
            // github is used by default
            r.url = [NSString stringWithFormat:@"https://github.com/%@.git", r.authorAndName];
        }
    }
    return r;
}

@end
