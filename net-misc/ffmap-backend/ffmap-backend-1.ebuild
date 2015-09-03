# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

EGIT_REPO_URI="https://github.com/ffnord/${PN}.git"

[[ ${PV} == *9999* ]] && inherit git-2

DESCRIPTION="Data for Freifunk Map, Graph and Node List"
HOMEPAGE="https://github.com/ffnord/ffmap-backend"
[[ ${PV} == *9999* ]] || \
SRC_URI="https://github.com/ffnord/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

[[ ${PV} == *9999* ]] || \
KEYWORDS="~amd64 ~x86"

IUSE="rrd"

DEPEND="dev-python/networkx
        net-misc/alfred
        net-misc/alfred-json
        rrd? ( net-analyzer/rrdtool )"

src_install() {

        rm -rf .git*
        rm .travis.yml

        insinto /opt/${PN}
        doins -r .

        exeinto /opt/${PN}
        doexe backend.py

        dodir /opt/${PN}/data

        # Add cron.d script
        insinto /etc/cron.d
        newins "${FILESDIR}/${PN}.cron" ${PN}
        fperms 644 /etc/cron.d/${PN}

}
