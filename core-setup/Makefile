# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	core-setup
PORTVERSION=	1.0.1
CATEGORIES=	devel
DISTVERSIONPREFIX=	v

MAINTAINER=	mono@FreeBSD.org
COMMENT=

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	clang${LLVM_VERSION:S/.//}:lang/clang${LLVM_VERSION:S/.//} \
		bash:shells/bash

USE_GITHUB=	yes
GH_ACCOUNT=	dotnet

USES=		cmake shebangfix
SHEBANG_FILES=	${WRKSRC}/src/corehost/build.sh \

BUILD_WRKSRC=	${BUILDDIR}
INSTALL_TARGET=	install/strip
INSTALL_WRKSRC=	${BUILDDIR}
PLIST_SUB=	DOTNETDIR=${DOTNETDIR} \
		DOTNETDIR_SHARE=${DOTNETDIR_SHARE} \
		DOTNETDIR_SDK=${DOTNETDIR_SDK} \
		DOTNETDIR_FXR=${DOTNETDIR_FXR}

BUILDDIR=	${WRKDIR}/.build
DOTNETDIR=	dotnet/bootstrap
DOTNETDIR_SHARE=${DOTNETDIR}/shared/Microsoft.NETCore.App/1.0.1
DOTNETDIR_SDK=	${DOTNETDIR}/sdk/${SDK_VERSION}
DOTNETDIR_FXR=	${DOTNETDIR}/host/fxr/1.0.1
LLVM_VERSION=	3.7
SDK_VERSION=	1.0.0-preview3-003686	# ${WRKSRC}/DotnetCLIVersion.txt

do-configure:
	${MKDIR} ${BUILDDIR}
	cd ${BUILDDIR} && \
		${SETENV} ${CONFIGURE_ENV} ${MAKE_ENV} ${WRKSRC}/src/corehost/build.sh \
			--arch ${ARCH} \
			--rid ${PORTVERSION} \
			--hostver ${PORTVERSION} \
			--fxrver ${PORTVERSION} \
			--policyver ${PORTVERSION} \
			--commithash 928f772

do-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/${DOTNETDIR} \
		${STAGEDIR}${PREFIX}/${DOTNETDIR_SHARE} \
		${STAGEDIR}${PREFIX}/${DOTNETDIR_SDK} \
		${STAGEDIR}${PREFIX}/${DOTNETDIR_FXR}
	${INSTALL_PROGRAM} ${BUILDDIR}/cli/exe/dotnet ${STAGEDIR}${PREFIX}/${DOTNETDIR}/
	${INSTALL_PROGRAM} ${BUILDDIR}/cli/exe/dotnet ${STAGEDIR}${PREFIX}/${DOTNETDIR_SHARE}/corehost
	${INSTALL_LIB} ${BUILDDIR}/cli/dll/libhostpolicy.so ${STAGEDIR}${PREFIX}/${DOTNETDIR_SHARE}/
	${INSTALL_LIB} ${BUILDDIR}/cli/dll/libhostpolicy.so ${STAGEDIR}${PREFIX}/${DOTNETDIR_SDK}/
	${INSTALL_LIB} ${BUILDDIR}/cli/fxr/libhostfxr.so ${STAGEDIR}${PREFIX}/${DOTNETDIR_SHARE}/
	${INSTALL_LIB} ${BUILDDIR}/cli/fxr/libhostfxr.so ${STAGEDIR}${PREFIX}/${DOTNETDIR_FXR}/
	${INSTALL_LIB} ${BUILDDIR}/cli/fxr/libhostfxr.so ${STAGEDIR}${PREFIX}/${DOTNETDIR_SDK}/

.include <bsd.port.mk>
