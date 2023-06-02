# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

PYTHON_COMPAT=( python{3_3,3_4,3_5,3_6,3_7,3_8,3_9,3_10,3_11} )

EGIT_REPO_URI="https://github.com/ffnord/${PN}.git"

inherit git-r3 systemd

DESCRIPTION="RespondD Status Scripts for Servers"
HOMEPAGE="https://github.com/ffnord/mesh-announce"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~powerpc ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

RDEPEND="dev-python/psutil
         sys-apps/ethtool
         sys-apps/lsb-release"

src_install() {
        systemd_dounit respondd.service
        rm respondd.service

        rm -rf .git*

        insinto /opt/${PN}
        doins -r .

        exeinto /opt/${PN}
        doexe respondd.py
        doexe announce.py
        doexe announce.sh

        newinitd "${FILESDIR}/respondd.init" respondd || die
        newconfd "${FILESDIR}/respondd.conf" respondd || die
}
