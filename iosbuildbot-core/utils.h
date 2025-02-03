/*
 * Copyright (c) 2025. Doomhowl Interactive - MIT License
 * File created on: 02-02-2025
 */

#pragma once
#import <Foundation/Foundation.h>

NSString* getWorkingDirectory(void);

BOOL fileExists(NSString* path);

BOOL directoryExists(NSString* path);

void createDirectory(NSString* path);

NSString* runShellCommand(NSString* exe, NSArray<NSString*>* args);

void changeWorkingDirectory(NSString *directoryPath);
