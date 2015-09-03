# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

inherit cmake-utils

DESCRIPTION=""
HOMEPAGE="https://github.com/tcatm/alfred-json"
SRC_URI="https://github.com/tcatm/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
##IUSE="gpsd +visd"

DEPEND="dev-libs/jansson
        sys-libs/zlib"

##RDEPEND=""

##src_compile() {
##
##	emake ${myconf} || die
##}

##src_install() {
##
##	emake DESTDIR="${D}" PREFIX="/usr" ${myconf} install || die
##
##        dodoc README CHANGELOG
##}
