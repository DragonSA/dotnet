# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	coreclr
PORTVERSION=	${DOTNET_PORTVERSION}
CATEGORIES=	lang

MAINTAINER=	mono@FreeBSD.org
COMMENT=	.NET Core runime and base library

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE.TXT

LIB_DEPENDS=	libunwind.so.8:devel/libunwind \
		libicuuc.so:devel/icu \
		liblldb.so.${LLVM_VERSION}:devel/llvm${LLVM_VERSION:S/.//}

ONLY_FOR_ARCHS=	i386 amd64 armv6

USES=		gettext-runtime python:build
SHEBANG_FILES=	${WRKSRC}/build.sh \
		${WRKSRC}/init-tools.sh \
		${WRKSRC}/src/pal/tools/gen-buildsys-clang.sh \
		${WRKSRC}/src/pal/tests/palsuite/runpaltests.sh

CONFIGURE_ENV=	LLVM_HOME=${LOCALBASE}/llvm${LLVM_VERSION:S/.//}
CMAKE_ARGS=	-DHAVE_PROCFS_CTL=0

post-extract:
	${MKDIR} ${WRKSRC}/Tools/${BUILD_TOOLS_PACKAGE_VERSION}
	${ECHO} '{ "dependencies": { "Microsoft.DotNet.BuildTools": "${BUILD_TOOLS_PACKAGE_VERSION}" }, "frameworks": { "dnxcore50": { } } }' > ${WRKSRC}/Tools/${BUILD_TOOLS_PACKAGE_VERSION}/project.json

post-patch:
	${REINPLACE_CMD} -e 's/desired_llvm_major_version=$$2/desired_llvm_major_version=${LLVM_VERSION:R}/g' \
		-e 's/desired_llvm_minor_version=$$3/desired_llvm_minor_version=${LLVM_VERSION:E}/g' \
			${WRKSRC}/src/pal/tools/gen-buildsys-clang.sh

do-configure:
	${SETENV} ${CONFIGURE_ENV} ${WRKSRC}/build.sh release clang${LLVM_VERSION} configureonly cmakeargs "${CMAKE_ARGS}"

do-test:
	cd ${WRKSRC} && \
		${SETENV} LD_LIBRARY_PATH=${BUILDDIR}src/pal/tests/palsuite/exception_handling/pal_sxs/test1:${LD_LIBRARY_PATH} \
			${WRKSRC}/src/pal/tests/palsuite/runpaltests.sh ${BUILDDIR} ${WRKSRC}/paltestout

.include "../dotnet/bsd.dotnet.mk"
.include <bsd.port.mk>
