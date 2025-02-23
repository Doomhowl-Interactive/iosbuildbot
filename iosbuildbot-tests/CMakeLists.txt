cmake_minimum_required(VERSION 3.15)
project(iosbuildbot-tests LANGUAGES OBJC)

enable_testing()
find_library(XCTEST_FRAMEWORK XCTest REQUIRED)

xctest_add_bundle(${PROJECT_NAME} iosbuildbot-core
    config_file_tests.m
    git_tests.m
)

target_link_libraries(${PROJECT_NAME} PUBLIC
    ${XCTEST_FRAMEWORK}
    iosbuildbot-core
)

add_test(NAME IOSBuildbotTests COMMAND ${PROJECT_NAME})