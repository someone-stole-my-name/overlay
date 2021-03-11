# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
GNOME2_LA_PUNT="yes"
GNOME2_EAUTORECONF="yes"

inherit gnome2 git-r3 autotools

DESCRIPTION="NetworkManager Fortinet SSLVPN compatible plugin"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"

EGIT_COMMIT=9688d63ecacec97d0c9217281eb7b85053f1f4a1
EGIT_REPO_URI=https://gitlab.gnome.org/emelenas/NetworkManager-fortisslvpn.git
SRC_URI=
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk"

RDEPEND="
	>=net-misc/networkmanager-1.2:=
	>=dev-libs/glib-2.32:2
	net-dialup/ppp:=
	>=net-vpn/openfortivpn-1.2.0
	gtk? (
		>=app-crypt/libsecret-0.18
		>=net-libs/libnma-1.2.0
		>=x11-libs/gtk+-3.4:3
	)
"
DEPEND="${RDEPEND}
	dev-util/gdbus-codegen
	>=sys-devel/gettext-0.19
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure \
		--disable-static \
		--with-dist-version=Gentoo \
		--localstatedir=/var \
		$(use_with gtk gnome) \
		--without-libnm-glib
}
