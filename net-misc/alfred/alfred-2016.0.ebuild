# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

##inherit eutils

DESCRIPTION=""
HOMEPAGE="http://www.open-mesh.org/"
SRC_URI="http://downloads.open-mesh.org/batman/stable/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+caps gpsd +visd"

DEPEND="caps? ( >=sys-libs/libcap-2.23 )
        gpsd? ( sci-geosciences/gpsd )"

src_compile() {
##	local myconf="LIBCAP_LDLIBS=-lcap"
	local myconf

	if use caps; then
		myconf="${myconf} CONFIG_ALFRED_CAPABILITIES=y"
	else
		myconf="${myconf} CONFIG_ALFRED_CAPABILITIES=n"
	fi

	if use gpsd; then
		myconf="${myconf} CONFIG_ALFRED_GPSD=y"
	else
		myconf="${myconf} CONFIG_ALFRED_GPSD=n"
	fi

	if use visd; then
		myconf="${myconf} CONFIG_ALFRED_VIS=y"
	else
		myconf="${myconf} CONFIG_ALFRED_VIS=n"
	fi

	emake ${myconf} || die
}

src_install() {
##	local myconf="LIBCAP_LDLIBS=-lcap"
	local myconf

	if use caps; then
		myconf="${myconf} CONFIG_ALFRED_CAPABILITIES=y"
	else
		myconf="${myconf} CONFIG_ALFRED_CAPABILITIES=n"
	fi

	if use gpsd; then
		myconf="${myconf} CONFIG_ALFRED_GPSD=y"
	else
		myconf="${myconf} CONFIG_ALFRED_GPSD=n"
	fi

	if use visd; then
		myconf="${myconf} CONFIG_ALFRED_VIS=y"
	else
		myconf="${myconf} CONFIG_ALFRED_VIS=n"
	fi

	emake DESTDIR="${D}" PREFIX="/usr" ${myconf} install || die

	newinitd "${FILESDIR}/${PN}.init" ${PN} || die
	newconfd "${FILESDIR}/${PN}.conf" ${PN} || die

	dodoc README CHANGELOG
}
