# 增量包合并和解压


## 基于源码编译
7z (lzma1900)
https://www.7-zip.org/sdk.html


bzip2（1.0.6）
https://sourceforge.net/projects/bzip2/

bsdiff（4.3）
http://www.daemonology.net/bsdiff/



## 简单用法
### 合并增量包&解压合并后的全量包

```
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
```



