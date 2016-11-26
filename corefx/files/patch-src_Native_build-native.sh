--- src/Native/build-native.sh.orig	2016-11-24 13:40:47 UTC
+++ src/Native/build-native.sh
@@ -52,7 +52,7 @@ prepare_native_build()
     fi
 
     # Generate version.c if specified, else have an empty one.
-    __versionSourceFile=$__rootRepo/bin/obj/version.c
+    __versionSourceFile=$__IntermediatesDir/version.c
     if [ ! -e "${__versionSourceFile}" ]; then
         if [ $__generateversionsource == true ]; then
             $__rootRepo/Tools/msbuild.sh "$__rootRepo/build.proj" /t:GenerateVersionSourceFile /p:GenerateVersionSourceFile=true /v:minimal
@@ -81,6 +81,7 @@ build_native()
         exit 1
     fi
 
+    exit 0
     # Build
 
     echo "Executing make install -j $__NumProc $__MakeExtraArgs"
@@ -244,7 +245,7 @@ case $CPUName in
 esac
 
 # Set the remaining variables based upon the determined build configuration
-__IntermediatesDir="$__rootbinpath/obj/$__BuildOS.$__BuildArch.$__BuildType/Native"
+__IntermediatesDir="$BUILDDIR"
 __BinDir="$__rootbinpath/$__BuildOS.$__BuildArch.$__BuildType/Native"
 
 # Make the directories necessary for build if they don't exist
