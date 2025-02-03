//
//  iosbuildbot_tests.m
//  iosbuildbot-tests
//
//  Created by Bram on 03/02/2025.
//

#import <XCTest/XCTest.h>
#import "Git.h"

@interface git_tests : XCTestCase
@end

@implementation git_tests

- (void)testParseHTTPLink {
    Git* git = [Git alloc];
    
    struct Repo r = [git parseRepoLine:@"https://github.com/nlohmann/json.git"];
    XCTAssertEqual(r.url, @"https://github.com/nlohmann/json.git");
    XCTAssertEqual(r.authorAndName, @"nlohmann/json");
    XCTAssertEqual(r.tag, nil);
}

- (void)testParseSSHLink {
    Git* git = [Git alloc];
    
    struct Repo r = [git parseRepoLine:@"git@github.com:nlohmann/json.git"];
    XCTAssertEqual(r.url, @"git@github.com:nlohmann/json.git");
    XCTAssertEqual(r.authorAndName, @"nlohmann/json");
    XCTAssertEqual(r.tag, nil);
}

- (void)testRepoAuthorAndName {
    Git* git = [Git alloc];
    
    struct Repo r = [git parseRepoLine:@"nlohmann/json"];
    XCTAssertEqual(r.url, @"https://github.com/nlohmann/json.git");
    XCTAssertEqual(r.authorAndName, @"nlohmann/json");
    XCTAssertEqual(r.tag, nil);
}

@end
