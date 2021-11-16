# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
inherit toolchain-funcs
DESCRIPTION="A BBS terminal program from Synchronet Project"
HOMEPAGE="https://syncterm.bbsdev.net/"
SRC_URI="https://sourceforge.net/projects/${PN}/files/${PN}/${P}/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

DEPEND="${RDEPEND}"
RDEPEND="
		>=sys-libs/ncurses-6.2_p20210619
"

S="${WORKDIR}/${P}/src/${PN}"

src_compile(){
	#Won't compile without it?
	emake -j1
}

src_install(){
	emake -j1 DESTDIR="${D}" PREFIX='/usr' MANPREFIX='${PREFIX}/share' install
}
