--- build.sh.orig	2016-11-26 05:38:46 UTC
+++ build.sh
@@ -86,7 +86,7 @@ prepare_native_build()
     fi
 
     # Generate version.c if specified, else have an empty one.
-    __versionSourceFile=$__scriptpath/bin/obj/version.c
+    __versionSourceFile=$__IntermediatesDir/version.c
     if [ ! -e "${__versionSourceFile}" ]; then
         if [ $__generateversionsource == true ]; then
             $__scriptpath/Tools/corerun $__scriptpath/Tools/MSBuild.exe "$__scriptpath/build.proj" /t:GenerateVersionSourceFile /p:GenerateVersionSourceFile=true /v:minimal
@@ -143,6 +143,7 @@ build_native()
         NumProc=$(($(getconf _NPROCESSORS_ONLN)+1))
     fi
 
+    exit 0
     # Build
 
     echo "Executing make install -j $NumProc"
@@ -179,7 +180,7 @@ case $CPUName in
         __BuildArch=x86
         ;;
 
-    x86_64)
+    x86_64|amd64)
         __BuildArch=x64
         ;;
 
@@ -208,7 +209,7 @@ case $OSName in
     FreeBSD)
         __HostOS=FreeBSD
         # TODO: Add native version
-        __TestNugetRuntimeId=osx.10.10-x64
+        __TestNugetRuntimeId=freebsd-x64
         ;;
 
     Linux)
@@ -376,7 +377,7 @@ if [ ! -e "$__nativeroot" ]; then
 fi
 
 # Set the remaining variables based upon the determined build configuration
-__IntermediatesDir="$__rootbinpath/obj/$__BuildOS.$__BuildArch.$__BuildType/Native"
+__IntermediatesDir="$BUILDDIR"
 __BinDir="$__rootbinpath/$__BuildOS.$__BuildArch.$__BuildType/Native"
 
 # Make the directories necessary for build if they don't exist
