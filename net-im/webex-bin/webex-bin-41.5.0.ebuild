# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit rpm desktop

DESCRIPTION="Webex for Linux"
HOMEPAGE="https://www.webex.com"
SRC_URI="Webex_41.5.0.18705.rpm"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}"
RESTRICT="fetch strip"
MY_PN="Webex"

pkg_nofetch() {
    einfo "Please download ${A} from the following URL:"
    einfo "https://drive.google.com/drive/u/1/folders/1PJpWiWovaxWrgE6XUEoDnwGzhnshJCnd"
    einfo ""
    einfo "download file named ${SRC_URI} and place it into"
    einfo " your DISTDIR directory."
}

src_install() {
    insinto "/opt/${MY_PN}"
    exeinto "/opt/${MY_PN}/bin"
    doins -r \
        "${WORKDIR}/opt/Webex/bin" \
        "${WORKDIR}/opt/Webex/lib" \
        "${WORKDIR}/opt/Webex/qml"
    
    doexe "${WORKDIR}/opt/Webex/bin/CiscoCollabHost"
    doexe "${WORKDIR}/opt/Webex/bin/CiscoCollabHostCef"
    doexe "${WORKDIR}/opt/Webex/bin/CiscoCollabHostCefWM"
    
    dosym "/opt/${MY_PN}/bin/CiscoCollabHost" "/usr/bin/webex-bin"
    domenu "${WORKDIR}/opt/Webex/bin"
}

pkg_postinst()
{
    xdg_desktop_database_update
    xdg_icon_cache_update
    xdg_mimeinfo_database_update
}
