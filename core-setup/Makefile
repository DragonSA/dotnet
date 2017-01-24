# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	core-setup
PORTVERSION=	${DOTNET_PORTVERSION}
CATEGORIES=	devel

MAINTAINER=	mono@FreeBSD.org
COMMENT=	Installer packages for the .NET Core runtime and libraries

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

SHEBANG_FILES=	${WRKSRC}/src/corehost/build.sh

do-configure:
	${MKDIR} ${BUILDDIR}
	cd ${BUILDDIR} && \
		${SETENV} ${CONFIGURE_ENV} ${WRKSRC}/src/corehost/build.sh \
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

.include "../dotnet/bsd.dotnet.mk"
.include <bsd.port.mk>
