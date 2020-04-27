//
//  BSDiff.h
//  BSDiffSDK
//
//  Created by karos li on 2020/4/24.
//  Copyright © 2020 karos li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSDiffUtil : NSObject

+ (BOOL)merge:(NSString *)oldFilePath withPatchFile:(NSString *)patchFilePath toNewFile:(NSString *)newFilePath error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
