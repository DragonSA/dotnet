--- src/pal/src/thread/process.cpp.orig	2016-11-01 20:05:29 UTC
+++ src/pal/src/thread/process.cpp
@@ -2888,21 +2888,7 @@ BOOL InitializeFlushProcessWriteBuffers(
     // Verify that the s_helperPage is really aligned to the VIRTUAL_PAGE_SIZE
     _ASSERTE((((SIZE_T)s_helperPage) & (VIRTUAL_PAGE_SIZE - 1)) == 0);
 
-    // Locking the page ensures that it stays in memory during the two mprotect
-    // calls in the FlushProcessWriteBuffers below. If the page was unmapped between
-    // those calls, they would not have the expected effect of generating IPI.
-    int status = mlock(s_helperPage, VIRTUAL_PAGE_SIZE);
-
-    if (status != 0)
-    {
-        return FALSE;
-    }
-
-    status = pthread_mutex_init(&flushProcessWriteBuffersMutex, NULL);
-    if (status != 0)
-    {
-        munlock(s_helperPage, VIRTUAL_PAGE_SIZE);
-    }
+    int status = pthread_mutex_init(&flushProcessWriteBuffersMutex, NULL);
 
     return status == 0;
 }
