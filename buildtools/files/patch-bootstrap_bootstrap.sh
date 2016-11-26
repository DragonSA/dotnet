--- bootstrap/bootstrap.sh.orig	2016-11-22 17:34:38 UTC
+++ bootstrap/bootstrap.sh
@@ -35,7 +35,7 @@ say_verbose() {
 
 machine_has() {
     eval $invocation
-    
+
     hash "$1" > /dev/null 2>&1
     return $?
 }
@@ -45,7 +45,7 @@ check_min_reqs() {
         say_err "curl is required to download dotnet. Install curl to proceed."
         return 1
     fi
-    
+
     return 0
 }
 
@@ -54,7 +54,7 @@ check_min_reqs() {
 # [out_path] - $2 - stdout if not provided
 download() {
     eval $invocation
-    
+
     local remote_path=$1
     local out_path=${2:-}
 
@@ -62,9 +62,14 @@ download() {
     if [ -z "$out_path" ]; then
         curl --retry 10 -sSL --create-dirs $remote_path || failed=true
     else
-        curl --retry 10 -sSL --create-dirs -o $out_path $remote_path || failed=true
+        if [ ! -f "$out_path" ]; then
+            if ! curl --retry 10 -sSL --create-dirs -o $out_path $remote_path; then
+                rm $out_path
+                failed=true
+            fi
+        fi
     fi
-    
+
     if [ "$failed" = true ]; then
         say_err "Download failed"
         return 1
@@ -160,11 +165,7 @@ fi
 initCliScript="dotnet-install.sh"
 dotnetInstallPath="$toolsLocalPath/$initCliScript"
 
-# blow away the tools directory so we can start from a known state
-if [ -d $toolsLocalPath ]; then
-    # if the bootstrap.sh script was downloaded to the tools directory don't delete it
-    find $toolsLocalPath -type f -not -name bootstrap.sh -exec rm -f {} \;
-else
+if [ ! -d $toolsLocalPath ]; then
     mkdir $toolsLocalPath
 fi
 
