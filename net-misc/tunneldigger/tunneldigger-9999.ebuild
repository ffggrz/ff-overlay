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

RDEPEND="client? ( dev-libs/libnl:3 )
         broker? ( net-libs/libnetfilter_conntrack
                   dev-python/python-iptables
                   dev-python/python-netfilter )
         doc? ( dev-python/sphinx )"

CONFIG_CHECK="~L2TP_ETH"
ERROR_L2TP_ETH="${PN} requires support for carrying raw ethernet frames over L2TPv3 in your kernel (module name: l2tp_eth)".

src_prepare() {
        if use broker; then
                epatch ${FILESDIR}/tunneldigger-conntrack-defparam.diff
                epatch ${FILESDIR}/tunneldigger-logging-timestamp.diff
                cp ${FILESDIR}/setup.py ${S}
                mkdir ${S}/bin
                cp ${FILESDIR}/tunneldigger-broker ${S}/bin/
        fi
        if use client; then
               sed -e "s|-lnl|-lnl-3 -lnl-genl-3|g" -i ${S}/client/Makefile \
                       || die "failed to use libnl-3"
        fi
}

src_compile() {
        if use broker; then
                distutils-r1_src_compile
        fi

        if use client; then
                cd ${S}/client
                emake CFLAGS="${CFLAGS} -I/usr/include/libnl3/ -DLIBNL_TINY" || die
        fi

        if use doc; then
                cd ${S}/docs
                emake man || die
        fi
}

src_install() {
        if use broker; then
                distutils-r1_src_install
                newinitd "${FILESDIR}/${PN}.init" tunneldigger || die
        fi

        if use client; then
                dobin ${S}/client/l2tp_client
        fi

        if use doc; then
                doman ${S}/docs/_build/man/tunneldigger.1
        fi
}