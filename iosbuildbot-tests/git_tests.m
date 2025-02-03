/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 03-02-2025
 */

#import <XCTest/XCTest.h>
#import "Git.h"

@interface git_tests : XCTestCase
@end

@implementation git_tests

- (void)testParseHTTPLink {
    Git* git = [Git alloc];
    
    struct Repo r = [git parseRepoLine:@"https://github.com/nlohmann/json.git"];
    XCTAssertEqualObjects(r.url, @"https://github.com/nlohmann/json.git");
    XCTAssertEqualObjects(r.authorAndName, @"nlohmann/json");
    XCTAssertEqual(r.tag, nil);
}

- (void)testParseSSHLink {
    Git* git = [Git alloc];
    
    struct Repo r = [git parseRepoLine:@"git@github.com:nlohmann/json.git"];
    XCTAssertEqualObjects(r.url, @"git@github.com:nlohmann/json.git");
    XCTAssertEqualObjects(r.authorAndName, @"nlohmann/json");
    XCTAssertEqual(r.tag, nil);
}

- (void)testParseAuthorAndName {
    Git* git = [Git alloc];
    
    struct Repo r = [git parseRepoLine:@"nlohmann/json"];
    XCTAssertEqualObjects(r.url, @"https://github.com/nlohmann/json.git");
    XCTAssertEqualObjects(r.authorAndName, @"nlohmann/json");
    XCTAssertEqual(r.tag, nil);
}

- (void)testParseEmptyLineThrows {
    Git* git = [Git alloc];
    
    XCTAssertThrows([git parseRepoLine:@""]);
}

- (void)testParseInvalidThrows {
    Git* git = [Git alloc];
    
    XCTAssertThrows([git parseRepoLine:@"whatever::::test/test.git"]);
}

- (void)testParseWithNewlinesThrows {
    Git* git = [Git alloc];
    
    XCTAssertThrows([git parseRepoLine:@"https://github.com\n/nlohmann/json.git"]);
    XCTAssertThrows([git parseRepoLine:@"https://github.com\r/nlohmann/json.git"]);
    XCTAssertThrows([git parseRepoLine:@"nlohmann/json.git\n"]);
}

@end
