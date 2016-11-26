--- build.sh.orig	2016-11-26 04:54:39 UTC
+++ build.sh
@@ -185,13 +185,6 @@ build_coreclr()
 
     # Build CoreCLR
 
-    echo "Executing $buildTool install -j $NumProc $__UnprocessedBuildArgs"
-
-    $buildTool install -j $NumProc $__UnprocessedBuildArgs
-    if [ $? != 0 ]; then
-        echo "Failed to build coreclr components."
-        exit 1
-    fi
 }
 
 restoreBuildTools()
@@ -401,7 +394,7 @@ case $CPUName in
         __HostArch=x86
         ;;
 
-    x86_64)
+    x86_64|amd64)
         __BuildArch=x64
         __HostArch=x64
         ;;
@@ -575,9 +568,7 @@ while :; do
 
         configureonly)
             __ConfigureOnly=1
-            __SkipCoreCLR=1
             __SkipMSCorLib=1
-            __IncludeTests=
             ;;
 
         skipconfigure)
@@ -686,7 +677,7 @@ __BinDir="$__RootBinDir/Product/$__Build
 __PackagesBinDir="$__BinDir/.nuget"
 __ToolsDir="$__RootBinDir/tools"
 __TestWorkingDir="$__RootBinDir/tests/$__BuildOS.$__BuildArch.$__BuildType"
-export __IntermediatesDir="$__RootBinDir/obj/$__BuildOS.$__BuildArch.$__BuildType"
+export __IntermediatesDir="$BUILDDIR"
 __TestIntermediatesDir="$__RootBinDir/tests/obj/$__BuildOS.$__BuildArch.$__BuildType"
 __isMSBuildOnNETCoreSupported=0
 
@@ -750,5 +741,4 @@ fi
 # Build complete
 
 echo "Repo successfully built."
-echo "Product binaries are available at $__BinDir"
 exit 0
