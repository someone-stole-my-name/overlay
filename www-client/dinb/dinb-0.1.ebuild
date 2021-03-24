# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module desktop xdg-utils

DESCRIPTION="Thin layer around xdg to open URLs with specific browsers"
HOMEPAGE="https://github.com/someone-stole-my-name/dinb"
SRC_URI="https://github.com/someone-stole-my-name/dinb/archive/refs/tags/${PV}.tar.gz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-perl/MooseX-App
	dev-perl/File-HomeDir
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"

src_install() {
	perl-module_src_install
	domenu dinb.desktop
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
