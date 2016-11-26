--- src/corehost/build.sh.orig	2016-11-07 16:44:11 UTC
+++ src/corehost/build.sh
@@ -122,6 +122,8 @@ __cmake_defines="${__cmake_defines} ${__
 __rid_plat=
 if [ "$(uname -s)" == "Darwin" ]; then
     __rid_plat=osx.10.10
+elif [ "$(uname)" == "FreeBSD" ]; then
+    __rid_plat=freebsd
 else
     init_rid_plat
 fi
@@ -147,4 +149,3 @@ else
     cmake "$DIR" -G "Unix Makefiles" $__cmake_defines -DCLI_CMAKE_RUNTIME_ID:STRING=$__runtime_id -DCLI_CMAKE_HOST_VER:STRING=$__host_ver -DCLI_CMAKE_HOST_FXR_VER:STRING=$__fxr_ver -DCLI_CMAKE_HOST_POLICY_VER:STRING=$__policy_ver -DCLI_CMAKE_PKG_RID:STRING=$__base_rid -DCLI_CMAKE_COMMIT_HASH:STRING=$__commit_hash
 fi
 set +x # turn off trace
-make
