//
//  BSDiff.m
//  BSDiffSDK
//
//  Created by karos li on 2020/4/24.
//  Copyright © 2020 karos li. All rights reserved.
//

#import "BSDiffUtil.h"
#import "bsdiff.h"

@implementation BSDiffUtil

+ (BOOL)merge:(NSString *)oldFilePath withPatchFile:(NSString *)patchFilePath toNewFile:(NSString *)newFilePath error:(NSError **)error  {
    char *argv[4];
    argv[0] = "bspatch";
    // oldPath
    argv[1] = (char *)[oldFilePath UTF8String];
    // newPath
    argv[2] = (char *)[newFilePath UTF8String];
    // patchPath
    argv[3] = (char *)[patchFilePath UTF8String];
    
    char *err = NULL;
    int result = bsdiff_patch(4, argv, &err);
    if (result != 0) {
        *error = [NSError errorWithDomain:@"BSDiffUtil" code:-999 userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithUTF8String:err]}];
        return NO;
    }
    
    return YES;
}

@end
