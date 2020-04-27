//
//  bsdiff.h
//  BSDiffSDK
//
//  Created by karos li on 2020/4/24.
//  Copyright © 2020 karos li. All rights reserved.
//


#ifndef bsdiff_h
#define bsdiff_h

#ifndef EXTERN_C_BEGIN
#ifdef __cplusplus
#define EXTERN_C_BEGIN extern "C" {
#define EXTERN_C_END }
#else
#define EXTERN_C_BEGIN
#define EXTERN_C_END
#endif
#endif


EXTERN_C_BEGIN

int bsdiff_diff(int argc,char *argv[]);
int bsdiff_patch(int argc,char * argv[],char **error);

EXTERN_C_END

#endif /* bsdiff_h */
