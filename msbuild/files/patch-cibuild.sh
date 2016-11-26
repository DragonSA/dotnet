--- cibuild.sh.orig	2016-11-24 13:08:02 UTC
+++ cibuild.sh
@@ -204,6 +204,11 @@ case $OS_NAME in
         EXTRA_ARGS="$EXTRA_ARGS /p:RuntimeSystem=$(get_current_linux_name)"
         ;;
 
+    FreeBSD)
+        OS_ARG="Unix"
+        EXTRA_ARGS="$EXTRA_ARGS /p:RuntimeSystem=FreeBSD"
+        ;;
+
     *)
         echo "Unsupported OS $OS_NAME detected, configuring as if for Linux"
         OS_ARG="Unix"
@@ -231,7 +236,7 @@ case $target in
     Mono)
         setMonoDir
         CONFIGURATION=Debug-MONO
-        EXTRA_ARGS="/p:CscToolExe=mcs /p:CscToolPath=$MONO_BIN_DIR"
+        EXTRA_ARGS="$EXTRA_ARGS /p:CscToolExe=mcs /p:CscToolPath=$MONO_BIN_DIR"
         RUNTIME_HOST_ARGS="--debug"
         ;;
     *)
