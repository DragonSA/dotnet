--- build.sh.orig	2016-11-25 08:11:15 UTC
+++ build.sh
@@ -213,13 +213,6 @@ build_coreclr()
         return
     fi
 
-    echo "Executing $buildTool install -j $NumProc"
-
-    $buildTool install -j $NumProc
-    if [ $? != 0 ]; then
-        echo "Failed to build coreclr components."
-        exit 1
-    fi
 	popd
 }
 
@@ -386,7 +379,7 @@ case $CPUName in
         __HostArch=x86
         ;;
 
-    x86_64)
+    x86_64|amd64)
         __BuildArch=x64
         __HostArch=x64
         ;;
@@ -572,7 +565,6 @@ while :; do
             __ConfigureOnly=1
             __SkipMSCorLib=1
             __SkipNuget=1
-            __IncludeTests=
             ;;
 
         skipconfigure)
@@ -672,7 +664,7 @@ __BinDir="$__RootBinDir/Product/$__Build
 __PackagesBinDir="$__BinDir/.nuget"
 __ToolsDir="$__RootBinDir/tools"
 __TestWorkingDir="$__RootBinDir/tests/$__BuildOS.$__BuildArch.$__BuildType"
-export __IntermediatesDir="$__RootBinDir/obj/$__BuildOS.$__BuildArch.$__BuildType"
+export __IntermediatesDir="$BUILDDIR"
 __TestIntermediatesDir="$__RootBinDir/tests/obj/$__BuildOS.$__BuildArch.$__BuildType"
 __isMSBuildOnNETCoreSupported=0
 
@@ -726,5 +718,4 @@ fi
 # Build complete
 
 echo "Repo successfully built."
-echo "Product binaries are available at $__BinDir"
 exit 0
