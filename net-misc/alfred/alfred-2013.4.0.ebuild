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
IUSE="gpsd +visd"

DEPEND="gpsd? ( sci-geosciences/gpsd )"
##RDEPEND=""

src_compile() {
	local myconf

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
	local myconf

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

        dodoc README CHANGELOG
}
