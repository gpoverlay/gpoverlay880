# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=AZJADFTRE
DIST_VERSION=1.4
inherit perl-module

DESCRIPTION="Cleans up HTML code for web browsers, not humans"

SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 ~s390 sparc x86"
IUSE=""

RDEPEND="!<app-text/html-xml-utils-5.3"
BDEPEND="${RDEPEND}"
