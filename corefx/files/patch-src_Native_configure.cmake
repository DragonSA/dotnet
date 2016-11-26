--- src/Native/configure.cmake.orig	2016-06-17 21:01:18 UTC
+++ src/Native/configure.cmake
@@ -375,7 +375,6 @@ check_function_exists(
 # getdomainname on OSX takes an 'int' instead of a 'size_t'
 # check if compiling with 'size_t' would cause a warning
 set (PREVIOUS_CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS})
-set (CMAKE_REQUIRED_FLAGS "-Werror -Weverything")
 check_cxx_source_compiles(
     "
     #include <unistd.h>
