# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="Stubby program user (from net-dns/getdns)"
ACCT_USER_ID=476
ACCT_USER_GROUPS=( stubby )

acct-user_add_deps
