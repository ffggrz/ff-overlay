# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

EGIT_REPO_URI="https://github.com/NeoRaider/fastd.git"

inherit meson systemd
[[ ${PV} == *9999* ]] && inherit git-2

DESCRIPTION="Fast and secure tunneling daemon with very small binary"
HOMEPAGE="https://github.com/NeoRaider/fastd/wiki"
[[ ${PV} == *9999* ]] || \
SRC_URI="https://github.com/NeoRaider/fastd/releases/download/v${PV}/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
[[ ${PV} == *9999* ]] || \
KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~powerpc ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

IUSE="doc systemd"

RDEPEND="
	sys-libs/libcap
	dev-libs/libsodium
	dev-libs/json-c
	>=dev-libs/libuecc-6
	dev-libs/openssl
"

DEPEND="
	>=sys-devel/bison-2.5.0
	dev-util/cmake
	doc? ( app-doc/doxygen )
"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		-Db_lto=true
		-Dsystemd=$(usex systemd enabled disabled)
	)
	meson_src_configure
}

src_install() {
        meson_src_install
        newinitd "${FILESDIR}/${PN}.init" fastd || die
        systemd_dounit "doc/examples/fastd@.service"
        dodoc README.md
        doman doc/fastd.1
}
