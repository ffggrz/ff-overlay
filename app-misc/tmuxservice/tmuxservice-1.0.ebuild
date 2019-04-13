EAPI="6"

inherit systemd

DESCRIPTION="Start tmux sessions as a service"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 sparc-fbsd x86-fbsd hppa-hpux amd64-linux x86-linux ppc-macos x64-macos x86-macos sparc-solaris sparc64-solaris x64-solaris x86-solaris"
RDEPEND="app-misc/tmux
         app-misc/mc"
DEPEND="${RDEPEND}"
S=${WORKDIR}

src_install() {
	einfo "Install systemd service"
	systemd_newunit "${FILESDIR}"/tmux.service tmux@.service
	systemd_install_serviced "${FILESDIR}"/tmux.service.conf tmux@.service

	einfo "Install init scripts"
	newinitd "${FILESDIR}"/tmux-initd tmux
	newconfd "${FILESDIR}"/tmux-confd tmux
}
