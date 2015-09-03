# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4} )

EGIT_REPO_URI="https://github.com/ffnord/ffnord-${PN}.git"

inherit git-2

DESCRIPTION="Alfred Status Scripts for Servers"
HOMEPAGE="https://github.com/ffnord/ffnord-alfred-announce"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~powerpc ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

RDEPEND="
	net-misc/alfred
	sys-apps/ethtool
	sys-apps/lsb-release
"

src_install() {

        rm -rf .git*

        insinto /opt/${PN}
        doins -r .

        exeinto /opt/${PN}
        doexe announce.{py,sh}

#        # Add cron.d script
#        insinto /etc/cron.d
#        newins "${FILESDIR}/${PN}.cron" ${PN}
#        fperms 660 /etc/cron.d/${PN}

}

