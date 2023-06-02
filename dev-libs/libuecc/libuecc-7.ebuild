# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

EGIT_REPO_URI="git://git.universe-factory.net/libuecc.git"

inherit cmake
[[ ${PV} == *9999* ]] && inherit git-2

DESCRIPTION="Very small elliptic curve cryptography library"
HOMEPAGE="http://git.universe-factory.net/libuecc/"
[[ ${PV} == *9999* ]] || \
SRC_URI="https://projects.universe-factory.net/attachments/download/85/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
[[ ${PV} == *9999* ]] || \
KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~powerpc ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

