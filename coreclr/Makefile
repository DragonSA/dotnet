# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	coreclr
PORTVERSION=	1.0.4
CATEGORIES=	lang
DISTVERSIONPREFIX=	v

MAINTAINER=	mono@FreeBSD.org
COMMENT=	.NET Core runime and base library

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE.TXT

BUILD_DEPENDS=	clang${LLVM_VERSION:S/.//}:lang/clang${LLVM_VERSION:S/.//} \
		bash:shells/bash
LIB_DEPENDS=	libunwind.so.8:devel/libunwind \
		libicuuc.so:devel/icu \
		liblldb.so.${LLVM_VERSION}:devel/llvm${LLVM_VERSION:S/.//}

ONLY_FOR_ARCHS=	i386 amd64 armv6

USE_GITHUB=	yes
GH_ACCOUNT=	dotnet

USES=		gettext-runtime python:build shebangfix
SHEBANG_FILES=	${WRKSRC}/build.sh \
		${WRKSRC}/init-tools.sh \
		${WRKSRC}/src/pal/tools/gen-buildsys-clang.sh \
		${WRKSRC}/src/pal/tests/palsuite/runpaltests.sh

BUILD_WRKSRC=	${BUILDDIR}
CONFIGURE_ENV=	BUILDDIR=${BUILDDIR} LLVM_HOME=${LOCALBASE}/llvm${LLVM_VERSION:S/.//}
CMAKE_ARGS=	-DHAVE_PROCFS_CTL=0 -DCMAKE_INSTALL_PREFIX=${PREFIX}/${DOTNETDIR_SHARE} \
		-DWITH_LLDB_LIBS=${LOCALBASE}/llvm${LLVM_VERSION:S/.//}/lib \
		-DWITH_LLDB_INCLUDES=${LOCALBASE}/llvm${LLVM_VERSION:S/.//}/include
INSTALL_TARGET=	install/strip
INSTALL_WRKSRC=	${BUILDDIR}
PLIST_SUB=	DOTNETDIR=${DOTNETDIR} \
		DOTNETDIR_SHARE=${DOTNETDIR_SHARE}

BUILDDIR=	${WRKDIR}/.build
DOTNETDIR=	dotnet/bootstrap
DOTNETDIR_SHARE=${DOTNETDIR}/shared/Microsoft.NETCore.App/1.0.1
BUILD_TOOLS_PACKAGE_VERSION=	1.0.25-prerelease-00510-02  # ${WRKSRC}/BuildToolsVersion.txt
LLVM_VERSION=	3.7

post-extract:
	${MKDIR} ${WRKSRC}/Tools/${BUILD_TOOLS_PACKAGE_VERSION}
	${ECHO} '{ "dependencies": { "Microsoft.DotNet.BuildTools": "${BUILD_TOOLS_PACKAGE_VERSION}" }, "frameworks": { "dnxcore50": { } } }' > ${WRKSRC}/Tools/${BUILD_TOOLS_PACKAGE_VERSION}/project.json

post-patch:
	${REINPLACE_CMD} -e 's/desired_llvm_major_version=$$2/desired_llvm_major_version=${LLVM_VERSION:R}/g' \
		-e 's/desired_llvm_minor_version=$$3/desired_llvm_minor_version=${LLVM_VERSION:E}/g' \
			${WRKSRC}/src/pal/tools/gen-buildsys-clang.sh

do-configure:
	${SETENV} ${CONFIGURE_ENV} ${WRKSRC}/build.sh release clang${LLVM_VERSION} configureonly cmakeargs "${CMAKE_ARGS}"

post-install:
	${FIND} ${STAGEDIR}${PREFIX}/${BOOTSTRAPDIR_SHARE} -name '*.dbg' -delete

do-test:
	cd ${WRKSRC} && \
		${SETENV} LD_LIBRARY_PATH=${BUILDDIR}src/pal/tests/palsuite/exception_handling/pal_sxs/test1:${LD_LIBRARY_PATH} \
			${WRKSRC}/src/pal/tests/palsuite/runpaltests.sh ${BUILDDIR} ${WRKSRC}/paltestout

.include <bsd.port.mk>
