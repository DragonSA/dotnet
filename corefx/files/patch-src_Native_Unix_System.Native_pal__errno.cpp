--- src/Native/Unix/System.Native/pal_errno.cpp.orig	2016-11-07 21:31:17 UTC
+++ src/Native/Unix/System.Native/pal_errno.cpp
@@ -8,11 +8,6 @@
 
 #include <errno.h>
 
-// ENODATA is not defined on FreeBSD.
-#if defined(__FreeBSD__)
-#define ENODATA ENOATTR
-#endif
-
 #include <string.h>
 #include <assert.h>
 
