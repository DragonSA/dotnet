# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	dotnet-sdk
DISTVERSION=	${SDK_VERSION}
CATEGORIES=	devel
DISTFILES=	dotnet-dev-centos-x64.${SDK_VERSION}.tar.gz \
		dotnet-dev-freebsd-noarch.${SDK_VERSION}.tar.gz:dbn
MASTER_SITES=	https://dotnetcli.azureedge.net/dotnet/Sdk/${DISTVERSION}/ \
		https://dotnetcli.blob.core.windows.net/dotnet/Sdk/${DISTVERSION}/ \
		LOCAL/dbn/dotnet/:dbn

MAINTAINER=	mono@FreeBSD.org
COMMENT=	Development kit for .Net Core

BUILD_DEPENDS=	${LOCALBASE}/${DOTNETDIR_SHARE}/crossgen:${DOTNETPORTDIR}/coreclr
RUN_DEPENDS=	${LOCALBASE}/${DOTNETDIR}/dotnet:${DOTNETPORTDIR}/core-setup \
		${LOCALBASE}/${DOTNETDIR_SHARE}/libcoreclr.so:${DOTNETPORTDIR}/coreclr \
		${LOCALBASE}/${DOTNETDIR_SHARE}/System.Native.so:${DOTNETPORTDIR}/corefx

NO_WRKSUBDIR=	yes
PLIST_SUB=	DOTNETDIR=${DOTNETDIR} \
		DOTNETDIR_SHARE=${DOTNETDIR_SHARE} \
		DOTNETDIR_SDK=${DOTNETDIR_SDK} \
		DOTNETDIR_FXR=${DOTNETDIR_FXR}

DOTNETDIR=	dotnet/bootstrap
DOTNETDIR_SHARE=${DOTNETDIR}/shared/Microsoft.NETCore.App/1.0.1
DOTNETDIR_SDK=	${DOTNETDIR}/sdk/${SDK_VERSION}
DOTNETDIR_FXR=	${DOTNETDIR}/host/fxr/1.0.1
SDK_VERSION=	1.0.0-preview3-003686

post-extract:
	${FIND} ${WRKSRC} \( -name '*.so' -o -name '*.ni.dll' \) -delete
	${RM} ${WRKSRC}/dotnet ${WRKSRC}/sdk/${SDK_VERSION}/corehost
	${RMDIR} ${WRKSRC}/host/fxr/1.0.1
	cd ${WRKSRC}/shared/Microsoft.NETCore.App/1.0.1 && \
		${RM} System.Native.a dotnet corehost sosdocsunix.txt

post-patch:
	${REINPLACE_CMD} -i '' -e '/libuv.so/d' -e '/libcoreclrtraceptprovider.so/d' \
		${WRKSRC}/shared/Microsoft.NETCore.App/1.0.1/Microsoft.NETCore.App.deps.json

do-build:
	cd ${LOCALBASE}/${DOTNETDIR_SHARE} && \
		${CP} crossgen libcoreclr.so libclrjit.so \
			${WRKSRC}/shared/Microsoft.NETCore.App/1.0.1/
.for dll in System.Private.CoreLib.dll mscorlib.dll
	cd ${WRKSRC}/shared/Microsoft.NETCore.App/1.0.1/ && \
		./crossgen /nologo ${dll}
.endfor
	cd ${WRKSRC}/shared/Microsoft.NETCore.App/1.0.1 && \
		${RM} crossgen libcoreclr.so libclrjit.so

do-install:
	cd ${WRKSRC} && \
		${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/${DOTNETDIR}

DOTNETPORTDIR=	${.CURDIR:S|/${PORTNAME}||}

.include <bsd.port.mk>
