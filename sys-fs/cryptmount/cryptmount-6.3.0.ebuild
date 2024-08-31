# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools linux-info

DESCRIPTION="A utility for management and user-mode mounting of encrypted filesystems"
HOMEPAGE="http://cryptmount.sourceforge.net/"
SRC_URI="https://github.com/rwpenney/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="argv0switch cswap fsck +gcrypt +largefile mount +nls +luks +openssl systemd"
REQUIRED_USE="
	luks? ( gcrypt )
	openssl? ( gcrypt )
"

RDEPEND="
	sys-fs/lvm2
	virtual/libiconv
	virtual/libintl
	gcrypt? ( dev-libs/libgcrypt:0= )
	luks? ( sys-fs/cryptsetup )
	openssl? ( dev-libs/openssl:0= )
	systemd? ( sys-apps/systemd )
"

DEPEND="
	${RDEPEND}
	sys-kernel/linux-headers
"

BDEPEND="nls? ( sys-devel/gettext )"

CONFIG_CHECK="BLK_DEV_DM"
ERROR_BLK_DEV_DM="
	Please enable Device Mapper support in your kernel config
	-> Device Drivers
		-> Multiple devices driver support (RAID and LVM)
			-> Multiple devices driver support (RAID and LVM)
				<*>/<M> Device mapper support
"

src_prepare() {
	default

	# Fix doc directory
	sed -e 's/doc\/cryptmount/doc\/${PF}/g' -i Makefile.am || die

	eautoreconf
}

src_configure() {
	local myeconf=(
		--disable-rpath
		$(use_enable argv0switch)
		$(use_enable cswap)
		$(use_enable fsck)
		$(use_with gcrypt libgcrypt)
		$(use_enable largefile)
		$(use_enable mount delegation)
		$(use_enable nls)
		$(use_enable luks)
		$(use_enable openssl openssl-compat)
		$(use_with systemd)
	)

	econf "${myeconf[@]}"
}
