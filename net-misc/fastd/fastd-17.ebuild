# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://git.universe-factory.net/fastd.git"

inherit cmake-utils
[[ ${PV} == *9999* ]] && inherit git-2

DESCRIPTION="Fast and secure tunneling daemon with very small binary"
HOMEPAGE="https://projects.universe-factory.net/projects/fastd/wiki"
[[ ${PV} == *9999* ]] || \
SRC_URI="http://git.universe-factory.net/fastd/snapshot/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
[[ ${PV} == *9999* ]] || \
KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~powerpc ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

IUSE="doc lto +openssl systemd"

RDEPEND="
	sys-libs/libcap
	dev-libs/libsodium
	dev-libs/json-c
	>=dev-libs/libuecc-5
	openssl? ( dev-libs/openssl )
"

DEPEND="
	>=sys-devel/bison-2.5.0
	dev-util/cmake
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )
"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
        # Segfault with -O2
        replace-flags -O[2-9] -O1

        use doc || sed -e "s/include(UseDoxygen OPTIONAL)/# include(UseDoxygen OPTIONAL)/" -i CMakeLists.txt

        mycmakeargs=(
                $(cmake-utils_use lto ENABLE_LTO)
                $(cmake-utils_use openssl ENABLE_OPENSSL)
                $(cmake-utils_use systemd ENABLE_SYSTEMD)
        )

        cmake-utils_src_configure
}

src_install() {
        cd "${CMAKE_BUILD_DIR}" || die
    emake DESTDIR="${D}" install
        cd "${S}" || die
    dodoc README COPYRIGHT
        doman doc/fastd.1
}
