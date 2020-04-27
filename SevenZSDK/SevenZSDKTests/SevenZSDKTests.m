//
//  SevenZSDKTests.m
//  SevenZSDKTests
//
//  Created by karos li on 2020/4/24.
//  Copyright © 2020 karos li. All rights reserved.
//

#import <XCTest/XCTest.h>
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


*/

@interface SevenZSDKTests : XCTestCase

@end

@implementation SevenZSDKTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
//    NSString *archiveFilename = @"1.0.7z";
    NSString *archiveFilename = @"1.1.7z";
    NSString *archiveResPath = [[NSBundle bundleForClass:self.class] pathForResource:archiveFilename ofType:nil];
    NSLog(@"=======7z====== %@", archiveResPath);
    
    NSString *destinationPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    destinationPath = [destinationPath stringByAppendingPathComponent:@"Extract7z"];
    NSLog(@"=======destinationPath====== %@", destinationPath);
    
    NSError *error = NULL;
    BOOL success = [SevenZDec extract7zArchive:archiveResPath toDestination:destinationPath error:&error];
    
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
