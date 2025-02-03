/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#import <Foundation/Foundation.h>
#import "BuildBot.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        BuildBot* bot = [BuildBot alloc];
        [ bot run ];
    }
    return 0;
}
