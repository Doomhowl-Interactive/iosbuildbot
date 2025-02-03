/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 03-02-2025
 */

#import <XCTest/XCTest.h>
#import "ConfigFile.h"

@interface config_file_tests : XCTestCase
@end

@implementation config_file_tests

- (void) testParseWithNoEmptyLines
{
    NSString* buffer = @"nlohmann/json" @"\n"
                       @"test/test" @"\n"
                       @"raysan5/raylib";
    
    ConfigFile* config = [[ConfigFile alloc] initFromBuffer:buffer];
    XCTAssertEqual([config.lines count], 3);
}

- (void) testParseWithEmptyLines
{
    NSString* buffer = @"nlohmann/json" @"\n"
                       @"test/test" @"\n"
                       @"" @"\n"
                       @"   " @"\n"
                       @"raysan5/raylib" @"\n";
    
    ConfigFile* config = [[ConfigFile alloc] initFromBuffer:buffer];
    XCTAssertEqual([config.lines count], 3);
}

@end
