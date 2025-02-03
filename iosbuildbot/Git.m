/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import "Git.h"

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
                     tag:(nonnull NSString *)tag
            outDirParent:(nonnull NSString *)outDirParent
{
    @throw [NSException exceptionWithName:@"BuildbotException" reason:@"Not implemented" userInfo:nil];
}

-(void)         clone: (struct Repo) repo
         outDirParent: (NSString*) outDirParent
{
    [ self cloneRaw:repo.url
                tag:repo.tag
       outDirParent:outDirParent ];
}

-(struct Repo) parseRepoName: (NSString*) line
{
    struct Repo r;
    if ([line containsString:@"@"] || [line hasPrefix:@"http://"] || [line hasPrefix:@"https://"])
    {
        r.url = r.url;
    }
    return r;
}

@end
