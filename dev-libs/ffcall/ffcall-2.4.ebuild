# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

MY_PV="libffcall-${PV}"

DESCRIPTION="Build foreign function call interfaces in embedded interpreter"
HOMEPAGE="https://www.gnu.org/software/libffcall/"
SRC_URI="mirror://gnu/libffcall/${MY_PV}.tar.gz"
S="${WORKDIR}"/${MY_PV}

# "Ffcall is under GNU GPL. As a special exception, if used in GNUstep
# or in derivate works of GNUstep, the included parts of ffcall are
# under GNU LGPL." -ffcall author
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ppc ppc64 ~riscv sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"

PATCHES=(
	# bug 842915, drop on next version bump
	"${FILESDIR}"/${PN}-2.4-vacall-riscv-pic.patch
)

src_prepare() {
	# The build system is a strange mix of autogenerated
	# files and manual tweaks on top. Uses $CFLAGS / $LDFLAGS randomly.
	# We are adding them consistently here and a bit over the top:
	# bugs: #334581
	local mfi
	for mfi in {,*/,*/*/,}Makefile.in ; do
		einfo "Patching '${mfi}'"
		# usually uses only assembler here, but -march=
		# and -Wa, are a must to pass here.
		sed -e 's/$(CC) /&$(CFLAGS) /g' \
			-i "${mfi}" || die
	done

	default
}

src_configure() {
	append-flags -fPIC

	# Doc goes in datadir
	econf \
		--datadir="${EPREFIX}"/usr/share/doc/${PF} \
		--enable-shared \
		--disable-static
}

src_compile() {
	# TODO. Remove -j1
	emake -j1
}

src_install() {
	dodoc NEWS README
	dodir /usr/share/man

	default

	find "${ED}" -name '*.la' -delete || die
}
