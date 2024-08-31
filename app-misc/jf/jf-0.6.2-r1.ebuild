# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.10

EAPI=8

CRATES="
	autocfg@1.1.0
	hashbrown@0.12.3
	indexmap@1.9.3
	itoa@1.0.6
	ryu@1.0.13
	serde@1.0.163
	serde_json@1.0.96
	serde_yaml@0.9.21
	unsafe-libyaml@0.2.8
"

inherit cargo

DESCRIPTION="A small utility to safely format and print JSON objects in the commandline"
HOMEPAGE="
	https://github.com/sayanarijit/jf
	https://crates.io/crates/jf
"
SRC_URI="
	https://github.com/sayanarijit/jf/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	MIT
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

BDEPEND="
	test? ( app-text/txt2man )
"
RESTRICT="!test? ( test )"

DOCS=(
	README.md
)

QA_FLAGS_IGNORED="usr/bin/jf"
QA_PRESTRIPPED="usr/bin/jf"

src_install() {
	cargo_src_install

	dodoc "${DOCS[@]}"
	doman assets/jf.1
}
