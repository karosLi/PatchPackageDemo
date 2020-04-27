//
//  SevenZDec.m
//  SevenZSDK
//
//  Created by karos li on 2020/4/24.
//  Copyright © 2020 karos li. All rights reserved.
//

#import "SevenZDec.h"
#include "7z.h"

@implementation SevenZDec

+ (BOOL)extract7zArchive:(NSString *)archivePath
           toDestination:(NSString *)toDestination
                   error:(NSError **)error
{
    BOOL worked, isDir, existsAlready;
    existsAlready = [[NSFileManager defaultManager] fileExistsAtPath:toDestination isDirectory:&isDir];

    if (existsAlready && !isDir) {
        worked = [[NSFileManager defaultManager] removeItemAtPath:toDestination error:nil];
        if (!worked) {
            *error = [NSError errorWithDomain:@"SevenZDec" code:-999 userInfo:@{NSLocalizedDescriptionKey: @"could not remove existing file with same name as destination dir"}];
            return NO;
        }
    }

    if (existsAlready && isDir) {
        // Remove all the files in the named tmp dir
        NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:toDestination error:nil];
        for (NSString *path in contents) {
            NSString *myTmpDirPath = [toDestination stringByAppendingPathComponent:path];
            worked = [[NSFileManager defaultManager] removeItemAtPath:myTmpDirPath error:nil];
            if (!worked) {
                *error = [NSError errorWithDomain:@"SevenZDec" code:-999 userInfo:@{NSLocalizedDescriptionKey: @"could not remove existing file"}];
                return NO;
            }
        }
    } else {
        worked = [[NSFileManager defaultManager] createDirectoryAtPath:toDestination withIntermediateDirectories:YES attributes:nil error:nil];
        if (!worked) {
            *error = [NSError errorWithDomain:@"SevenZDec" code:-999 userInfo:@{NSLocalizedDescriptionKey: @"could not create destination dir"}];
            return NO;
        }
    }

    worked = [[NSFileManager defaultManager] changeCurrentDirectoryPath:toDestination];
    if (!worked) {
        *error = [NSError errorWithDomain:@"SevenZDec" code:-999 userInfo:@{NSLocalizedDescriptionKey: @"cd to destination dir failed"}];
        return NO;
    }

    char *archivePathPtr = (char*) [archivePath UTF8String];
    char *err = NULL;
    int result = sevenZ_extract(archivePathPtr, &err);
    if (result != 0) {
        *error = [NSError errorWithDomain:@"SevenZDec" code:-999 userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithUTF8String:err]}];
        return NO;
    }
    
    return YES;
}

@end
