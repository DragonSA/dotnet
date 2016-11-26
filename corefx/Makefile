# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	corefx
PORTVERSION=	${DOTNETVERSION}
CATEGORIES=	lang

MAINTAINER=	mono@FreeBSD.org
COMMENT=	.NET Core foundational libraries

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libcurl.so:ftp/curl \
		libgssapi_krb5.so:security/krb5

USES=		ssl
SHEBANG_FILES=	${WRKSRC}/src/Native/build-native.sh

do-configure:
	${SETENV} ${CONFIGURE_ENV} ${WRKSRC}/src/Native/build-native.sh release clang${LLVM_VERSION} configureonly cmakeargs "${CMAKE_ARGS}"

.include "../dotnet/bsd.dotnet.mk"
.include <bsd.port.mk>
