# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4} )

EGIT_REPO_URI="https://github.com/ffggrz/${PN}.git"

inherit git-r3

DESCRIPTION="RespondD Status Scripts for Servers"
HOMEPAGE="https://github.com/ffggrz/ext-respondd"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~powerpc ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

RDEPEND="dev-python/netifaces
         sys-apps/ethtool
         sys-apps/lsb-release"

src_install() {

        rm -rf .git*

        insinto /opt/${PN}
        doins -r .

        exeinto /opt/${PN}
        doexe ${PN}.py

        newinitd "${FILESDIR}/${PN}.init" ${PN} || die

        dodir /etc/env.d
        echo "CONFIG_PROTECT=\"/opt/${PN}/alias.json /opt/${PN}/config.json\"" >> "${ED}"/etc/env.d/30${PN}
}
