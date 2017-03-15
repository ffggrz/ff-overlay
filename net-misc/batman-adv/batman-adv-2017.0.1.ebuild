# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CONFIG_CHECK="~!BATMAN_ADV ~LIBCRC32C ~CRC16"
##MODULE_NAMES="${PN}(net:${S}:${S}/net/${PN})"
MODULE_NAMES="${PN}(net:${S}:${S}/build/net/${PN})"
BUILD_TARGETS="all"

inherit eutils linux-mod

DESCRIPTION="Better approach to mobile Ad-Hoc networking on layer 2 kernel module"
HOMEPAGE="http://www.open-mesh.org/"
SRC_URI="http://downloads.open-mesh.org/batman/stable/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="batmanv bla dat debug hardened nc mcast"

DEPEND=""
RDEPEND=""

src_prepare() {
        epatch "${FILESDIR}"/decrease-maximum-fragment-size-${PV}.patch
        if use hardened; then
                epatch "${FILESDIR}"/grsecurity-${PV}.patch
        fi
}

src_compile() {
	BUILD_PARAMS="CONFIG_BATMAN_ADV_DEBUG=$(usex debug y n)"
	BUILD_PARAMS+=" CONFIG_BATMAN_ADV_BLA=$(usex bla y n)"
	BUILD_PARAMS+=" CONFIG_BATMAN_ADV_DAT=$(usex dat y n)"
	BUILD_PARAMS+=" CONFIG_BATMAN_ADV_NC=$(usex nc y n)"
	BUILD_PARAMS+=" CONFIG_BATMAN_ADV_MCAST=$(usex mcast y n)"
	BUILD_PARAMS+=" CONFIG_BATMAN_ADV_BATMAN_V=$(usex batmanv y n)"
	export BUILD_PARAMS
	export KERNELPATH="${KERNEL_DIR}"
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dodoc README CHANGELOG
}
