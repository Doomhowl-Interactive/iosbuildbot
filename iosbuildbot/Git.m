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

- (void)clone:(nonnull NSString *)repo branch:(nonnull NSString *)branch outDirParent:(nonnull NSString *)outDirParent
{
    @throw [NSException exceptionWithName:@"BuildbotException" reason:@"Not implemented" userInfo:nil];
}

@end
