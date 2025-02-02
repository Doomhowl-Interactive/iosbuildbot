/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#pragma once
#import <Foundation/Foundation.h>

NSString* getWorkingDirectory(void);

bool directoryExists(NSString* path);

void createDirectory(NSString* path);

void runShellCommand(NSString* exe, NSArray<NSString*>* args);
