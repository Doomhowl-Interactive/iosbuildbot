/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#pragma once
#import <Foundation/Foundation.h>
#include <stdexcept>

class BuildBotError : public std::runtime_error
{
public:
    using std::runtime_error::runtime_error;
};

NSString* getWorkingDirectory();

bool directoryExists(NSString* path);

void createDirectory(NSString* path);
