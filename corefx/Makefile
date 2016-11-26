# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	corefx
PORTVERSION=	1.0.0
CATEGORIES=	lang
DISTVERSIONPREFIX=	v

MAINTAINER=	mono@FreeBSD.org
COMMENT=	.NET Core foundational libraries

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	clang${LLVM_VERSION:S/.//}:lang/clang${LLVM_VERSION:S/.//} \
		bash:shells/bash
LIB_DEPENDS+=	libcurl.so:ftp/curl \
		libgssapi_krb5.so:security/krb5

USE_GITHUB=	yes
GH_ACCOUNT=	dotnet

USES=		cmake ssl shebangfix
SHEBANG_FILES=	${WRKSRC}/build.sh

BUILD_WRKSRC=	${BUILDDIR}
CMAKE_ARGS=	-DCMAKE_INSTALL_PREFIX=${PREFIX}/${DOTNETDIR_SHARE}
CONFIGURE_ENV=	BUILDDIR=${BUILDDIR}
INSTALL_TARGET=	install/strip
INSTALL_WRKSRC=	${BUILDDIR}
PLIST_SUB=	DOTNETDIR=${DOTNETDIR} \
		DOTNETDIR_SHARE=${DOTNETDIR_SHARE}

BUILDDIR=	${WRKDIR}/.build
DOTNETDIR=	dotnet/bootstrap
DOTNETDIR_SHARE=${DOTNETDIR}/shared/Microsoft.NETCore.App/1.0.1
LLVM_VERSION=	3.7

do-configure:
	${SETENV} ${CONFIGURE_ENV} ${WRKSRC}/build.sh native release clang${LLVM_VERSION} configureonly cmakeargs "${CMAKE_ARGS}"

post-install:
	${FIND} ${STAGEDIR}${PREFIX}/${DOTNETDIR_SHARE} -name '*.dbg' -delete

.include <bsd.port.mk>
