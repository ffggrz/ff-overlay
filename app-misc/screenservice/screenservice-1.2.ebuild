EAPI="5"

inherit systemd

DESCRIPTION="Start Screen sessions as a service"
HOMEPAGE="https://bugs.gentoo.org/show_bug.cgi?id=381451"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 sparc-fbsd x86-fbsd hppa-hpux amd64-linux x86-linux ppc-macos x64-macos x86-macos sparc-solaris sparc64-solaris x64-solaris x86-solaris"
RDEPEND="app-misc/screen
         app-misc/mc[-slang]"
DEPEND="${RDEPEND}"
S=${WORKDIR}

src_install() {
	systemd_newunit "${FILESDIR}/screen.service" screen@.service
	newinitd "${FILESDIR}/screen.init" screen || die

	insinto /etc/screen.d
	newins "${FILESDIR}/screen-adm" screen-adm
}
