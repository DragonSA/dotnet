# Created by: David Naylor <dbn@FreeBSD.org
# $FreeBSD$

PORTNAME=	msbuild
PORTVERSION=	0.0.0
CATEGORIES=	devel
DISTFILES=	${BOOTSTRAP}:bootstrap ${SDK}:sdk
MASTER_SITES=	https://github.com/Microsoft/msbuild/releases/download/mono-hosted-msbuild-v0.2/:bootstrap \
		https://dotnetcli.blob.core.windows.net/dotnet/Sdk/${SDK_VERSION}/:sdk
EXTRACT_ONLY=	${_DISTFILES:N${BOOTSTRAP}:N${SDK}:N*.nupkg}

MAINTAINER=	mono@FreeBSD.org
COMMENT=	The build platform for .NET

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	bash:shells/bash

USE_GITHUB=	yes
GH_ACCOUNT=	Microsoft
GH_TAGNAME=	ee1e95c

USES=		mono:dotnet shebangfix
# Microsoft.DotNet.BuildTools=`cat ${WRKSRC}/BuildToolsVersion.txt`
#NUGET_DEPENDS=	MicroBuild.Core=0.2.0 \
#		Microsoft.DotNet.BuildTools=1.0.27-prerelease-00927-05:myget \
#		Microsoft.Portable.Targets=0.1.1-dev:myget \
#		Nerdbank.GitVersioning=1.5.46
SHEBANG_FILES=	${WRKSRC}/cibuild.sh

MAKE_ENV=	NUGET_HTTP_CACHE_PATH=${WRKSRC}/cache

BOOTSTRAP=	mono_msbuild_bootstrap_5e01f07.zip
MASTER_SITES_myget=	https://dotnet.myget.org/F/dotnet-buildtools/api/v2/package
SDK=		dotnet-dev-centos-x64.${SDK_VERSION}.tar.gz
SDK_VERSION=	1.0.0-preview3-003686	# ${WRKSRC}/DotnetCLIVersion.txt

post-extract:
	${MKDIR} ${WRKSRC}/cache
.for extract in packages:${BOOTSTRAP} Tools/dotnetcli:${SDK}
	${MKDIR} ${WRKSRC}/${extract:C/:.*//}
	${EXTRACT_CMD} -C ${WRKSRC}/${extract:C/:.*//} ${EXTRACT_BEFORE_ARGS} ${DISTDIR}/${extract:C/.*://} ${EXTRACT_AFTER_ARGS}
.endfor
#.for lockfile in targets/roslyn/project.lock.json targets/runtimeDependencies/project.lock.json
#	${ECHO} '{}' > ${WRKSRC}/${lockfile}
#.endfor
#	${CP} -R ${NUGET_PACKAGEDIR}/Microsoft.DotNet.BuildTools/1.0.27-prerelease-00927-05/lib/ \
#		${NUGET_PACKAGEDIR}/Microsoft.Portable.Targets/0.1.1-dev/contentFiles/any/any/ \
#		${NUGET_PACKAGEDIR}/MicroBuild.Core/0.2.0/build/ \
#			${WRKSRC}/Tools/

post-patch:
#	${MKDIR} ${WRKSRC}/Tools/dotnetcli
#	${CP} ${FILESDIR}/dotnet ${WRKSRC}/Tools/dotnetcli/
#	${MV} ${NUGET_PACKAGEDIR}/Nerdbank.GitVersioning/1.5.46/build/NerdBank.GitVersioning.targets \
#		${NUGET_PACKAGEDIR}/Nerdbank.GitVersioning/1.5.46/build/Nerdbank.GitVersioning.targets

do-build:
	cd ${WRKSRC} && \
		${SETENV} ${CONIFIGURE_ENV} ${MAKE_ENV} ${WRKSRC}/cibuild.sh --target Mono --host Mono --scope Test

.include <bsd.port.mk>
