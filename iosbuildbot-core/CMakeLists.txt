cmake_minimum_required(VERSION 3.15)
project(iosbuildbot-core LANGUAGES OBJC)
enable_language(OBJC)

add_library(${PROJECT_NAME} STATIC
    BuildBot.h
    BuildBot.m
    ConfigFile.h
    ConfigFile.m
    Git.h
    Git.m
    ShellCommandRunner.h
    ShellCommandRunner.m
    utils.h
    utils.m
)

target_include_directories(${PROJECT_NAME} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(${PROJECT_NAME} PUBLIC
    "-framework Foundation"
)