//
//  SevenZDec.h
//  SevenZSDK
//
//  Created by karos li on 2020/4/24.
//  Copyright © 2020 karos li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SevenZDec : NSObject

+ (BOOL)extract7zArchive:(NSString *)archivePath
           toDestination:(NSString *)toDestination
                   error:(NSError ** __nullable)error;


@end

NS_ASSUME_NONNULL_END
