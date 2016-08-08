# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

##PYTHON_COMPAT=( python2_7 python3_{3,4,5} )
PYTHON_COMPAT=( python2_7 )

EGIT_REPO_URI="https://github.com/wlanslovenija/${PN}.git"

inherit distutils-r1 linux-info git-r3

DESCRIPTION="Simple VPN tunneling solution based on L2TPv3 tunnels"
HOMEPAGE="http://tunneldigger.readthedocs.io/en/latest/"

LICENSE="AGPL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="+broker client +doc"

RDEPEND="net-libs/libnetfilter_conntrack
         dev-python/python-iptables
         dev-python/python-netfilter"

CONFIG_CHECK="~L2TP_ETH"
ERROR_L2TP_ETH="${PN} requires support for carrying raw ethernet frames over L2TPv3 in your kernel (module name: l2tp_eth)".

src_prepare() {
        cp ${FILESDIR}/setup.py ${S}
        mkdir ${S}/bin
        cp ${FILESDIR}/tunneldigger-broker ${S}/bin/
}

src_compile() {
        if use broker; then
                distutils-r1_src_compile
        fi

        if use client; then
                cd ${S}/client
                emake || die
        fi

        if use doc; then
                cd ${S}/docs
                emake || die
        fi
}

src_install() {
        if use broker; then
                distutils-r1_src_install
        fi

        if use client; then
                cd ${S}/client
                emake install || die
        fi


##        doman doc/qr.1
}

##src_install() {
##
##        rm -rf .git*
##
##        insinto /opt/${PN}
##        doins -r .
##
##        exeinto /opt/${PN}
##        doexe announce.{py,sh}
##
##        # Add cron.d script
##        insinto /etc/cron.d
##        newins "${FILESDIR}/${PN}.cron" ${PN}
##        fperms 644 /etc/cron.d/${PN}
##
##        dodir /etc/env.d
##        echo "CONFIG_PROTECT=/opt/${PN}/config.json" >> "${ED}"/etc/env.d/30${PN}
##}
