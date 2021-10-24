# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop wrapper xdg

MY_PN=${PN/-/_}

DESCRIPTION="A new Git Client, from the creators of Sublime Text"
HOMEPAGE="https://www.sublimemerge.com"
SRC_URI="
	amd64? ( https://download.sublimetext.com/${MY_PN}_build_${PV}_x64.tar.xz )
"

LICENSE="Sublime"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dbus"
RESTRICT="bindist mirror strip"

BDEPEND="
	dev-util/bsdiff
"
RDEPEND="
	dev-vcs/git
	dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/libX11
	dbus? ( sys-apps/dbus )
"

PATCHES=(
	"${FILESDIR}"/${PN}-2062-set-explicit-startupwmclass-in-launcher.patch
)

QA_PREBUILD="*"
S="${WORKDIR}/${MY_PN}"

src_prepare(){
	default
	sed -i -e "/OnlyShowIn/d" "${MY_PN}.desktop"
	
	bspatch "${S}/sublime_merge" "${S}/_sublime_merge" "${FILESDIR}/${PV}.bsdiff" ||\
		die "Cannot apply ${PV} patch"
	mv "${S}/_sublime_merge" "${S}/sublime_merge"
}

src_install(){
	insinto /opt/${MY_PN}
	doins -r Packages Icon
	doins changelog.txt sublime_merge.desktop

	exeinto /opt/${MY_PN}
	doexe crash_reporter git-credential-sublime ssh-askpass-sublime sublime_merge

	make_wrapper smerge "/opt/${MY_PN}/sublime_merge"
	domenu sublime_merge.desktop

	local size
	for size in 16 32 48 128 256; do
		doicon --size "${size}" Icon/${size}x${size}/${PN}.png
	done
	
}
