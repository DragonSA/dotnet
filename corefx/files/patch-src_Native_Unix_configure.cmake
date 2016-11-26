--- src/Native/Unix/configure.cmake.orig	2016-11-07 21:31:17 UTC
+++ src/Native/Unix/configure.cmake
@@ -24,9 +24,6 @@ else ()
     message(FATAL_ERROR "Unknown platform.  Cannot define PAL_UNIX_NAME, used by RuntimeInformation.")
 endif ()
 
-# We compile with -Werror, so we need to make sure these code fragments compile without warnings.
-set(CMAKE_REQUIRED_FLAGS -Werror)
-
 # in_pktinfo: Find whether this struct exists
 check_include_files(
     linux/in.h
@@ -396,7 +393,6 @@ check_function_exists(
 # getdomainname on OSX takes an 'int' instead of a 'size_t'
 # check if compiling with 'size_t' would cause a warning
 set (PREVIOUS_CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS})
-set (CMAKE_REQUIRED_FLAGS "-Werror -Weverything")
 check_cxx_source_compiles(
     "
     #include <unistd.h>
