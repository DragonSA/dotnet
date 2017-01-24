# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	corefx
PORTVERSION=	${DOTNET_PORTVERSION}
CATEGORIES=	lang

MAINTAINER=	mono@FreeBSD.org
COMMENT=	.NET Core foundational libraries

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libcurl.so:ftp/curl

OPTIONS_DEFAULT=	GSSAPI_MIT
OPTIONS_SINGLE=		GSSAPI
OPTIONS_SINGLE_GSSAPI=	GSSAPI_HEIMDAL GSSAPI_MIT

USES=		ssl
SHEBANG_FILES=	${WRKSRC}/src/Native/build-native.sh

GSSAPI_HEIMDAL_CMAKE_BOOL=	HAVE_HEIMDAL_HEADERS
GSSAPI_HEIMDAL_CMAKE_ON=	-DLIBGSS:PATH=${GSSAPILIBDIR}/libgssapi.so
GSSAPI_HEIMDAL_USES=		gssapi:heimdal
GSSAPI_MIT_ON=			-DLIBGSS:PATH=${GSSAPILIBDIR}/libgssapi_krb5.so
GSSAPI_MIT_USES=		gssapi:mit

do-configure:
	${SETENV} ${CONFIGURE_ENV} ${WRKSRC}/src/Native/build-native.sh release clang${LLVM_VERSION} configureonly cmakeargs "${CMAKE_ARGS}"

.include "../dotnet/bsd.dotnet.mk"
.include <bsd.port.mk>
