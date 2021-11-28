# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI=7

inherit cmake cmake-utils xdg

DESCRIPTION="Desktop GUI client for browsing Geminispace"
HOMEPAGE="https://gmi.skyjake.fi/lagrange/"
SRC_URI="https://github.com/skyjake/$PN/releases/download/v$PV/$P.tar.gz"
IUSE="cpu_flags_x86_sse4_1 +ipc +webp +mp3 +fribidi +harfbuzz +ipc +kerning swrender"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~mips ppc ppc64 sparc x86"
RDEPEND="
	media-libs/libsdl2
	dev-libs/openssl
	dev-libs/libpcre
	sys-libs/zlib
	dev-libs/libunistring
	mp3? ( media-sound/mpg123 )
	webp? ( media-libs/libwebp )
	fribidi? ( dev-libs/fribidi )
	harfbuzz? ( media-libs/harfbuzz:=[truetype(+)] )
"
BDEPEND="app-arch/zip"

src_prepare() {
	eapply_user
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_MPG123=$(usex mp3)
		-DENABLE_WEBP=$(usex webp)
		-DENABLE_FRIBIDI=$(usex fribidi)
		-DENABLE_HARFBUZZ=$(usex harfbuzz)
		-DENABLE_IPC=$(usex ipc)
		-DENABLE_KERNING=$(usex kerning)
		-DENABLE_X11_SWRENDER=$(usex swrender)
		# No bundled libs
		-DENABLE_FRIBIDI_BUILD=NO
		-DENABLE_HARFBUZZ_MINIMAL=NO
		# Default features
		-DENABLE_DOWNLOAD=YES
		-DTFDN_ENABLE_WARN_ERROR=NO
		-DTFDN_ENABLE_SSE41=$(usex cpu_flags_x86_sse4_1)
	)
	cmake_src_configure
}

pkg_postinst(){
	xdg_pkg_postinst
}

pkg_postrm(){
	xdg_pkg_postrm
}
