# Created by: David Naylor <dbn@FreeBSD.org
# $FreeBSD$

PORTNAME=	buildtools
PORTVERSION=	1.1.0
CATEGORIES=	devel
DISTFILES=	${SDK}:sdk
MASTER_SITES=	https://dotnetcli.azureedge.net/dotnet/Sdk/${SDK_VERSION}/:sdk \
		https://dotnetcli.blob.core.windows.net/dotnet/Sdk/${SDK_VERSION}/:sdk
EXTRACT_ONLY=	${_DISTFILES:N${SDK}:N*.nupkg}

MAINTAINER=	mono@FreeBSD.org
COMMENT=	Build tools for building .NET Core projects

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

USE_GITHUB=	yes
GH_ACCOUNT=	dotnet
GH_TAGNAME=	d3eecda

USES=		mono:nuget
NUGET_DEPENDS=	NuGet.CommandLine=3.4.3 \
		Microsoft.DotNet.BuildTools=1.0.26-prerelease-00802-01 \
		Microsoft.DotNet.BuildTools.Run=1.0.0-prerelease-00807-04

MASTER_SITES_myget=	https://dotnet.myget.org/F/dotnet-buildtools/api/v2/package
SDK=		dotnet-dev-centos-x64.${SDK_VERSION}.tar.gz
SDK_VERSION=	1.0.0-preview3-003686	# ${WRKSRC}/DotnetCLIVersion.txt

post-extract:
	${MKDIR} ${WRKSRC}/Tools/dotnetcli
	${EXTRACT_CMD} -C ${WRKSRC}/Tools/dotnetcli ${EXTRACT_BEFORE_ARGS} ${DISTDIR}/${SDK} ${EXTRACT_AFTER_ARGS}

do-build:
	xbuild ${WRKSRC}/build.proj

.include <bsd.port.mk>
