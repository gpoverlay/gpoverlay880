# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.2

EAPI=8

CRATES="
	anstream@0.6.13
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anstyle@1.0.6
	anyhow@1.0.81
	bitflags@1.3.2
	bitflags@2.5.0
	cc@1.0.90
	cfg-if@1.0.0
	clap@4.5.3
	clap_builder@4.5.2
	clap_complete@4.5.1
	clap_complete_nushell@4.5.1
	clap_derive@4.5.3
	clap_lex@0.7.0
	colorchoice@1.0.0
	crossbeam-channel@0.5.12
	crossbeam-utils@0.8.19
	deranged@0.3.11
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	errno@0.3.8
	fastrand@2.0.1
	form_urlencoded@1.2.1
	getrandom@0.2.12
	git2@0.19.0
	heck@0.5.0
	hermit-abi@0.3.9
	idna@0.5.0
	is-terminal@0.4.12
	itoa@1.0.10
	jobserver@0.1.28
	libc@0.2.155
	libgit2-sys@0.17.0+1.8.1
	libredox@0.0.1
	libz-sys@1.1.16
	linux-raw-sys@0.4.13
	log@0.4.21
	memchr@2.7.1
	num-conv@0.1.0
	once_cell@1.19.0
	percent-encoding@2.3.1
	pkg-config@0.3.30
	powerfmt@0.2.0
	proc-macro2@1.0.79
	quote@1.0.35
	redox_syscall@0.4.1
	redox_users@0.4.4
	rustix@0.38.32
	rustversion@1.0.14
	serde@1.0.197
	serde_derive@1.0.197
	slog-async@2.8.0
	slog-term@2.9.1
	slog@2.7.0
	strsim@0.11.0
	syn@2.0.53
	take_mut@0.2.2
	tempfile@3.10.1
	term@0.7.0
	terminal_size@0.3.0
	thiserror-impl@1.0.58
	thiserror@1.0.58
	thread_local@1.1.8
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	url@2.5.0
	utf8parse@0.2.1
	vcpkg@0.2.15
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.4
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.4
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.4
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.4
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.4
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.4
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.4
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.4
"

inherit cargo shell-completion

DESCRIPTION="Automatically absorb staged changes into git current branch"
HOMEPAGE="https://github.com/tummychow/git-absorb"
SRC_URI="${CARGO_CRATE_URIS}"
SRC_URI+=" https://github.com/tummychow/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
# Dependent crate licenses
LICENSE+=" MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-libs/libgit2-1.8:=
"
DEPEND="${RDEPEND}"

DOCS=( README.md )

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_compile() {
	export LIBGIT2_NO_VENDOR=1

	cargo_src_compile

	GIT_ABSORB_BIN="$(cargo_target_dir)/${PN}"

	# Prepare shell completion generation
	mkdir completions || die
	local shell
	for shell in bash fish zsh; do
		"${GIT_ABSORB_BIN}" --gen-completions \
					 ${shell} \
					 > completions/${PN}.${shell} \
			|| die
	done
}

src_install() {
	cargo_src_install
	doman Documentation/${PN}.1

	newbashcomp "completions/${PN}.bash" "${PN}"
	dofishcomp "completions/${PN}.fish"
	dozshcomp "completions/${PN}.zsh"

	default
}
