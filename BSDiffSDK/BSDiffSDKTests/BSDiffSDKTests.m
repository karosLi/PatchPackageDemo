//
//  BSDiffSDKTests.m
//  BSDiffSDKTests
//
//  Created by karos li on 2020/4/24.
//  Copyright © 2020 karos li. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <BSDiffSDK/BSDiffSDK.h>
#import <SevenZSDK/SevenZSDK.h>

/**
 brew install p7zip
 brew install bsdiff
 
 7z --help
 压缩文件
 7z a 1.0.7z index.html
 7z a 1.1.7z index.html input.png
 
 bsdiff --help
 生成 patch 文件
 bsdiff 1.0.7z 1.1.7z 1.0-1.1.patch
 
 
 1.0.7z
    - index.html
 
 1.1.7z
    - index.html
    - input.png
 
 
 Command + U: 编译+测试
 
 */

@interface BSDiffSDKTests : XCTestCase

@end

@implementation BSDiffSDKTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    /**
     1、合并增量包
    1.0.7z + 1.0-1.1.patch = 1.1.7z
     */
    NSString *oldFilePath = [[NSBundle bundleForClass:self.class] pathForResource:@"1.0.7z" ofType:nil];
    NSString *patchFilePath = [[NSBundle bundleForClass:self.class] pathForResource:@"1.0-1.1.patch" ofType:nil];;
    NSString *newFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"1.1.7z"];
   
    NSError *error = NULL;
    BOOL success = [BSDiffUtil merge:oldFilePath withPatchFile:patchFilePath toNewFile:newFilePath error:&error];
    NSLog(@"=======error====== %@", error.localizedDescription);
    NSLog(@"=====newFilePath====== %@", newFilePath);
    
    /**
     2、解压合并后的全量包 1.1.7z
     */
    NSString *archiveResPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    archiveResPath = [archiveResPath stringByAppendingPathComponent:@"1.1.7z"];
    NSLog(@"=======7z====== %@", archiveResPath);
    
    NSString *destinationPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    destinationPath = [destinationPath stringByAppendingPathComponent:@"Extract7z"];
    NSLog(@"=======destinationPath====== %@", destinationPath);
    
    error = NULL;
    success = [SevenZDec extract7zArchive:archiveResPath toDestination:destinationPath error:&error];
    
    NSLog(@"=======error====== %@", error.localizedDescription);
    
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:destinationPath error:nil];
    for (NSString *entryPath in contents) {
      NSData *outputData = [NSData dataWithContentsOfFile:entryPath];
      NSString *outStr = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];

      NSLog(@"%@", entryPath);
      NSLog(@"%@", outStr);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
