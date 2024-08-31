# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm

MY_P="${PN}-$(ver_cut 1-3)"

DESCRIPTION="Fedora 10 official background artwork"
HOMEPAGE="https://fedoraproject.org/wiki/Artwork/F10Themes/Solar"
SRC_URI="https://archives.fedoraproject.org/pub/archive/fedora/linux/development/15/source/SRPMS/${PN}-$(ver_rs 3 -).fc15.src.rpm"
S="${WORKDIR}/${MY_P/-backgrounds/}"

LICENSE="CC-BY-SA-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

src_compile() { :; }

src_test() { :; }

src_install() {
	insinto /usr/share/backgrounds/solar
	doins -r solar*.xml {normalish,standard,wide}{,.dual}

	insinto /usr/share/gnome-background-properties
	doins desktop-*.xml
}
