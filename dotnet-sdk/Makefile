# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	dotnet-sdk
DISTVERSION=	${SDK_VERSION}
CATEGORIES=	devel
DISTFILES=	dotnet-dev-noplat-noarch.${SDK_VERSION}.tar.xz \
		dotnet-dev-freebsd-noarch.${SDK_VERSION}.tar.xz
MASTER_SITES=	LOCAL/dbn/dotnet

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

post-extract:
	${FIND} ${WRKSRC} \( -name '*.so' -o -name '*.ni.dll' \) -delete
	${RM} ${WRKSRC}/dotnet ${WRKSRC}/sdk/${SDK_VERSION}/corehost
	${RMDIR} ${WRKSRC}/host/fxr/1.0.1
	cd ${WRKSRC}/shared/Microsoft.NETCore.App/${DOTNET_VERSION} && \
		${RM} System.Native.a dotnet corehost sosdocsunix.txt

post-patch:
	${REINPLACE_CMD} -i '' -e '/libuv.so/d' -e '/libcoreclrtraceptprovider.so/d' \
		${WRKSRC}/shared/Microsoft.NETCore.App/${DOTNET_VERSION}/Microsoft.NETCore.App.deps.json

do-build:
	cd ${LOCALBASE}/${DOTNETDIR_SHARE} && \
		${CP} crossgen libcoreclr.so libclrjit.so \
			${WRKSRC}/shared/Microsoft.NETCore.App/${DOTNET_VERSION}/
.for dll in System.Private.CoreLib.dll mscorlib.dll
	cd ${WRKSRC}/shared/Microsoft.NETCore.App/${DOTNET_VERSION}/ && \
		./crossgen /nologo ${dll}
.endfor
	cd ${WRKSRC}/shared/Microsoft.NETCore.App/${DOTNET_VERSION} && \
		${RM} crossgen libcoreclr.so libclrjit.so

do-install:
	cd ${WRKSRC} && \
		${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/${DOTNETDIR}

post-install:
.for dll in redist.dll tool_msbuild.dll
	${FIND} ${STAGEDIR}${PREFIX}/${DOTNETDIR} -name '*.deps.json' | \
		${XARGS} ${REINPLACE_CMD} '/${dll}/d'
.endfor
	${FIND} ${STAGEDIR}${PREFIX}/${DOTNETDIR} -name '*.deps.json.bak' -delete

DOTNETPORTDIR=	${.CURDIR:S|/${PORTNAME}||}

.include "../dotnet/bsd.dotnet.mk"
.include <bsd.port.mk>
