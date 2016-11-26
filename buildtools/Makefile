# Created by: David Naylor <dbn@dragon.local>
# $FreeBSD$

PORTNAME=	buildtools
PORTVERSION=	1.1.0
CATEGORIES=	devel

MAINTAINER=	dbn@FreeBSD.org
COMMENT=	Build tools for building .NET Core projects

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

USE_GITHUB=	yes
GH_ACCOUNT=	dotnet
GH_TAGNAME=	a4da74d

USES=		mono:nuget
NUGET_DEPENDS=	NuGet.CommandLine=3.4.3 \
		Microsoft.DotNet.BuildTools=1.0.26-prerelease-00802-01 \
		Microsoft.DotNet.BuildTools.Run=1.0.0-prerelease-00807-04

# https://dotnetcli.azureedge.net/dotnet/Sdk/1.0.0-preview3-003223/dotnet-dev-centos-x64.1.0.0-preview3-003223.tar.gz

do-build:
	xbuild ${WRKSRC}/build.proj

.include <bsd.port.mk>
