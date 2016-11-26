--- init-tools.sh.orig	2016-11-23 22:20:58 UTC
+++ init-tools.sh
@@ -79,6 +79,11 @@ OSName=$(uname -s)
             OS=Linux
             ;;
 
+        FreeBSD)
+            __DOTNET_PKG="dotnet-dev-centos-x64"
+            OS=FreeBSD
+            ;;
+
         *)
             echo "Unsupported OS '$OSName' detected. Downloading ubuntu-x64 tools."
             OS=Linux
@@ -87,7 +92,6 @@ OSName=$(uname -s)
   esac
 fi
 if [ ! -e $__INIT_TOOLS_DONE_MARKER ]; then
-    if [ -e $__TOOLRUNTIME_DIR ]; then rm -rf -- $__TOOLRUNTIME_DIR; fi
     echo "Running: $__scriptpath/init-tools.sh" > $__init_tools_log
     if [ ! -e $__DOTNET_PATH ]; then
         echo "Installing dotnet cli..."
@@ -129,4 +133,4 @@ if [ ! -e $__INIT_TOOLS_DONE_MARKER ]; t
     echo "Done initializing tools."
 else
     echo "Tools are already initialized"
-fi
\ No newline at end of file
+fi
